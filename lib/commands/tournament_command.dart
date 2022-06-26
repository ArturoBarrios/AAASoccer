import 'base_command.dart';
import 'package:amplify_api/amplify_api.dart';
import '../models/Tournament.dart';
import 'package:amplify_flutter/amplify_flutter.dart';

class TournamentCommand extends BaseCommand {


 Future<Map<String, dynamic>> createTournament(Map<String, dynamic> userInput ) async{
     print("createTournament");
    Map<String, dynamic> createTournamentResponse = {"success": false, "message": "Default Error"};
    try {
      Tournament tournament = Tournament(tournamentEventId: userInput['tournamentEventId']);
      final request = ModelMutations.create(tournament);
      print("request");
      final response = await Amplify.API.mutate(request: request).response;
      print("response");

      Tournament? createdTournament = response.data;
      if (createdTournament != null) {
       createTournamentResponse["success"] = true;
      createTournamentResponse["messasge"] = "Successfully Created Tournament";
      createTournamentResponse["data"] = createdTournament;

      }
      
      print('Mutation result: ' );
      print(createdTournament);
      return createTournamentResponse;
    } on ApiException catch (e) {
      print('Mutation failed: $e');
      return createTournamentResponse;
    }
  }

  

 

}