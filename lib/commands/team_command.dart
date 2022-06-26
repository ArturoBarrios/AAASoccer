import 'base_command.dart';
import 'package:amplify_api/amplify_api.dart';
import '../models/Team.dart';
import 'package:amplify_flutter/amplify_flutter.dart';

class TeamCommand extends BaseCommand {


 Future<Map<String, dynamic>> createTeam(Map<String, dynamic> userInput ) async{
     print("createTeam");
    Map<String, dynamic> createTeamResponse = {"success": false, "message": "Default Error"};
    try {
      Team team = Team(name: userInput['name'], color: userInput['color'], logo: userInput['logo'], images: userInput['images']);
      final request = ModelMutations.create(team);
      print("request");
      final response = await Amplify.API.mutate(request: request).response;
      print("response");

      Team? createdTeam = response.data;
      if (createdTeam != null) {
       createTeamResponse["success"] = true;
      createTeamResponse["messasge"] = "Successfully Created Team";
      createTeamResponse["data"] = createdTeam;

      }
      
      print('Mutation result: ' );
      print(createdTeam);
      return createTeamResponse;
    } on ApiException catch (e) {
      print('Mutation failed: $e');
      return createTeamResponse;
    }
  }

  

 

}