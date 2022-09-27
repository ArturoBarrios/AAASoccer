import 'base_command.dart';
import 'package:amplify_api/amplify_api.dart';
import 'package:faunadb_http/faunadb_http.dart';
import 'package:faunadb_http/query.dart';
import '../models/app_model.dart';
import '../commands/event_command.dart';

class TournamentCommand extends BaseCommand {


 Future<Map<String, dynamic>> createTournament(Map<String, dynamic> tournamentData, Map<String, dynamic> eventInput ) async{
     print("createTournament");
    Map<String, dynamic> createTournamentResponse = {"success": false, "message": "Default Error", "data": null};
    try {
     Map<String, dynamic> createEventResp = await EventCommand().createEvent(eventInput);
     if(createEventResp["success"]){
        FaunaResponse eventFaunaResult = createEventResp["data"];
        Map<String, dynamic> eventResult = eventFaunaResult.asMap();
        print("event before creating Tournament: ");
        print(eventResult['resource']['ref']['@ref']['id']);
        final createDocument = Create(
            Collection('Tournament'),
            Obj({
              'data': {
                'groupPlay': tournamentData['groupPlay'],           
                'event': Ref(Collection("Event"), eventResult['resource']['ref']['@ref']['id']),                
                }
            }),
        ); 
        //get teams
        if(tournamentData['groupPlay']){
          //create groups
          //number of teams in group
          //there's situations where you want to
          //give user ability to remove team from group
          //and allow system to play on without any
          //errors
         
        }
     } 
      return createTournamentResponse;
    } on ApiException catch (e) {
      print('Mutation failed: $e');
      return createTournamentResponse;
    }
  }

  

 

}