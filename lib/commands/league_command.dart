import 'base_command.dart';
import 'package:amplify_api/amplify_api.dart';
import '../models/League.dart';
import 'package:amplify_flutter/amplify_flutter.dart';

class LeagueCommand extends BaseCommand {


 Future<Map<String, dynamic>> createLeague(Map<String, dynamic> userInput ) async{
     print("createLeague");
    Map<String, dynamic> createLeagueResponse = {"success": false, "message": "Default Error"};
    try {
      League league = League(leagueEventId: userInput['leagueEventId']);
      final request = ModelMutations.create(league);
      print("request");
      final response = await Amplify.API.mutate(request: request).response;
      print("response");

      League? createdLeague = response.data;
      if (createdLeague != null) {
       createLeagueResponse["success"] = true;
      createLeagueResponse["messasge"] = "Successfully Created Location";
      createLeagueResponse["data"] = createdLeague;

      }
      
      print('Mutation result: ' );
      print(createdLeague);
      return createLeagueResponse;
    } on ApiException catch (e) {
      print('Mutation failed: $e');
      return createLeagueResponse;
    }
  }

  

 

}