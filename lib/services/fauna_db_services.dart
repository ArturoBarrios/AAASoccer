import 'package:geolocator/geolocator.dart';
import 'package:faunadb_http/faunadb_http.dart';
import '../models/app_model.dart';

class FaunaDBServices {
  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  Future<Map<String, dynamic>> createFaunaClient() async {
    print("createFaunaClient");
    Map<String, dynamic> createFaunaClientResponse = {
      "success": false,
      "message": "Default Error"
    };
    // final FaunaClient faunaClient = FaunaClient(FaunaConfig.build(
    //   secret: 'fnAEr6K_CIACT8LrjVZdayh8ZPF2QcQKcaKO-M1-',
    //   domain: 'db.fauna.com'
    // ));
    // AppModel().faunaClient = faunaClient;
    /////might wanna check if client is even 
    ///available    
    print("client: ");
    print(AppModel().faunaClient.toString());
    createFaunaClientResponse["success"] = true;
    createFaunaClientResponse["message"] = "Fauna Client Created";
    // createFaunaClientResponse["faunaClient"] = faunaClient;

    return createFaunaClientResponse;
  }
}
