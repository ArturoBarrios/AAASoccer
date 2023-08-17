import 'package:soccermadeeasy/commands/paypal_payment/models/response/orders/paypal_capture_payment_for_order_response.dart';
import 'package:soccermadeeasy/commands/paypal_payment/types/either.dart';
import 'package:soccermadeeasy/commands/paypal_payment/types/failure.dart';

import 'models/request/orders/paypal_create_order_request.dart';
import 'models/response/orders/paypal_create_order_response.dart';

abstract class PaypalRepository {
  /// Create order.
  Future<Either<Failure, PaypalCreateOrderResponse?>> createOrder(
      {required final PaypalCreateOrderRequest order});

  /// Capture payment for order.
  Future<Either<Failure, PaypalCapturePaymentForOrderResponse?>>
      capturePaymentForOrder({required final String orderId});
}
