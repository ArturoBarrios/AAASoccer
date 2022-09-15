import 'dart:convert';
import 'base_command.dart';
import 'package:amplify_api/amplify_api.dart';
import 'package:faunadb_http/faunadb_http.dart';
import 'package:faunadb_http/query.dart';
import '../models/app_model.dart';
import 'package:http/http.dart' as http;
import '../graphql/mutations/teams.dart';
import '../graphql/mutations/locations.dart';

class TeamCommand extends BaseCommand {


 Future<Map<String, dynamic>> createTeam(Map<String, dynamic> teamInput, Map<String, dynamic> locationInput ) async{
     print("createTeam");
    Map<String, dynamic> createTeamResponse = {"success": false, "message": "Default Error", "data": null};
    try {
     print("team input: ");
     print(teamInput);

     http.Response response = await http.post(
        Uri.parse('https://graphql.fauna.com/graphql'),
        headers: <String, String>{
          'Authorization': 'Bearer fnAEwU2qV_ACT5r5tpk0an5_qFS-M8vncFSUZPvL',
          'Content-Type': 'application/json'
        },
        body: jsonEncode(<String, String>{
          'query': TeamMutations().createTeam(teamInput, locationInput),
        }),
      );

      if (response.statusCode == 200) {
      createTeamResponse["success"] = true;
      createTeamResponse["message"] = "Location Created";
      createTeamResponse["data"] = jsonDecode(response.body)['data']['createTeam'];
  } else {
    //rollback somehow???
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }           
     return createTeamResponse;
    } on ApiException catch (e) {
      print('Mutation failed: $e');
      return createTeamResponse;
    }
  }

  

 

}