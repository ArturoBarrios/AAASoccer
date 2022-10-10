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

  //CREDIT TO https://github.com/sasatatar
  //LINK TO CODE: https://github.com/sasatatar/berger-table-generator/blob/master/index.js
  List<dynamic> bergerTable(int size, {bool useDummy=false}){    
    List<dynamic> bergerTableResponse = [];
    List<dynamic> teams = [];
    Object dummy = {};
    for (var i = 0; i < size; i++) {
      teams.add(i);
    }
    if(teams.length % 2 != 0){
      teams.add(dummy);
    }
    int n = teams.length;
    int numberOfRounds = n-1;
    int gamesPerRound = (n/2).floor();

    List<dynamic> columnA = teams.sublist(0, gamesPerRound);
    List<dynamic> columnB = teams.sublist(gamesPerRound);
    dynamic fixed = teams[0];

    for(int i = 0; i < numberOfRounds; i++){
      int gameCount = 1;
      List<dynamic> acc = [];
      for(int k = 0;k<gamesPerRound;k++){
        if (useDummy || (columnA[k] != dummy && columnB[k] != dummy)) {
          acc.add
          ({
              "round": i+1,
              "game": gameCount,
              "teamA": columnA[k],
              "teamB": columnB[k]
            });
            gameCount++;
        }


      }
      bergerTableResponse.add(acc);      
      // rotate elements
      columnA = [fixed, columnB.removeAt(0), ...columnA.sublist(1)];
      columnB.add(columnA.removeLast());
    }

    print("bergerTableResponse");
    print(bergerTableResponse);           

    return bergerTableResponse;
    
  }




  

 

}