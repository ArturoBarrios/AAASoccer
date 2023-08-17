import 'package:soccermadeeasy/commands/paypal_payment/paypal_data_source/paypal_data_source_remote.dart';
import 'package:riverpod/riverpod.dart' as riverpod;

import 'paypal_repository.dart';
import 'paypal_repository_impl.dart';
import 'util/api_client.dart';

final _paypalApiClientProvider = riverpod.Provider.autoDispose<ApiClient>(
  (ref) {
    return ApiClientImpl(
      baseURL: 'api-m.sandbox.paypal.com',
      pathPrefix: 'v2',
      headers: () async {
        const token =
            'Bearer A21AAKq1kIilSVdl86CxWjbU_giGY1Sk2Wd5HsMNd1S7mXY3YhljrX4bupuqzHY-v4RdzhzyXw-bxa21NeuQ_QjakhzrB5g3A';

        return <String, String>{
          'Content-Type': 'application/json',
          'Authorization': token,
        };
      },
    );
  },
);

final _paypalDataSourceRemoteProvider =
    riverpod.Provider.autoDispose<PaypalDataSourceRemote>(
  (ref) => PaypalDataSourceRemoteImpl(
    client: ref.watch(_paypalApiClientProvider),
  ),
);

/// Paypal repository.
final paypalRepositoryProvider =
    riverpod.Provider.autoDispose<PaypalRepository>(
  (ref) => PaypalRepositoryImpl(
    remoteDataSource: ref.watch(_paypalDataSourceRemoteProvider),
  ),
);
