
import 'package:faunadb_http/faunadb_http.dart';
import 'package:faunadb_http/query.dart';
import '../models/app_model.dart';
import '../graphql/queries/games.dart';

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

    ///available    
    print("client: ");
    print(AppModel().faunaClient.toString());    
    createFaunaClientResponse["success"] = true;
    createFaunaClientResponse["message"] = "Fauna Client Created";
    // createFaunaClientResponse["faunaClient"] = faunaClient;

    return createFaunaClientResponse;
  }

  Future<Map<String, dynamic>> retrieveInitialModels() async {
    print("fauna_db_services.dart: retrieveInitialModels");
    Map<String, dynamic> retrieveInitialModelsResponse = {
      "success": false,
      "message": "Default Error",
      "data": Map<String, dynamic>()
    };

    Map<String, dynamic> getGames = {"success": "false"};//await GameQueries().getGames();
    if(getGames['success']){
      print("retrieved games successfully from fauna db");
      retrieveInitialModelsResponse["success"] = true;
      retrieveInitialModelsResponse["message"] = "Games retrieved";
      retrieveInitialModelsResponse["data"]["games"] = getGames["data"];
    }

    

    return retrieveInitialModelsResponse;
  }
}
