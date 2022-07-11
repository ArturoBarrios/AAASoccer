import 'base_command.dart';
import 'package:amplify_api/amplify_api.dart';
import '../models/Location.dart';
import 'package:amplify_flutter/amplify_flutter.dart';

class LocationCommand extends BaseCommand {

  Future<List<String>> run(String user) async {
    // Make service call and inject results into the model
    List<String> posts = await userService.getPosts(user);

    // Return our posts to the caller in case they care
    return posts;
  }

 Future<Map<String, dynamic>> createLocation(Map<String, dynamic> userInput ) async{
     print("createLocation");
    Map<String, dynamic> createLocationResponse = {"success": false, "message": "Default Error", "data": Map<String, dynamic>()};
    try {
      Location location = Location(latitude: userInput["latitude"], longitude: userInput["longitude"], name: userInput['name'], secondaryName: userInput['secondaryName'], address: userInput['address'], surface: userInput['surface'], fieldSize: userInput['fieldSize'], private: userInput['private']  );
      final request = ModelMutations.create(location);
      print("request");
      final response = await Amplify.API.mutate(request: request).response;
      print("response");

      Location? createdLocation = response.data;
      if (createdLocation != null) {
        createLocationResponse["success"] = true;
        createLocationResponse["messasge"] = "Successfully Created Location";
        createLocationResponse["data"]["randomLocation"] = createdLocation;

      }

      print('Mutation result: ' );
      print(createdLocation);
      return createLocationResponse;
    } on ApiException catch (e) {
      print('Mutation failed: $e');
      return createLocationResponse;
    }
  }

  

 

}