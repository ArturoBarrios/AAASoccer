import 'dart:convert';
import 'dart:ffi';

import 'base_command.dart';
import 'package:amplify_api/amplify_api.dart';
import 'package:faunadb_http/faunadb_http.dart';
import 'package:faunadb_http/query.dart';
import '../commands/user_command.dart';
import '../models/app_model.dart';
import '../graphql/mutations/players.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../commands/geolocation_command.dart';
import 'package:geolocator/geolocator.dart';
import '../graphql/queries/players.dart';

class PlayerCommand extends BaseCommand {

   Future<Map<String, dynamic>> getPlayersNearLocation() async{
      print("getPlayersNearLocation");
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
            'query': UserQueries().getPlayers(),
          }),
        );

        print("response body: ");
        print(jsonDecode(response.body));


      final result = jsonDecode(response.body)['data']['allPlayers']['data'];
      getTrainingsNearLocationResp["success"] = true;
      getTrainingsNearLocationResp["message"] = "Games Retrieved";
      getTrainingsNearLocationResp["data"] = result;
      
    } on Exception catch (e) {
      print('Mutation failed: $e');  
    }

    return getTrainingsNearLocationResp;

  }

  Future<Map<String, dynamic>> createPlayer(Map<String, dynamic> userInput,
      Map<String, dynamic> playerInput, Map<String, dynamic> locationInput, bool withTeam) async {
    print("createPlayer");
    Map<String, dynamic> createPlayerResponse = {
      "success": false,
      "message": "Default Error",
      "data": null
    };
    try {
      http.Response response = await http.post(
        Uri.parse('https://graphql.fauna.com/graphql'),
        headers: <String, String>{
          'Authorization': 'Bearer '+ dotenv.env['FAUNADBSECRET'].toString(),
          'Content-Type': 'application/json'
        },
        body: jsonEncode(<String, String>{
          'query': PlayerMutations().createPlayer(userInput, playerInput, locationInput),
        }),
      );

      print("response body: ");
      print(jsonDecode(response.body));

      Map<String, dynamic> player = jsonDecode(response.body)['data']['createPlayer'];
      Map<String, dynamic> user = player['user'];      
      AppModel().currentUser = user;
            
      createPlayerResponse["success"] = true;
      createPlayerResponse["message"] = "Player for Team Created";
      createPlayerResponse["data"] = player;

    } on ApiException catch (e) {
      print('Mutation failed: $e');      
    }
      return createPlayerResponse;
  }

  Future<Map<String, dynamic>> updatePlayerWithTeam(Map<String,dynamic>playerInput, Map<String,dynamic>teamInput) async {
    print("updatePlayerWithTeam");
    Map<String, dynamic> updatePlayerWithTeamResponse = {
      "success": false,
      "message": "Default Error",
      "data": null
    };
    print("before updating player with team input");
    print(playerInput);
    print(teamInput);
    try {
      http.Response response = await http.post(
        Uri.parse('https://graphql.fauna.com/graphql'),
        headers: <String, String>{
          'Authorization': 'Bearer '+ dotenv.env['FAUNADBSECRET'].toString(),
          'Content-Type': 'application/json'
        },
        body: jsonEncode(<String, String>{
          'query': PlayerMutations().updatePlayerWithTeam(playerInput, teamInput),
        }),
      );

      print("response body: ");
      print(jsonDecode(response.body));

      
      
      updatePlayerWithTeamResponse["success"] = true;
      updatePlayerWithTeamResponse["message"] = "Player for Team Created";      
      updatePlayerWithTeamResponse["data"] = jsonDecode(response.body)['data']['updatePlayer'];

      
    } on ApiException catch (e) {
      print('Mutation failed: $e');
      
    }
    return updatePlayerWithTeamResponse;
  }
}
