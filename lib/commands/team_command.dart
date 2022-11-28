import 'dart:convert';
import 'base_command.dart';
import 'package:amplify_api/amplify_api.dart';
import 'package:faunadb_http/faunadb_http.dart';
import 'package:faunadb_http/query.dart';
import '../models/app_model.dart';
import 'package:http/http.dart' as http;
import '../graphql/mutations/teams.dart';
import '../graphql/mutations/locations.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../commands/geolocation_command.dart';
import 'package:geolocator/geolocator.dart';
import '../graphql/queries/teams.dart';


class TeamCommand extends BaseCommand {

   Future<Map<String, dynamic>> getTeamsNearLocation() async{
      print("getTeamsNearLocation");
    Map<String, dynamic> getTrainingsNearLocationResp = {"success": false, "message": "Default Error", "data": null};
    try{
      print("my position");
      Position myPosition = await GeoLocationCommand().determinePosition();
      http.Response response = await http.post(
          Uri.parse('https://graphql.fauna.com/graphql'),
          headers: <String, String>{
            'Authorization': 'Bearer '+ dotenv.env['FAUNADBSECRET'].toString(),
            'Content-Type': 'application/json'
          },
          body: jsonEncode(<String, String>{
            'query': TeamQueries().getTeams(),
          }),
        );

        print("response body: ");
        print(jsonDecode(response.body));


      final result = jsonDecode(response.body)['data']['allTeams']['data'];
      getTrainingsNearLocationResp["success"] = true;
      getTrainingsNearLocationResp["message"] = "Games Retrieved";
      getTrainingsNearLocationResp["data"] = result;
      
    } on Exception catch (e) {
      print('Mutation failed: $e');  
    }

    return getTrainingsNearLocationResp;

  }

  Future<Map<String, dynamic>> acceptTeamRequest(Map<String, dynamic> teamRequestInput) async {
   Map<String, dynamic> acceptTeamRequestResponse = {
      "success": false,
      "message": "Default Error",
      "data": null
    };

    try{

      http.Response response = await http.post(
        Uri.parse('https://graphql.fauna.com/graphql'),
        headers: <String, String>{
          'Authorization': 'Bearer '+ dotenv.env['FAUNADBSECRET'].toString(),
          'Content-Type': 'application/json'
        },
        body: jsonEncode(<String, String>{
          'query': TeamMutations().acceptTeamRequest(teamRequestInput),
        }),
      );

      print("response body: ");
      print(jsonDecode(response.body));

      
      
      acceptTeamRequestResponse["success"] = true;
      acceptTeamRequestResponse["message"] = "Accepted Team Request";      
      acceptTeamRequestResponse["data"] = jsonDecode(response.body)['data']['UpdateFriendRequest'];

    }catch(e) {}

  return acceptTeamRequestResponse;

}

  Future<Map<String, dynamic>> sendTeamRequest(Map<String, dynamic> userInput, Map<String, dynamic> teamInput  ) async{
    print("sendTeamRequest");
    Map<String, dynamic> sendTeamRequestResponse = {"success": false, "message": "Default Error", "data": null};
    try {      
      http.Response response = await http.post(
        Uri.parse('https://graphql.fauna.com/graphql'),
        headers: <String, String>{
          'Authorization': 'Bearer '+ dotenv.env['FAUNADBSECRET'].toString(),
          'Content-Type': 'application/json'
        },
        body: jsonEncode(<String, String>{
          'query': TeamMutations().sendTeamRequest(userInput, teamInput),
        }),
      );

      print("response body: ");
      print(jsonDecode(response.body));

      
      
      sendTeamRequestResponse["success"] = true;
      sendTeamRequestResponse["message"] = "Created Team Request";      
      sendTeamRequestResponse["data"] = jsonDecode(response.body)['data']['CreateTeamRequest'];
    
      
    } catch (e) {}

    return sendTeamRequestResponse;
  }


 Future<Map<String, dynamic>> createTeam(Map<String, dynamic> teamInput, Map<String, dynamic> locationInput ) async{
     print("createTeam");
    Map<String, dynamic> createTeamResponse = {"success": false, "message": "Default Error", "data": null};
    try {
     print("team input: ");
     print(teamInput);

     http.Response response = await http.post(
        Uri.parse('https://graphql.fauna.com/graphql'),
        headers: <String, String>{
          'Authorization': 'Bearer '+ dotenv.env['FAUNADBSECRET'].toString(),
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