import 'base_command.dart';
import 'package:amplify_api/amplify_api.dart';
import '../models/Tryout.dart';
import 'package:amplify_flutter/amplify_flutter.dart';

class TryoutCommand extends BaseCommand {


 void createTryout(Map<String, dynamic> tryoutInput ) async{
    //  print("createGame");
    // Map<String, dynamic> createGameResponse = {"success": false, "message": "Default Error"};
    // try {
    //   Tryout game = Tryout(hometeam: tryoutInput['hometeam'], awayTeam: tryoutInput['awayteam'], pickup: tryoutInput['pickup']);
    //   final request = ModelMutations.create(game);
    //   print("request");
    //   final response = await Amplify.API.mutate(request: request).response;
    //   print("response");

    //   Game? createdGame = response.data;
    //   if (createdGame != null) {
    //    createGameResponse["success"] = true;
    //   createGameResponse["messasge"] = "Successfully Created Location";
    //   createGameResponse["data"] = createdGame;

    //   }
      
    //   print('Mutation result: ' );
    //   print(createdGame);
    //   return createGameResponse;
    // } on ApiException catch (e) {
    //   print('Mutation failed: $e');
    //   return createGameResponse;
    // }
  }

  

 

}