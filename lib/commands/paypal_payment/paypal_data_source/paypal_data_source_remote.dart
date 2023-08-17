import 'package:soccermadeeasy/commands/paypal_payment/models/response/orders/paypal_capture_payment_for_order_response.dart';

import '../models/paypal_error/error_response.dart';
import '../models/request/orders/paypal_create_order_request.dart';
import '../models/response/orders/paypal_create_order_response.dart';
import '../util/api_client.dart';
import '../util/api_response.dart';

///
abstract class PaypalDataSourceRemote {
  /// Create order data source.
  Future<ApiResponse<PaypalCreateOrderResponse, ErrorResponse>> createOrder({
    required final PaypalCreateOrderRequest body,
  });

  /// Create order data source.
  Future<ApiResponse<PaypalCapturePaymentForOrderResponse, ErrorResponse>>
      capturePaymentForOrder({
    required final String orderId,
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
  Future<ApiResponse<PaypalCreateOrderResponse, ErrorResponse>> createOrder({
    required final PaypalCreateOrderRequest body,
  }) async =>
      _client.post(
        path: 'checkout/orders',
        body: body.toJson(),
        fromJson: (json) => PaypalCreateOrderResponse.fromJson(json),
        fromJsonError: (json) => ErrorResponse.fromJson(json),
      );

  @override
  Future<ApiResponse<PaypalCapturePaymentForOrderResponse, ErrorResponse>>
      capturePaymentForOrder({
    required final String orderId,
  }) async =>
          _client.post(
            path: 'checkout/orders/$orderId/capture',
            fromJson: (json) =>
                PaypalCapturePaymentForOrderResponse.fromJson(json),
            fromJsonError: (json) => ErrorResponse.fromJson(json),
          );
}
