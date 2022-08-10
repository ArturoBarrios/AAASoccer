import 'base_command.dart';
import 'package:amplify_api/amplify_api.dart';
import 'package:faunadb_http/faunadb_http.dart';
import 'package:faunadb_http/query.dart';
import '../models/app_model.dart';

class TeamCommand extends BaseCommand {


 Future<Map<String, dynamic>> createTeam(Map<String, dynamic> teamInput ) async{
     print("createTeam");
    Map<String, dynamic> createTeamResponse = {"success": false, "message": "Default Error", "data": null};
    try {
     print("team input: ");
     print(teamInput);
     final createDocument = Create(
        Collection('Team'),
        Obj({
          'data': {            
            'name': teamInput['name'],
            'color': teamInput['color'],            
            'location': Ref(Collection("Location"), teamInput['location']['resource']['ref']['@ref']['id']),                    

            }
        }),
      );  

      FaunaResponse result = await AppModel().faunaClient.query(createDocument);
      print("result: ");
      print(result.toJson());
      createTeamResponse["success"] = true;
      createTeamResponse["message"] = "User Created";
      createTeamResponse["data"] = result;

     return createTeamResponse;
    } on ApiException catch (e) {
      print('Mutation failed: $e');
      return createTeamResponse;
    }
  }

  

 

}