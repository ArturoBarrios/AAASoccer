import 'dart:convert';
import 'dart:math';
import '../models/enums/EventType.dart' as event_type;
import 'base_command.dart';
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import '../commands/event_command.dart';


import '../../testing/seeding/location_seeder.dart';
import '../../testing/seeding/event_seeder.dart';
import '../../commands/tournament_command.dart';
import '../../commands/game_command.dart';
import '../graphql/mutations/leagues.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../commands/geolocation_command.dart';
// import 'package:geolocator/geolocator.dart';
import '../graphql/queries/leagues.dart';

class LeagueCommand extends BaseCommand {
  Map<String, dynamic> currateLeagueData(dynamic selectedObject) {
    print("currateLeagueData");
    Map<String, dynamic> currateLeagueDataResp = {
      "success": false,
      "message": "Default Error",
      "data": null
    };
    Map<String, dynamic>? getMainEvent = null;
    selectedObject['events']['data'].forEach((event) {
      if (event['isMainEvent'] == true) {
        getMainEvent = event;
      }
    });

    print("getMainEvent");
    print(getMainEvent);
    selectedObject['mainEvent'] = getMainEvent;

    return currateLeagueDataResp;
  }

  void updateLeagueData(dynamic league) {
    print("updateLeagueData");
    eventsModel.leagues.add(league);
  }

  List<dynamic> sortLeagues(List<dynamic> leagues, String sortBy) {
    print("sortLeagues()");
    print("sortBy: " + sortBy);
    List<dynamic> sortedleagues = List.from(leagues);

    sortedleagues.sort((a, b) {
      dynamic mainEventA = EventCommand().getMainEvent(a['events']['data']);
      dynamic mainEventB = EventCommand().getMainEvent(b['events']['data']);
      print("mainEventA: " + mainEventA.toString());
      print("mainEventB: " + mainEventB.toString());
      if (mainEventA != null && mainEventB != null) {
        DateTime startTimeA = DateTime.fromMillisecondsSinceEpoch(
            int.parse(mainEventA['startTime']));
        DateTime startTimeB = DateTime.fromMillisecondsSinceEpoch(
            int.parse(mainEventB['startTime']));
        return startTimeB.compareTo(startTimeA);
      }

      // Handle cases where main events are not available
      return 0;
    });
    return sortedleagues;
  }

  Future<Map<String, dynamic>> getLeaguesNearLocation() async {
    print("getLeaguesNearLocation");
    Map<String, dynamic> getLeaguesNearLocationResp = {
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
          'query': LeagueQueries().getLeagues(),
        }),
      );

      print("response body: ");
      print(jsonDecode(response.body));

      final result = jsonDecode(response.body)['data']['allLeagues']['data'];
      getLeaguesNearLocationResp["success"] = true;
      getLeaguesNearLocationResp["message"] = "Leagues Retrieved";
      getLeaguesNearLocationResp["data"] = result;
    } on Exception catch (e) {
      print('Mutation failed: $e');
    }

    return getLeaguesNearLocationResp;
  }

  updateLeagueNumberOfTeams() {}

  Future<Map<String, dynamic>> createLeague(Map<String, dynamic> leagueData,
      eventInput, Map<String, dynamic> locationInput) async {
    print("createLeague");
    print("leagueData: " + leagueData.toString());
    Map<String, dynamic> createLeagueResp = {
      "success": false,
      "message": "Something went wrong with creating game relationships",
      "data": null,
    };

    eventInput['user_id'] = appModel.currentUser['_id'];
    eventInput['price'] = eventInput['price'] * 100;
    eventInput['teamPrice'] = eventInput['teamPrice'] * 100;
    print("eventInput: " + eventInput.toString());
    var rng = Random();

    List<dynamic> numberOfTeamsOptions = [2, 4, 8, 16, 32];
    int randomLocationNumber = rng.nextInt(100000000);
    int numberOfTeams = numberOfTeamsOptions[rng.nextInt(1)];

    List<dynamic> bergerTable = TournamentCommand()
        .bergerTable(numberOfTeams, leagueData['numberOfRoundsPerTeam']);
    print("bergerTable length: " + bergerTable.length.toString());
    http.Response response = await http.post(
      Uri.parse('https://graphql.fauna.com/graphql'),
      headers: <String, String>{
        'Authorization': 'Bearer ' + dotenv.env['FAUNADBSECRET'].toString(),
        'Content-Type': 'application/json'
      },
      body: jsonEncode(<String, String>{
        'query': LeagueMutations()
            .createLeague(leagueData, eventInput, locationInput),
      }),
    );
    print("createLeague response: " + jsonDecode(response.body).toString());
    if (response.statusCode == 200) {
      Map<String, dynamic> createdLeague =
          jsonDecode(response.body)['data']['createLeague'];
      createLeagueResp['data'] = createdLeague;
      print("createdLeague: ");
      print(createdLeague);

      dynamic priceEventInput = {
        "_id": createdLeague['events']['data'][0]['_id'],
      };

      //create games from bergerTable
      for (int i = 0; i < bergerTable.length; i++) {
        List<dynamic> roundGames = bergerTable[i];
        print("roundGames: " + roundGames.toString());
        for (int k = 0; k < roundGames.length; k++) {
          if (i == 0 && k < 2) {
            Map<String, dynamic> generateRandomLocation = await LocationSeeder()
                .generateRandomLocation(LocationSeeder().locations[0]);
            Map<String, dynamic> locationInput =
                generateRandomLocation["data"]["randomLocation"];
            Map<String, dynamic> eventInput = {
              "name": "Game: ${bergerTable[i][k]['game']}",
              "isMainEvent": false,
              "price": 0,
              'startTime': DateTime.fromMillisecondsSinceEpoch(
                      DateTime.now().millisecondsSinceEpoch ~/ 1000 * 1000)
                  .millisecondsSinceEpoch
                  .toString(),
              'endTime': DateTime.fromMillisecondsSinceEpoch(
                      DateTime.now().millisecondsSinceEpoch ~/ 1000 * 1000)
                  .millisecondsSinceEpoch
                  .toString(),
              'withRequest': false,
              'withPayment': false,
              'roles': "{PLAYER, ORGANIZER}",
              'createdAt': DateTime.fromMillisecondsSinceEpoch(
                      DateTime.now().millisecondsSinceEpoch ~/ 1000 * 1000)
                  .millisecondsSinceEpoch
                  .toString(),
              'type': event_type.EventType.GAME,
            };
            Map<String, dynamic> gameInput = {
              "pickup": false,
              "teamA": bergerTable[i][k]['teamA'].toString(),
              "teamB": bergerTable[i][k]['teamB'].toString(),
              "round": bergerTable[i][k]['round'],
              "gameNumber": bergerTable[i][k]['game'],
            };

            Map<String, dynamic> gameResp = await GameCommand()
                .createGame(gameInput, eventInput, locationInput);
            print("create gameResp: ");
            print(gameResp);
            Map<String, dynamic> createdEvent = gameResp['data']['event'];
            //attach game to league
            http.Response response = await http.post(
              Uri.parse('https://graphql.fauna.com/graphql'),
              headers: <String, String>{
                'Authorization':
                    'Bearer ' + dotenv.env['FAUNADBSECRET'].toString(),
                'Content-Type': 'application/json'
              },
              body: jsonEncode(<String, String>{
                'query': LeagueMutations()
                    .addEventToLeague(createdLeague, createdEvent),
              }),
            );

            print("addEventtoLeague response body: ");
            print(jsonDecode(response.body));
          }
        }
      }

      dynamic findLeagueByIdResponse =
          await findLeagueById(createdLeague['_id']);
      print("findLeagueByIdResponse: " + findLeagueByIdResponse.toString());
      if (findLeagueByIdResponse['success']) {
        //update league models
        dynamic league = findLeagueByIdResponse['data'];
        print("leaguett: " + league.toString());
        print("league: " + league.toString());
      }

      createLeagueResp["success"] = true;
      createLeagueResp["message"] = "League Created";
    }

    return createLeagueResp;
  }

  Future<Map<String, dynamic>> findLeagueById(String leagueId) async {
    print("getUser");
    Map<String, dynamic> findLeagueByIdResp = {
      "success": false,
      "message": "no League found",
      "data": null
    };
    try {
      print("leagueId: ");
      print(leagueId);
      http.Response response = await http.post(
        Uri.parse('https://graphql.fauna.com/graphql'),
        headers: <String, String>{
          'Authorization': 'Bearer ' + dotenv.env['FAUNADBSECRET'].toString(),
          'Content-Type': 'application/json'
        },
        body: jsonEncode(<String, String>{
          'query': LeagueQueries().findLeagueByID(leagueId),
        }),
      );

      print("response: ");
      print(jsonDecode(response.body));
      if (response.statusCode == 200) {
        final result = jsonDecode(response.body)['data']['findLeagueByID'];
        findLeagueByIdResp["success"] = true;
        findLeagueByIdResp["message"] = "League found";
        findLeagueByIdResp["data"] = result;
      }

      return findLeagueByIdResp;
    } catch (e) {
      print('Query failed: $e');
    }
    return findLeagueByIdResp;
  }
}
