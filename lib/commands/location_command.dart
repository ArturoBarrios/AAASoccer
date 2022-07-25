import 'base_command.dart';
import 'package:amplify_api/amplify_api.dart';
import '../models/Location.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:faunadb_http/faunadb_http.dart';
import 'package:faunadb_http/query.dart';
import '../models/app_model.dart';

class LocationCommand extends BaseCommand {

  Future<List<String>> run(String user) async {
    // Make service call and inject results into the model
    List<String> posts = await userService.getPosts(user);

    // Return our posts to the caller in case they care
    return posts;
  }

 Future<Map<String, dynamic>> createLocation(Map<String, dynamic> locationInput ) async{
     print("createLocation");
    Map<String, dynamic> createLocationResponse = {"success": false, "message": "Default Error", "data": null};
    try {

      final createDocument = Create(
        Collection('Location'),
        Obj({
          'data': {            
            'name': 'house!',
            'latitude': locationInput['latitude'],
            'longitude': locationInput['longitude'],
          }
        })
      );

      FaunaResponse result = await AppModel().faunaClient.query(createDocument);
      print("result: ");
      print(result.toJson());

      createLocationResponse["success"] = true;
      createLocationResponse["message"] = "Location Created";
      createLocationResponse["data"] = result;
      

      return createLocationResponse;
    } on ApiException catch (e) {
      print('Mutation failed: $e');
      return createLocationResponse;
    }
  }

  

 

}