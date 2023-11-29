import 'dart:convert';
import 'dart:ffi';
import '../constants.dart';
import 'base_command.dart';
import 'package:faunadb_http/faunadb_http.dart';
import 'package:faunadb_http/query.dart';
import '../models/pageModels/app_model.dart';
import '../commands/event_command.dart';
import '../models/events_model.dart';
import '../commands/geolocation_command.dart';
// import 'package:geolocator/geolocator.dart';
import '../graphql/mutations/games.dart';
import '../graphql/mutations/users.dart';
import '../graphql/queries/games.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../../commands/tournament_command.dart';
import '../../commands/payment_commands.dart';
import '../models/enums/EventType.dart';

class GameCommand extends BaseCommand {
  List<dynamic> sortGames(List<dynamic> games, String sortBy) {
    //assume events are sorted by date for now
    print("sortEvents()");
    print("sortBy: " + sortBy);
    List<dynamic> sortedGames = List.from(games);
    sortedGames.sort((a, b) {
      int aCreatedAt = int.tryParse(a["event"]["createdAt"]) ?? 0;
      int bCreatedAt = int.tryParse(b["event"]["createdAt"]) ?? 0;
      print("aCreatedAt: " + aCreatedAt.toString());
      print("bCreatedAt: " + bCreatedAt.toString());
      return bCreatedAt.compareTo(aCreatedAt);
    });

    return sortedGames;
  }

  Future<Map<String, dynamic>> getGamesNearLocation(String gameFragment) async {
    print("getGamesNearLocation");
    Map<String, dynamic> getGamesNearLocationResp = {
      "success": false,
      "message": "Default Error",
      "data": null
    };
    try {
      print("my position");
      // Position myPosition = await GeoLocationCommand().determinePosition();
      http.Response response = await http.post(
        Uri.parse('https://graphql.fauna.com/graphql'),
        headers: <String, String>{
          'Authorization': 'Bearer ' + dotenv.env['FAUNADBSECRET'].toString(),
          'Content-Type': 'application/json'
        },
        body: jsonEncode(<String, String>{
          'query': GameQueries().getGames(true, gameFragment),
        }),
      );

      print("response body: ");
      print(jsonDecode(response.body));

      dynamic result = jsonDecode(response.body)['data']['allGames']['data'];
      print("getGamesNearLocation length: " + result.length.toString());

      getGamesNearLocationResp["success"] = true;
      getGamesNearLocationResp["message"] = "Games Retrieved";
      getGamesNearLocationResp["data"] = result;
    } on Exception catch (e) {
      print('Mutation failed: $e');
    }

    return getGamesNearLocationResp;
  }

  Map<String, dynamic> filterGames(List<dynamic> games) {
    print("filterGames()");
    print("games: " + games.toString());
    Map<String, dynamic> filteredEventsResp = {
      "archived": [],
      "active": [],
      "success": false,
    };
    List<dynamic> archivedEvents = [];
    List<dynamic> activeEvents = [];
    print("before for loop");
    for (int i = 0; i < games.length; i++) {
      print("check if event is archived");
      print("DateTime.parse(games[i]['event']['endTime']: " +
          games[i]['event']['endTime'].toString());
      String millisecondsString = games[i]['event']['endTime'].toString();
      DateTime dateTime =
          BaseCommand().dateTimeFromMilliseconds(millisecondsString);
      //if game is marked as archived or
      //active but time is past
      print("dateTime: " + dateTime.toString());
      if (
          (dateTime.isBefore(DateTime.now()))) {
        print("event archived!");
        archivedEvents.remove(games[i]);
      } else {
        activeEvents.add(games[i]);
      }
    }
    print("after for loop");
    print("archivedEvents: " + archivedEvents.toString());
    print("activeEvents: " + activeEvents.toString());

    filteredEventsResp["archivedEvents"] = archivedEvents;
    filteredEventsResp["activeEvents"] = activeEvents;
    filteredEventsResp["success"] = true;

    return filteredEventsResp;
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
      Map<String, dynamic> userInput = {
        "_id": appModel.currentUser['_id'],
      };
      eventInput['price'] = eventInput['price'] * 100;
      print("eventtttttttttt input: " + eventInput.toString());
      http.Response response = await http.post(        
        Uri.parse(dotenv.env['APOLLO_SERVER'].toString()+""),
        headers: <String, String>{          
          'Content-Type': 'application/json'
        },
        body: jsonEncode(<String, String>{
          'query': GameMutations()
              .createGame(gameInput, eventInput, locationInput, userInput),
        }),
      );
      print("response body: ");
      print(jsonDecode(response.body));
    

      Map<String, dynamic> createdGame =
          jsonDecode(response.body);      
      


      createGameResponse["success"] = true;
      createGameResponse["message"] = "Game Created";
      createGameResponse["data"] = createdGame;

      // }
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

}
