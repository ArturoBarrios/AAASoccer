import 'dart:convert';
import 'dart:math';
import 'package:soccermadeeasy/graphql/queries/tournaments.dart';

import '../enums/EventType.dart';
import 'base_command.dart';
import 'package:amplify_api/amplify_api.dart';
import 'package:faunadb_http/faunadb_http.dart';
import 'package:faunadb_http/query.dart';
import '../models/app_model.dart';
import '../commands/event_command.dart';
import '../commands/game_command.dart';
import '../graphql/mutations/tournaments.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../../testing/seeding/location_seeder.dart';
import '../commands/geolocation_command.dart';
// import 'package:geolocator/geolocator.dart';

class TournamentCommand extends BaseCommand {
  Map<String, dynamic> currateTournamentData(dynamic selectedObject) {
    print("currateTournamentData");
    Map<String, dynamic> currateTournamentDataResp = {
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

    return currateTournamentDataResp;
  }

  void updateTournamentData(dynamic tournament, bool add) {
    print("updateTournamentData");
    if (add) {
      eventsModel.tournaments.add(tournament);
    } else {
      eventsModel.tournaments.remove(tournament);
    }
  }

  dynamic getMainTournamentEvent(dynamic tournament) {
    print("getMainTournamentEvent");
    Map<String, dynamic>? getMainEvent = null;
    tournament['events']['data'].forEach((event) {
      if (event['isMainEvent'] == true) {
        getMainEvent = event;
      }
    });

    return getMainEvent;
  }

  Future<Map<String, dynamic>> getTournamentsNearLocation() async {
    print("getTournamentsNearLocation");
    Map<String, dynamic> getTournamentsNearLocationResp = {
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
          'query': TournamentQueries().getTournaments(),
        }),
      );

      print("response body: ");
      print(jsonDecode(response.body));

      final allTournaments =
          jsonDecode(response.body)['data']['allTournaments']['data'];
      getTournamentsNearLocationResp["success"] = true;
      getTournamentsNearLocationResp["message"] = "Tournaments Retrieved";
      getTournamentsNearLocationResp["data"] = allTournaments;
    } on Exception catch (e) {
      print('Mutation failed: $e');
    }

    return getTournamentsNearLocationResp;
  }

  Future<Map<String, dynamic>> createTournament(
      Map<String, dynamic> tournamentData,
      Map<String, dynamic> eventInput,
      Map<String, dynamic> locationInput) async {
    print("createTournament");
    print("tournamentData: " + tournamentData.toString());
    Map<String, dynamic> createTournamentResp = {
      "success": false,
      "message": "Something went wrong with creating game relationships",
      "data": null,
    };

    eventInput['user_id'] = appModel.currentUser['_id'];
    var rng = Random();

    int numberOfTeams = tournamentData['numberOfTeams'] as int;    
    int numberOfGroups = tournamentData['numberOfGroups'];
    print("numberOfGroups: " + numberOfGroups.toString());
    print("numberOfTeams: " + numberOfTeams.toString());
    dynamic bergerTables = [];   
    //create groupStage
       
    for (int i = 0; i < numberOfGroups; i++) {
      List<dynamic> bergerTable = TournamentCommand().bergerTable(tournamentData['numberOfTeamsPerGroup'], tournamentData['numberOfRoundsPerTeam']);
      print("bergerTable length: " + bergerTable.length.toString());
      bergerTables.add(bergerTable);
      //create group
    }
    print("bergerTables: "+bergerTables.length.toString());

    http.Response response = await http.post(
      Uri.parse('https://graphql.fauna.com/graphql'),
      headers: <String, String>{
        'Authorization': 'Bearer ' + dotenv.env['FAUNADBSECRET'].toString(),
        'Content-Type': 'application/json'
      },
      body: jsonEncode(<String, String>{
        'query': TournamentMutations()
            .createTournament(tournamentData, eventInput, locationInput),
      }),
    );
    print("createTournament response: " + jsonDecode(response.body).toString());
    Map<String, dynamic> createdTournament =
        jsonDecode(response.body)['data']['createTournament'];
    print("createdTournament: ");
    print(createdTournament);

    dynamic priceEventInput = {
      "_id": createdTournament['events']['data'][0]['_id'],
    };
    String groupsString = "";
    //create group games from bergerTable
    for (int a = 0; a < bergerTables.length; a++) {
      dynamic bergerTable = bergerTables[a];
      dynamic groupInput = {                        
        "groupNumber": (a + 1),                
      };

      http.Response createGroupResponse = await http.post(
              Uri.parse('https://graphql.fauna.com/graphql'),
              headers: <String, String>{
                'Authorization':
                    'Bearer ' + dotenv.env['FAUNADBSECRET'].toString(),
                'Content-Type': 'application/json'
              },
              body: jsonEncode(<String, String>{
                'query': TournamentMutations()
                    .createGroup(groupInput),
              }),
            );

      print("createGroupResponse: " + jsonDecode(createGroupResponse.body).toString());
      Map<String, dynamic> createdGroup =
          jsonDecode(createGroupResponse.body)['data']['createGroup'];

      print("createdGroup: "+ createdGroup.toString());
      groupsString += createdGroup['_id'] + ", ";
      for (int i = 0; i < bergerTable.length; i++) {
        List<dynamic> roundGames = bergerTable[i];
        for (int k = 0; k < roundGames.length; k++) {
          // if (i == 0 && k < 2) {
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
              'type': EventType.GAME,
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
            //attach game to tournament
            http.Response response = await http.post(
              Uri.parse('https://graphql.fauna.com/graphql'),
              headers: <String, String>{
                'Authorization':
                    'Bearer ' + dotenv.env['FAUNADBSECRET'].toString(),
                'Content-Type': 'application/json'
              },
              body: jsonEncode(<String, String>{
                'query': TournamentMutations()
                    .addEventToTournament(createdTournament, createdEvent),
              }),
            );

            print("addEventtoTournament response body: ");
            print(jsonDecode(response.body));
          // }
        }
      }
    }

    //create groupstage
    Map<String, dynamic> groupStageInput = {
      "tournament_id": createdTournament['_id'],
      "numberOfTeams": tournamentData['numberOfTeams'],
      "groups": groupsString,
    };
    print("groupStageInput: " + groupStageInput.toString());
    http.Response createGroupStageResponse = await http.post(
              Uri.parse('https://graphql.fauna.com/graphql'),
              headers: <String, String>{
                'Authorization':
                    'Bearer ' + dotenv.env['FAUNADBSECRET'].toString(),
                'Content-Type': 'application/json'
              },
              body: jsonEncode(<String, String>{
                'query': TournamentMutations()
                    .createGroupStage(groupStageInput)
              }),
            );

    print("createGroupStageResponse: " + jsonDecode(createGroupStageResponse.body).toString());    



    dynamic findTournamentByIdResponse =
        await findTournamentById(createdTournament['_id']);
    print(
        "findTournamentByIdResponse: " + findTournamentByIdResponse.toString());
    if (findTournamentByIdResponse['success']) {
      //update tournament models
      dynamic tournament = findTournamentByIdResponse['data'];
      print("tournamenttt: " + tournament.toString());
      //get tournament
      //add price
      if (eventInput['price'] > 0) {
        eventInput['price'] = eventInput['price'] * 100;
        Map<String, dynamic> paymentInput = {
          'price': eventInput['price'].toString()
        };
        print("create price,,,, event input: " + priceEventInput.toString());
        print("create price input: " + paymentInput['price'].toString());
        Map<String, dynamic> createPriceResp =
            await EventCommand().createPrice(paymentInput, priceEventInput);
        print("createPaymentResp: " + createPriceResp.toString());

        dynamic createPrice = createPriceResp['data'];
        tournament['events']['data'].forEach((tournamentEvent) {
          if (tournamentEvent['isMainEvent']) {
            tournamentEvent['price'] = createPrice;
          }
        });
        // dynamic mainTournamentEvent = EventCommand().getMainEvent(tournament['events']['data']);
        // print("mainTournamentEvent: "+mainTournamentEvent.toString());
        //assumes first event is main event
        // mainTournamentEvent['price'] = createPrice;
        // await EventCommand().addGame(createdGame, true);
      }
      print("tournament: " + tournament.toString());
      EventCommand().updateViewModelsWithTournament(tournament, true);
    }

    createTournamentResp["success"] = true;
    createTournamentResp["message"] = "Tournament Created";

    return createTournamentResp;
  }

  Future<Map<String, dynamic>> findTournamentById(String tournamentId) async {
    print("getUser");
    Map<String, dynamic> findTournamentByIdResp = {
      "success": false,
      "message": "no Tournament found",
      "data": null
    };
    try {
      print("tournamentId: ");
      print(tournamentId);
      http.Response response = await http.post(
        Uri.parse('https://graphql.fauna.com/graphql'),
        headers: <String, String>{
          'Authorization': 'Bearer ' + dotenv.env['FAUNADBSECRET'].toString(),
          'Content-Type': 'application/json'
        },
        body: jsonEncode(<String, String>{
          'query': TournamentQueries().findTournamentByID(tournamentId),
        }),
      );

      print("response: ");
      print(jsonDecode(response.body));
      final result = jsonDecode(response.body)['data']['findTournamentByID'];
      // appModel.currentUser = result;
      // if (result != null) {
      findTournamentByIdResp["success"] = true;
      findTournamentByIdResp["message"] = "Tournament found";
      findTournamentByIdResp["data"] = result;

      return findTournamentByIdResp;
      // }
    } catch (e) {
      print('Query failed: $e');
    }
    return findTournamentByIdResp;
  }

  //CREDIT TO https://github.com/sasatatar
  //LINK TO CODE: https://github.com/sasatatar/berger-table-generator/blob/master/index.js
 List<dynamic> bergerTable(int size, int numberOfRoundsPerTeam, {bool useDummy = false}) {
  List<dynamic> bergerTableResponse = [];
  List<dynamic> teams = [];
  Object dummy = {};

  for (var i = 0; i < size; i++) {
    teams.add(i);
  }

  if (teams.length % 2 != 0) {
    teams.add(dummy);
  }

  int n = teams.length;
  int numberOfRounds = (n - 1) * numberOfRoundsPerTeam;
  int gamesPerRound = (n / 2).floor();
  print("numberOfRoundsPerTeam: " + numberOfRoundsPerTeam.toString());
  print("numberOfRounds: " + numberOfRounds.toString());

  List<dynamic> columnA = teams.sublist(0, gamesPerRound);
  List<dynamic> columnB = teams.sublist(gamesPerRound);
  dynamic fixed = teams[0];

  for (int i = 0; i < numberOfRounds; i++) {
    int gameCount = 1;
    List<dynamic> acc = [];

    for (int k = 0; k < gamesPerRound; k++) {
      if (useDummy || (columnA[k] != dummy && columnB[k] != dummy)) {
        acc.add({
          "round": (i ~/ numberOfRoundsPerTeam) + 1,
          "game": gameCount,
          "teamA": columnA[k],
          "teamB": columnB[k]
        });
        gameCount++;
      }
    }

    bergerTableResponse.add(acc);

    // rotate elements
    columnA = [fixed, columnB.removeAt(0), ...columnA.sublist(1)];
    columnB.add(columnA.removeLast());
  }

  print("bergerTableResponse");
  print(bergerTableResponse);

  return bergerTableResponse;
}

}
