import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:http/http.dart';

import 'api_response.dart';

/// [ApiClient].
abstract class ApiClient {
  /// POST call with error handling.
  Future<ApiResponse<T, U>> post<T, U>({
    required final String path,
    final T Function(Map<String, dynamic>)? fromJson,
    final U Function(Map<String, dynamic>)? fromJsonError,
    final Map<String, dynamic>? body,
    final int? tokenExp,
    final Map<String, dynamic>? queryParameters,
    final Map<String, String>? headers,
  });
}

/// [ApiClientImpl].
class ApiClientImpl implements ApiClient {
  /// [ApiClientImpl].
  ApiClientImpl({
    required final String baseURL,
    final Future<Map<String, String>?> Function()? headers,
    final Map<String, dynamic>? queryParameters,
    final bool Function(BaseResponse response)? retryWhen,
    this.refreshToken,
  })  : _baseURL = baseURL,
        _headers = headers,
        _queryParameters = queryParameters;

  final String _baseURL;
  final Future<Map<String, String>?> Function()? _headers;
  final Map<String, dynamic>? _queryParameters;

  /// Called when the token needs to be refreshed.
  Future<void> Function()? refreshToken;

  static const _timeoutSeconds = 15;

  @override
  Future<ApiResponse<T, U>> post<T, U>({
    required final String path,
    final T Function(Map<String, dynamic>)? fromJson,
    final U Function(Map<String, dynamic>)? fromJsonError,
    final Map<String, dynamic>? body,
    final int? tokenExp,
    final Map<String, dynamic>? queryParameters,
    final Map<String, String>? headers,
    final String filePath = '',
    final bool isMultipartRequest = false,
  }) async =>
      _request(
        headers: headers,
        path: path,
        body: body,
        method: 'POST',
        tokenExp: tokenExp,
        isMultipartRequest: isMultipartRequest,
        filePath: filePath,
        fromJson: fromJson,
        fromJsonError: fromJsonError,
        queryParameters: queryParameters,
      );

  // ignore: long-method, TODO: fix later.
  Future<ApiResponse<T, U>> _request<T, U>({
    required final Map<String, String>? headers,
    required final String method,
    final T Function(Map<String, dynamic>)? fromJson,
    final U Function(Map<String, dynamic>)? fromJsonError,
    final String? path,
    final Map<String, dynamic>? queryParameters,
    final Map<String, dynamic>? body,
    final bool followRedirects = true,
    final Uint8List? bytes,
    final String operationName = '',
    final bool refreshOnUnauthenticated = true,
    final String filePath = '',
    final bool isMultipartRequest = false,
    int? tokenExp,
  }) async {
    try {
      final getHeaders = _headers?.call();
      var uriHeaders = <String, String>{
        ...await getHeaders ?? <String, String>{},
        ...headers ?? <String, String>{},
      };
      final jsonBody = body == null
          ? null
          : uriHeaders[HttpHeaders.contentTypeHeader] ==
                  'application/x-www-form-urlencoded'
              ? _combineEncodedBody(body)
              : jsonEncode(body);

      if (_isTokenExpired(tokenExp)) {
        await refreshToken?.call();
        uriHeaders = <String, String>{
          ...await getHeaders ?? <String, String>{},
          ...headers ?? <String, String>{},
        };
      }
      final uri = Uri(
        scheme: 'https',
        host: _baseURL,
        path: path != null ? '/$path' : '',
        queryParameters: <String, String>{
          ...queryParameters != null
              ? queryParameters as Map<String, String>? ?? {}
              : {},
          ..._queryParameters != null
              ? _queryParameters as Map<String, String>? ?? {}
              : {},
        },
      );

      final request = Request(
        method,
        uri,
      )..followRedirects = followRedirects;

      request.headers.addAll(uriHeaders);
      if (jsonBody != null) {
        request.body = jsonBody;
      }

      if (bytes != null) {
        request.bodyBytes = bytes;
      }

      final response = await Response.fromStream(
        await Client().send(request),
      ).timeout(
        const Duration(seconds: _timeoutSeconds),
        onTimeout: () => Response(
          'Timeout',
          HttpStatus.requestTimeout,
        ),
      );
      final message =
          'RESPONSE: ${response.request?.method} ${response.statusCode} '
          '${Uri.decodeQueryComponent(response.request?.url.toString() ?? '')}'
          '\n${response.body}';

      log(message);

      // TODO test below doesn't execute and remove.
      if (response.statusCode == HttpStatus.unauthorized &&
          refreshOnUnauthenticated &&
          refreshToken != null) {
        await refreshToken?.call();

        return _request(
          refreshOnUnauthenticated: false,
          headers: headers,
          method: method,
          fromJson: fromJson,
          fromJsonError: fromJsonError,
          path: path,
          queryParameters: queryParameters,
          body: body,
          followRedirects: followRedirects,
          bytes: bytes,
          operationName: operationName,
        );
      }
      final responseBody = utf8.decode(response.bodyBytes);
      final Object? responseObject = responseBody.startsWith(RegExp(r'{|\['))
          ? jsonDecode(responseBody)
          : responseBody;

      if (response.statusCode >= HttpStatus.badRequest) {
        if ((response.statusCode == HttpStatus.unauthorized) ||
            (response.statusCode != HttpStatus.unauthorized &&
                response.statusCode != HttpStatus.notFound)) {}

        return ApiResponseError<T, U>(
          message: message,
          content: responseObject is Map<String, dynamic>
              ? fromJsonError?.call(responseObject)
              : null,
          statusCode: response.statusCode,
          isSocketException: false,
        );
      }

      final responseObjectJson = responseObject is Map<String, dynamic>
          ? (operationName.isEmpty
              ? responseObject
              : ((responseObject['data']
                      as Map<String, dynamic>?)?[operationName]
                  as Map<String, dynamic>?))
          : responseObject is List
              ? {'data': responseObject}
              : null;

      return ApiResponseData<T, U>(
        content: responseObjectJson != null
            ? fromJson?.call(responseObjectJson)
            : null,
        headers: response.headers,
        isRedirect: response.isRedirect,
        persistentConnection: response.persistentConnection,
        statusCode: response.statusCode,
      );
    } on SocketException catch (error) {
      return ApiResponseError<T, U>(
        message: error.message,
        isSocketException: true,
      );
    } on HttpException catch (error) {
      return ApiResponseError<T, U>(
        message: error.message,
        isSocketException: false,
      );
    } on ClientException catch (error) {
      return ApiResponseError<T, U>(
        message: error.message,
        isSocketException: false,
      );
    } on FormatException catch (error) {
      return ApiResponseError<T, U>(
        message: error.message,
        isSocketException: false,
      );
    } on Exception catch (error) {
      return ApiResponseError<T, U>(
        message: error.toString(),
        isSocketException: false,
      );
    }
  }

  String _combineEncodedBody(final Map<String, dynamic> body) => body.entries
      .map((final entry) => '${entry.key}=${entry.value}')
      .join('&');

  bool _isTokenExpired(int? timestamp) {
    if (timestamp == null) return false;

    final currentTimestamp = DateTime.now().millisecondsSinceEpoch;

    return timestamp <= currentTimestamp;
  }
}
