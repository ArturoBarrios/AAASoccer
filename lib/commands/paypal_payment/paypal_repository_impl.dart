import 'package:soccermadeeasy/commands/paypal_payment/models/paypal_error/error_response.dart';

import '../cache/credential_repository.dart';
import '../network/types/either.dart';
import '../network/types/failure.dart';
import '../network/types/server_failure.dart';
import '../network/util/api_util.dart';
import 'models/request/orders/paypal_create_order_request.dart';
import 'models/response/authentication/paypal_access_token_response.dart';
import 'models/response/orders/paypal_capture_payment_for_order_response.dart';
import 'models/response/orders/paypal_create_order_response.dart';
import 'paypal_data_source/paypal_data_source_remote.dart';
import 'paypal_repository.dart';

///
class PaypalRepositoryImpl implements PaypalRepository {
  ///
  PaypalRepositoryImpl({
    required final PaypalDataSourceRemote remoteDataSource,
    required final CredentialsRepository credentialsRepository,
  })  : _remoteDataSource = remoteDataSource,
        _credentialsRepository = credentialsRepository;

  final PaypalDataSourceRemote _remoteDataSource;

  final CredentialsRepository _credentialsRepository;

  @override
  Future<Either<Failure, PaypalAccessTokenResponse?>>
      fetchAccessToken() async => mapApiResponse<PaypalAccessTokenResponse,
              ErrorResponse, PaypalAccessTokenResponse?>(
            request: _remoteDataSource.fetchAccessToken(),
            mapFailure: (final content) =>
                Left(ServerFailure(message: content?.message ?? '')),
            mapData: (final content) async {
              final accessToken = content?.accessToken;

              if (accessToken != null) {
                return Right(content);
              }

              return const Left(
                ServerFailure(message: 'Token null'),
              );
            },
          );

  @override
  Future<Either<Failure, PaypalCreateOrderResponse?>> createOrder(
      {required final PaypalCreateOrderRequest order}) async {
    final result = _credentialsRepository.paypalAccessTokenExpiresInValue;
    return mapApiResponse<PaypalCreateOrderResponse, ErrorResponse,
        PaypalCreateOrderResponse?>(
      request: _remoteDataSource.createOrder(
        body: order,
        tokenExp: result,
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
  }

  @override
  Future<Either<Failure, PaypalCapturePaymentForOrderResponse?>>
      capturePaymentForOrder({required final String orderId}) async {
    final result = _credentialsRepository.paypalAccessTokenExpiresInValue;

    return mapApiResponse<PaypalCapturePaymentForOrderResponse, ErrorResponse,
        PaypalCapturePaymentForOrderResponse?>(
      request: _remoteDataSource.capturePaymentForOrder(
          orderId: orderId, tokenExp: result),
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
}
