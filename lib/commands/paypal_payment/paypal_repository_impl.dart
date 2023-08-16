import 'package:soccermadeeasy/commands/paypal_payment/models/paypal_error/error_response.dart';
import 'package:soccermadeeasy/commands/paypal_payment/util/api_util.dart';

import 'models/request/orders/paypal_create_order_request.dart';
import 'models/response/orders/paypal_capture_payment_for_order_response.dart';
import 'models/response/orders/paypal_create_order_response.dart';
import 'paypal_data_source/paypal_data_source_remote.dart';
import 'paypal_repository.dart';
import 'types/either.dart';
import 'types/failure.dart';
import 'types/server_failure.dart';

///
class PaypalRepositoryImpl implements PaypalRepository {
  ///
  PaypalRepositoryImpl({
    required final PaypalDataSourceRemote remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  final PaypalDataSourceRemote _remoteDataSource;

  @override
  Future<Either<Failure, PaypalCreateOrderResponse?>> createOrder(
          {required final PaypalCreateOrderRequest order}) async =>
      mapApiResponse<PaypalCreateOrderResponse, ErrorResponse,
          PaypalCreateOrderResponse?>(
        request: _remoteDataSource.createOrder(
          body: order,
        ),
        mapFailure: (final content) =>
            Left(ServerFailure(message: content?.message ?? '')),
        mapData: (final content) => content?.status != 'CREATED'
            ? const Left(
                ServerFailure(message: 'Something went wrong!'),
              )
            : Right(
                content,
              ),
      );

  @override
  Future<Either<Failure, PaypalCapturePaymentForOrderResponse?>>
      capturePaymentForOrder({required final String orderId}) async =>
          mapApiResponse<PaypalCapturePaymentForOrderResponse, ErrorResponse,
              PaypalCapturePaymentForOrderResponse?>(
            request: _remoteDataSource.capturePaymentForOrder(orderId: orderId),
            mapFailure: (final content) =>
                Left(ServerFailure(message: content?.message ?? '')),
            mapData: (final content) => content?.status != 'COMPLETED'
                ? const Left(
                    ServerFailure(message: 'Something went wrong!'),
                  )
                : Right(
                    content,
                  ),
          );
}
