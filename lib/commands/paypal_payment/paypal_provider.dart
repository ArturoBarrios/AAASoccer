import 'package:soccermadeeasy/commands/paypal_payment/paypal_data_source/paypal_data_source_remote.dart';
import 'package:riverpod/riverpod.dart' as riverpod;

import '../cache/credential_data_source.dart';
import '../cache/credential_repository.dart';
import '../cache/credential_repository_impl.dart';
import '../network/util/api_client.dart';
import 'paypal_repository.dart';
import 'paypal_repository_impl.dart';

final _paypalApiClientProvider = riverpod.Provider.autoDispose<ApiClient>(
  (final ref) {
    String? lastToken;

    ref.watch(_credentialsRepositoryProvider).paypalAccessToken.listen((event) {
      lastToken = event;
    });

    final defaultApiClient = ApiClientImpl(
      baseURL: 'api-m.sandbox.paypal.com',
      headers: () async {
        final token = 'Bearer $lastToken';

        return <String, String>{
          'Content-Type': 'application/json',
          'Authorization': token,
        };
      },
    );

    final authenticationRepository = ref.watch(
      paypalRepositoryWithApiClientProvider(
        ref.watch(
          _authenticationDataSourceRemoteWithApiClientProvider(
            defaultApiClient,
          ),
        ),
      ),
    );

    return defaultApiClient
      ..refreshToken = () async {
        final resultDelete =
            await ref.watch(_credentialsRepositoryProvider).deleteAll;
        resultDelete.whenOrNull(
          right: (right) async {
            final result = await authenticationRepository.fetchAccessToken();
            result.whenOrNull(
              right: (right) async {
                await Future.wait([
                  ref
                      .watch(_credentialsRepositoryProvider)
                      .updatePaypalAccessToken(right?.accessToken ?? ''),
                  ref
                      .watch(_credentialsRepositoryProvider)
                      .updatePaypalAccessTokenExpiresIn(
                          _calculateTokenExpirationTimestamp(
                              right?.expiresIn ?? 0)),
                ]);
              },
            );
          },
        );
      };
  },
);

int _calculateTokenExpirationTimestamp(int seconds) {
  final expirationDuration = Duration(seconds: seconds);
  final currentDateTime = DateTime.now();

  final expirationDateTime = currentDateTime.add(expirationDuration);

  final expirationTimestamp = expirationDateTime.millisecondsSinceEpoch;

  return expirationTimestamp;
}

final _credentialsRepositoryProvider =
    riverpod.Provider.autoDispose<CredentialsRepository>(
  (final ref) => CredentialsRepositoryImpl(
    remoteDataSource: CredentialsDataSourceRepositoryImpl(),
  ),
);

final _authenticationDataSourceRemoteWithApiClientProvider =
    riverpod.Provider.autoDispose.family<PaypalDataSourceRemote, ApiClient>(
  (final ref, final apiClient) => PaypalDataSourceRemoteImpl(
    client: apiClient,
  ),
);

final _paypalDataSourceRemoteProvider =
    riverpod.Provider.autoDispose<PaypalDataSourceRemote>(
  (final ref) => ref.watch(
    _authenticationDataSourceRemoteWithApiClientProvider(
      ref.watch(_paypalApiClientProvider),
    ),
  ),
);

///
final paypalRepositoryWithApiClientProvider = riverpod.Provider.autoDispose
    .family<PaypalRepository, PaypalDataSourceRemote>(
  (final ref, final remoteDataSource) => PaypalRepositoryImpl(
    remoteDataSource: remoteDataSource,
    credentialsRepository: ref.watch(_credentialsRepositoryProvider),
  ),
);

///
final paypalRepositoryProvider =
    riverpod.Provider.autoDispose<PaypalRepository>(
  (final ref) => ref.watch(
    paypalRepositoryWithApiClientProvider(
      ref.watch(_paypalDataSourceRemoteProvider),
    ),
  ),
);
