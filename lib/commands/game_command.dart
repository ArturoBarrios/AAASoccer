import 'dart:convert';
import 'dart:ffi';
import 'base_command.dart';
import 'package:faunadb_http/faunadb_http.dart';
import 'package:faunadb_http/query.dart';
import '../models/app_model.dart';
import '../commands/event_command.dart';
import '../models/events_model.dart';
import '../commands/geolocation_command.dart';
import 'package:geolocator/geolocator.dart';
import '../graphql/mutations/games.dart';
import '../graphql/mutations/users.dart';
import '../graphql/queries/games.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../../commands/tournament_command.dart';
import '../../models/types_models.dart';

class GameCommand extends BaseCommand {

  Future<Map<String, dynamic>> getGamesNearLocation() async {
    print("getGamesNearLocation");
    Map<String, dynamic> getGamesNearLocationResp = {
      "success": false,
      "message": "Default Error",
      "data": null
    };
    try {
      print("my position");
      Position myPosition = await GeoLocationCommand().determinePosition();
      http.Response response = await http.post(
        Uri.parse('https://graphql.fauna.com/graphql'),
        headers: <String, String>{
          'Authorization': 'Bearer ' + dotenv.env['FAUNADBSECRET'].toString(),
          'Content-Type': 'application/json'
        },
        body: jsonEncode(<String, String>{
          'query': GameQueries().getGames(true),
        }),
      );

      print("response body: ");
      print(jsonDecode(response.body));

      final result = jsonDecode(response.body)['data']['allGames']['data'];
      getGamesNearLocationResp["success"] = true;
      getGamesNearLocationResp["message"] = "Games Retrieved";
      getGamesNearLocationResp["data"] = result;
    } on Exception catch (e) {
      print('Mutation failed: $e');
    }

    return getGamesNearLocationResp;
  }

  Future<Map<String, dynamic>> createTo(Map<String, dynamic> userInput) async {
    print("createTo");
    Map<String, dynamic> createToResponse = {
      "success": false,
      "message": "Default Error",
      "data": null
    };

    try {
      Map<String, dynamic> userInput = {
        "_id": appModel.currentUser['_id'],
      };     
      http.Response response = await http.post(
        Uri.parse('https://graphql.fauna.com/graphql'),
        headers: <String, String>{
          'Authorization': 'Bearer ' + dotenv.env['FAUNADBSECRET'].toString(),
          'Content-Type': 'application/json'
        },
        body: jsonEncode(<String, String>{
          'query':
              UserMutations().createTo(userInput),
        }),
      );
      print("response body: ");
      print(jsonDecode(response.body));
      Map<String, dynamic> createTo =
          jsonDecode(response.body)['data']['createTo'];      

      createToResponse["success"] = true;
      createToResponse["message"] = "To Created";
      createToResponse["data"] =
          jsonDecode(response.body)['data']['createTo'];
      await EventCommand().addGame(createTo, true);

      return createToResponse;
    } on Exception catch (e) {
      print('Mutation failed: $e');
      return createToResponse;
    }    

  }


//create
  Future<Map<String, dynamic>> createGame(
      Map<String, dynamic> gameInput,
      Map<String, dynamic> eventInput,
      Map<String, dynamic> locationInput) async {
        
    print("createGame");
    print(gameInput);
    Map<String, dynamic> createGameResponse = {
      "success": false,
      "message": "Default Error",
      "data": null
    };
    try {
      print("appModel.currentUser['_id']: ");
      print(appModel.currentUser['_id']);
      eventInput['type'] = EventType.GAME;
      Map<String, dynamic> userInput = {
        "_id": appModel.currentUser['_id'],
      };      

      print("eventtttttttttt input: "+eventInput.toString());
      http.Response response = await http.post(
        Uri.parse('https://graphql.fauna.com/graphql'),
        headers: <String, String>{
          'Authorization': 'Bearer ' + dotenv.env['FAUNADBSECRET'].toString(),
          'Content-Type': 'application/json'
        },

        body: jsonEncode(<String, String>{
          'query':
              GameMutations().createGame(gameInput, eventInput, locationInput, userInput),
        }),
      );
      print("response body: ");
      print(jsonDecode(response.body));
      Map<String, dynamic> createdGame =
          jsonDecode(response.body)['data']['createGame'];
      // EventsModel().games.add(createdGame);

      createGameResponse["success"] = true;
      createGameResponse["message"] = "Game Created";
      createGameResponse["data"] =
          jsonDecode(response.body)['data']['createGame'];
      await EventCommand().addGame(createdGame, true);

      return createGameResponse;
    } on Exception catch (e) {
      print('Mutation failed: $e');
      return createGameResponse;
    }
  }



  Future<Map<String, dynamic>> addPlayerToGame(
      Map<String, dynamic> gameInput, Map<String, dynamic> playerInput) async {
    print("addPlayerToGame");
    Map<String, dynamic> addPlayerToGameResponse = {
      "success": false,
      "message": "Default Error",
      "data": null
    };

    http.Response response = await http.post(
      Uri.parse('https://graphql.fauna.com/graphql'),
      headers: <String, String>{
        'Authorization': 'Bearer ' + dotenv.env['FAUNADBSECRET'].toString(),
        'Content-Type': 'application/json'
      },
      body: jsonEncode(<String, String>{
        'query': GameMutations().addPlayerToGame(gameInput, playerInput),
      }),
    );

    print("response body: ");
    print(jsonDecode(response.body));

    addPlayerToGameResponse["success"] = true;
    addPlayerToGameResponse["message"] = "Game Created";
    addPlayerToGameResponse["data"] =
        jsonDecode(response.body)['data']['updateGame'];

    return addPlayerToGameResponse;
  }

  Future<Map<String, dynamic>> deleteGame(String eventId, String gameId) async {
    print("deleteGame");
    Map<String, dynamic> deleteGameResponse = {
      "success": false,
      "message": "Default Error",
      "data": null
    };
    http.Response response = await http.post(
      Uri.parse('https://graphql.fauna.com/graphql'),
      headers: <String, String>{
        'Authorization': 'Bearer ' + dotenv.env['FAUNADBSECRET'].toString(),
        'Content-Type': 'application/json'
      },
      body: jsonEncode(<String, String>{
        'query': GameMutations().deleteGame(gameId),
      }),
    );

    print("response body: ");
    print(jsonDecode(response.body));

    deleteGameResponse["success"] = true;
    deleteGameResponse["message"] = "Game Deleted";
    deleteGameResponse["data"] =
        jsonDecode(response.body)['data']['deleteGame'];
    await EventCommand().deleteGame(jsonDecode(response.body), true);

    return deleteGameResponse;
  }
}
