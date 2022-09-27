import 'base_command.dart';
import 'package:amplify_api/amplify_api.dart';
import '../models/League.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import '../commands/event_command.dart';
import 'package:faunadb_http/faunadb_http.dart';
import 'package:faunadb_http/query.dart';

class LeagueCommand extends BaseCommand {


 Future<Map<String, dynamic>> createLeague(Map<String, dynamic> leagueData, eventInput ) async{
     print("createLeague");
    Map<String, dynamic> createLeagueResponse = {"success": false, "message": "Default Error", "data": null};
    try {
      Map<String, dynamic> createEventResp = await EventCommand().createEvent(eventInput);
      if(createEventResp["success"]){
        FaunaResponse eventFaunaResult = createEventResp["data"];
        Map<String, dynamic> eventResult = eventFaunaResult.asMap();
        print("event before creating Tournament: ");
        print(eventResult['resource']['ref']['@ref']['id']);
        final createDocument = Create(
            Collection('League'),
            Obj({
              'data': {                
                'event': Ref(Collection("Event"), eventResult['resource']['ref']['@ref']['id']),                
                }
            }),
        ); 
      }
      
      return createLeagueResponse;
    } on ApiException catch (e) {
      print('Mutation failed: $e');      
      return createLeagueResponse;
    }
  }

  

 

}