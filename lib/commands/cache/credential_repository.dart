import '../paypal_payment/types/either.dart';
import '../paypal_payment/types/failure.dart';

///
abstract class CredentialsRepository {
  /// Get paypal access token.
  Stream<String?> get paypalAccessToken;

  ///
  Stream<int?> get paypalAccessTokenExpiresIn;

  ///
  String? get paypalAccessTokenValue;

  ///
  int? get paypalAccessTokenExpiresInValue;

  /// Updates the paypal access token.
  Future<Either<Failure, void>> updatePaypalAccessToken(final String value);

  ///
  Future<Either<Failure, void>> updatePaypalAccessTokenExpiresIn(
      final int value);

  /// Deletes all data.
  Future<Either<Failure, void>> get deleteAll;
}
