import 'base_command.dart';
import 'package:amplify_api/amplify_api.dart';
import '../models/Game.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:faunadb_http/faunadb_http.dart';
import 'package:faunadb_http/query.dart';
import '../models/app_model.dart';
import '../commands/event_command.dart';

class GameCommand extends BaseCommand {


 Future<Map<String, dynamic>> createGame(Map<String, dynamic> gameInput, Map<String, dynamic> eventInput ) async{
     print("createGame");
    Map<String, dynamic> createGameResponse = {"success": false, "message": "Default Error"};
    try {
      Map<String, dynamic> createEventResp = await EventCommand().createEvent(eventInput);
      if(createEventResp["success"]){
        FaunaResponse eventFaunaResult = createEventResp["data"];
        Map<String, dynamic> eventResult = eventFaunaResult.asMap();
        print("gameResult before creating Game: ");
        print(eventResult['resource']['ref']['@ref']['id']);
        if(eventResult['resource']['ref']['@ref']['id']){
          final createDocument = Create(
            Collection('Game'),
            Obj({
              'data': {
                'pickup': gameInput['pickup'],           
                'event': Ref(Collection("Event"), eventResult['resource']['ref']['@ref']['id']),
                }
            }),
          ); 
        }
      }
      return createGameResponse;
    } on ApiException catch (e) {
      print('Mutation failed: $e');
      return createGameResponse;
    }
  }

  

 

}