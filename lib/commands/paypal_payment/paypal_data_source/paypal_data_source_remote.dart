import 'dart:convert';

import 'package:soccermadeeasy/commands/paypal_payment/models/request/authentication/paypal_access_token_request.dart';
import 'package:soccermadeeasy/commands/paypal_payment/models/response/authentication/paypal_access_token_response.dart';
import 'package:soccermadeeasy/commands/paypal_payment/models/response/orders/paypal_capture_payment_for_order_response.dart';

import '../../network/util/api_client.dart';
import '../../network/util/api_response.dart';
import '../models/paypal_error/error_response.dart';
import '../models/request/orders/paypal_create_order_request.dart';
import '../models/response/orders/paypal_create_order_response.dart';

///
abstract class PaypalDataSourceRemote {
  /// Fetch access token.
  Future<ApiResponse<PaypalAccessTokenResponse, ErrorResponse>>
      fetchAccessToken();

  /// Create order data source.
  Future<ApiResponse<PaypalCreateOrderResponse, ErrorResponse>> createOrder({
    required final PaypalCreateOrderRequest body,
    int? tokenExp,
  });

  /// Create order data source.
  Future<ApiResponse<PaypalCapturePaymentForOrderResponse, ErrorResponse>>
      capturePaymentForOrder({
    required final String orderId,
    int? tokenExp,
  });
}

///
class PaypalDataSourceRemoteImpl implements PaypalDataSourceRemote {
  ///
  PaypalDataSourceRemoteImpl({
    required final ApiClient client,
  }) : _client = client;

  final ApiClient _client;

  @override
  Future<ApiResponse<PaypalAccessTokenResponse, ErrorResponse>>
      fetchAccessToken() async => _client.post(
            path: 'v1/oauth2/token',
            body: const PaypalAccessTokenRequest().toJson(),
            headers: {
              'content-type': 'application/x-www-form-urlencoded',
              'Authorization':
                  'Basic ${base64Encode(utf8.encode('${Uri.encodeComponent('AYrw_sNt2TklWbNimkQfuhN33cKjpe5Nr5YilOUlhQL7Ak11KneN6KZOrAJMVAdbZW-G6LwQH74YaVMa')}:${Uri.encodeComponent('EIRK189Zqr6YFKNSPD3p8n2SStIhwYfW5yed2_jrjyEMh6OPg81JFwOR1yjJNxF04FJsziAMjkFOK2vF')}'))}',
            },
            fromJson: (json) => PaypalAccessTokenResponse.fromJson(json),
            fromJsonError: (json) => ErrorResponse.fromJson(json),
          );

  @override
  Future<ApiResponse<PaypalCreateOrderResponse, ErrorResponse>> createOrder({
    required final PaypalCreateOrderRequest body,
    int? tokenExp,
  }) async =>
      _client.post(
        path: 'v2/checkout/orders',
        body: body.toJson(),
        tokenExp: tokenExp,
        fromJson: (json) => PaypalCreateOrderResponse.fromJson(json),
        fromJsonError: (json) => ErrorResponse.fromJson(json),
      );

  @override
  Future<ApiResponse<PaypalCapturePaymentForOrderResponse, ErrorResponse>>
      capturePaymentForOrder({
    required final String orderId,
    int? tokenExp,
  }) async =>
          _client.post(
            path: 'v2/checkout/orders/$orderId/capture',
            tokenExp: tokenExp,
            fromJson: (json) =>
                PaypalCapturePaymentForOrderResponse.fromJson(json),
            fromJsonError: (json) => ErrorResponse.fromJson(json),
          );
}
