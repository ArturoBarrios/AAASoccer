import 'base_command.dart';
import 'package:amplify_api/amplify_api.dart';
import '../models/Tryout.dart';
import 'package:amplify_flutter/amplify_flutter.dart';

class TryoutCommand extends BaseCommand {


 Future<Map<String, dynamic>> createTryout(Map<String, dynamic> userInput ) async{
     print("createTryout");
    Map<String, dynamic> createTryoutResponse = {"success": false, "message": "Default Error"};
    try {
      Tryout tryout = Tryout(tryoutEventId: userInput['tryoutEventId']);
      final request = ModelMutations.create(tryout);
      print("request");
      final response = await Amplify.API.mutate(request: request).response;
      print("response");

      Tryout? createdTryout = response.data;
      if (createdTryout != null) {
       createTryoutResponse["success"] = true;
      createTryoutResponse["messasge"] = "Successfully Created Location";
      createTryoutResponse["data"] = createdTryout;

      }
      
      print('Mutation result: ' );
      print(createdTryout);
      return createTryoutResponse;
    } on ApiException catch (e) {
      print('Mutation failed: $e');
      return createTryoutResponse;
    }
  }

  

 

}