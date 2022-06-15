import 'base_command.dart';
import 'package:amplify_api/amplify_api.dart';
import '../models/Game.dart';
import 'package:amplify_flutter/amplify_flutter.dart';

class GameCommand extends BaseCommand {

  Future<List<String>> run(String user) async {
    // Make service call and inject results into the model
    List<String> posts = await userService.getPosts(user);

    // Return our posts to the caller in case they care
    return posts;
  }

 Future<Map<String, dynamic>> createGame(Map<String, dynamic> userInput ) async{
     print("createGame");
    Map<String, dynamic> createGameResponse = {"success": false, "message": "Default Error"};
    try {
      Game game = Game(hometeam: userInput['hometeam'], awayTeam: userInput['awayteam'], pickup: userInput['pickup']);
      final request = ModelMutations.create(game);
      print("request");
      final response = await Amplify.API.mutate(request: request).response;
      print("response");

      Game? createdGame = response.data;
      if (createdGame != null) {
       createGameResponse["success"] = true;
      createGameResponse["messasge"] = "Successfully Created Location";
      createGameResponse["data"] = createdGame;

      }
      
      print('Mutation result: ' );
      print(createdGame);
      return createGameResponse;
    } on ApiException catch (e) {
      print('Mutation failed: $e');
      return createGameResponse;
    }
  }

  

 

}