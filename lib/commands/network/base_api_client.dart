import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import 'util/api_graphql_operation_type.dart';
import 'util/api_response.dart';

class BaseApiClient {
  Future<ApiResponse<T, U>> graphqlRequest<T, U>({
    required final ApiGraphqlOperationType operationType,
    required final String operationName,
    required final String fields,
    final String body = '',
    final T Function(Map<String, dynamic>)? fromJson,
    final U Function(Map<String, dynamic>)? fromJsonError,
  }) async =>
      _request(
        method: 'POST',
        fromJson: fromJson,
        fromJsonError: fromJsonError,
        body: jsonEncode(<String, String>{
          'query': '${operationType.name}'
              '{ $operationName(\n$body)\n'
              '{ $fields } }',
        }),
      );

  Future<ApiResponse<T, U>> _request<T, U>({
    required final String method,
    final T Function(Map<String, dynamic>)? fromJson,
    final U Function(Map<String, dynamic>)? fromJsonError,
    final String? path,
    final Map<String, dynamic>? queryParameters,
    final String? body,
    final bool followRedirects = true,
    final String operationName = '',
  }) async {
    try {
      final uri = Uri.parse('https://graphql.fauna.com/graphql');

      final request = http.Request(
        method,
        uri,
      )..followRedirects = followRedirects;

      request.headers.addAll(
        <String, String>{
          'Authorization': 'Bearer ${dotenv.env['FAUNADBSECRET']}',
          'Content-Type': 'application/json'
        },
      );

      if (body != null) {
        request.body = body;
      }

      final response = await http.Response.fromStream(
        await http.Client().send(request),
      ).timeout(
        const Duration(seconds: 15),
        onTimeout: () => http.Response(
          'Timeout',
          HttpStatus.requestTimeout,
        ),
      );

      final message =
          'RESPONSE: ${response.request?.method} ${response.statusCode} '
          '${Uri.decodeQueryComponent(response.request?.url.toString() ?? '')}'
          '\n${response.body}';

      log(message);

      final responseBody = utf8.decode(response.bodyBytes);
      final Object? responseObject = responseBody.startsWith(RegExp(r'{|\['))
          ? jsonDecode(responseBody)
          : responseBody;

      if (response.statusCode >= HttpStatus.badRequest) {
        return ApiResponseError<T, U>(
          message: message,
          isSocketException: false,
          content: responseObject is Map<String, dynamic>
              ? fromJsonError?.call(responseObject)
              : null,
          statusCode: response.statusCode,
        );
      }

      final responseObjectJson = responseObject is Map<String, dynamic>
          ? (operationName.isEmpty
              ? responseObject
              : ((responseObject['data']
                      as Map<String, dynamic>?)?[operationName]
                  as Map<String, dynamic>?))
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
    } on http.ClientException catch (error) {
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
}
