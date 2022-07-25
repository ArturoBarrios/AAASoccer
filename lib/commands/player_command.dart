import 'base_command.dart';
import 'package:amplify_api/amplify_api.dart';
import 'package:faunadb_http/faunadb_http.dart';
import 'package:faunadb_http/query.dart';
import '../commands/user_command.dart';
import '../models/app_model.dart';

class PlayerCommand extends BaseCommand {

 Future<Map<String, dynamic>> createPlayer(Map<String, dynamic> userInput, Map<String, dynamic> playerInput  ) async{
     
     print("createPlayer");
    Map<String, dynamic> createPlayerResponse = {"success": false, "message": "Default Error", "data": null};
    try {
      //can you make sure you don't commit
      //a player unless User is created first?
      Map<String, dynamic> createUserResp = await UserCommand().createUser(userInput);
      if(createUserResp["success"]){
        FaunaResponse userFaunaResult = createUserResp["data"];

        Map<String, dynamic> userResult = userFaunaResult.asMap();
        print("userResult before creating Player: ");
        print(userResult['resource']['ref']['@ref']['id']);
        if(userResult['resource']['ref']['@ref']['id']){
          final createDocument = Create(
            Collection('Player'),
            Obj({
              'data': {
                'competitveLevel': playerInput['competitveLevel'],  
                'user': Ref(Collection("User"), userResult['resource']['ref']['@ref']['id']),
          
                }
            }),
          );  
         FaunaResponse result = await AppModel().faunaClient.query(createDocument);
          print("result: ");
          print(result.toJson());
          createPlayerResponse["success"] = true;
          createPlayerResponse["message"] = "Player Created";
          createPlayerResponse["data"] = result;
        }
      }
      return createPlayerResponse;
    } on ApiException catch (e) {
      print('Mutation failed: $e');
      return createPlayerResponse;
    }
  }

  

 

}