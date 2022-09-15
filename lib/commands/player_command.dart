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

class PlayerCommand extends BaseCommand {
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
          'Authorization': 'Bearer fnAEwU2qV_ACT5r5tpk0an5_qFS-M8vncFSUZPvL',
          'Content-Type': 'application/json'
        },
        body: jsonEncode(<String, String>{
          'query': PlayerMutations().createPlayer(userInput, playerInput, locationInput),
        }),
      );

      print("response body: ");
      print(jsonDecode(response.body));

      
      
      createPlayerResponse["success"] = true;
      createPlayerResponse["message"] = "Player for Team Created";
      createPlayerResponse["data"] = null;//jsonDecode(response.body)['data']['createPlayer'];

      return createPlayerResponse;
    } on ApiException catch (e) {
      print('Mutation failed: $e');
      return createPlayerResponse;
    }
  }
}
