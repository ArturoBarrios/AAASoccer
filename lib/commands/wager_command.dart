import 'base_command.dart';
import 'package:amplify_api/amplify_api.dart';
import '../models/Wager.dart';
import 'package:amplify_flutter/amplify_flutter.dart';

class WagerCommand extends BaseCommand {


 Future<Map<String, dynamic>> createWager(Map<String, dynamic> userInput ) async{
     print("createWager");
    Map<String, dynamic> createWagerResponse = {"success": false, "message": "Default Error"};
    try {
      Wager wager = Wager(name: userInput['username'], amount: userInput['amount'], private: userInput['private']);
      final request = ModelMutations.create(wager);
      print("request");
      final response = await Amplify.API.mutate(request: request).response;
      print("response");

      Wager? createdWager = response.data;
      if (createdWager != null) {
       createWagerResponse["success"] = true;
      createWagerResponse["messasge"] = "Successfully Created Wager";
      createWagerResponse["data"] = createdWager;

      }
      
      print('Mutation result: ' );
      print(createdWager);
      return createWagerResponse;
    } on ApiException catch (e) {
      print('Mutation failed: $e');
      return createWagerResponse;
    }
  }

  

 

}