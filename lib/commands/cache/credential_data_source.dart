import 'package:flutter_secure_storage/flutter_secure_storage.dart';

///
abstract class CredentialsDataSourceRepository {
  /// Get paypal access token.
  Future<String?> get paypalAccessToken;

  /// Get paypal access token expires in.
  Future<String?> get paypalAccessTokenExpiresIn;

  /// Deletes the access token.
  Future<void> get deletePaypalAccessToken;

  /// Deletes the access token expires in.
  Future<void> get deletePaypalAccessTokenExpiresIn;

  /// Updates the paypal access token.
  Future<void> updatePaypalAccessToken(final String value);

  /// Updates the paypal access token expires in.
  Future<void> updatePaypalAccessTokenExpiresIn(final int value);
}

///
class CredentialsDataSourceRepositoryImpl
    implements CredentialsDataSourceRepository {
  ///
  CredentialsDataSourceRepositoryImpl();

  final _secureStorage = const FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
  );

  static const _paypalAccessToken = 'paypalAccessToken';
  static const _paypalAccessTokenExpiresIn = 'paypalAccessTokenExpiresIn';

  @override
  Future<String?> get paypalAccessToken async =>
      _secureStorage.read(key: _paypalAccessToken);

  @override
  Future<String?> get paypalAccessTokenExpiresIn async =>
      _secureStorage.read(key: _paypalAccessTokenExpiresIn);

  @override
  Future<void> get deletePaypalAccessToken async =>
      _secureStorage.delete(key: _paypalAccessToken);

  @override
  Future<void> get deletePaypalAccessTokenExpiresIn async =>
      _secureStorage.delete(key: _paypalAccessTokenExpiresIn);

  @override
  Future<void> updatePaypalAccessToken(final String value) async =>
      _secureStorage.write(
        key: _paypalAccessToken,
        value: value,
      );

  @override
  Future<void> updatePaypalAccessTokenExpiresIn(final int value) async =>
      _secureStorage.write(
        key: _paypalAccessTokenExpiresIn,
        value: value.toString(),
      );
}
