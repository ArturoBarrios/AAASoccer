import 'dart:convert';
import 'dart:math';
import 'package:soccermadeeasy/graphql/queries/tournaments.dart';

import '../constants.dart';
import '../models/enums/EventType.dart';
import 'base_command.dart';
import 'package:amplify_api/amplify_api.dart';
import 'package:faunadb_http/faunadb_http.dart';
import 'package:faunadb_http/query.dart';
import '../models/pageModels/app_model.dart';
import '../commands/event_command.dart';
import '../commands/game_command.dart';
import '../graphql/mutations/tournaments.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../../testing/seeding/location_seeder.dart';
import '../commands/geolocation_command.dart';
// import 'package:geolocator/geolocator.dart';

class TournamentCommand extends BaseCommand {
  updateTournamentNumberOfTeams(){
    
  }

  Future<Map<String, dynamic>> addTeamToTeamOrder(
      dynamic teamOrderInput) async {
    print("addTeamToGroup");
    print(teamOrderInput.toString());
    Map<String, dynamic> addTeamToGroupResp = {
      "success": false,
      "message": "Default Error",
      "data": null
    };

    try {
      http.Response response = await http.post(
        Uri.parse('https://graphql.fauna.com/graphql'),
        headers: <String, String>{
          'Authorization': 'Bearer ' + dotenv.env['FAUNADBSECRET'].toString(),
          'Content-Type': 'application/json'
        },
        body: jsonEncode(<String, String>{
          'query': TournamentMutations().addTeamToTeamOrder(teamOrderInput),
      }),
      );

      print("response body: ");
      print(jsonDecode(response.body));

      final updateGroupResp =
          jsonDecode(response.body)['data']['updateTeamOrder'];   

             
      if (updateGroupResp != null) {
        addTeamToGroupResp['success'] = true;
        addTeamToGroupResp['message'] = "Successfully added team to group stage";
        addTeamToGroupResp['data'] = updateGroupResp;
      }
      

      return addTeamToGroupResp;
    } catch (e) {
      print("addTeamToGroupStage error");
      print(e);
      return addTeamToGroupResp;
    }
  }

  Future<Map<String, dynamic>> removeTeamFromTeamOrder(
      dynamic teamOrderInput) async {
    print("removeTeamFromTeamOrder");
    print(teamOrderInput.toString());
    Map<String, dynamic> removeTeamFromTeamOrderResp = {
      "success": false,
      "message": "Default Error",
      "data": null
    };

    try {
      http.Response response = await http.post(
        Uri.parse('https://graphql.fauna.com/graphql'),
        headers: <String, String>{
          'Authorization': 'Bearer ' + dotenv.env['FAUNADBSECRET'].toString(),
          'Content-Type': 'application/json'
        },
        body: jsonEncode(<String, String>{
          'query': TournamentMutations().removeTeamFromTeamOrder(teamOrderInput),
        }),
      );

      print("response body: ");
      print(jsonDecode(response.body));

      final updateTeamOrder =
          jsonDecode(response.body)['data']['updateTeamOrder'];   
      print("updateTeamOrder: "+ updateTeamOrder.toString());
             
      if (updateTeamOrder != null) {
        removeTeamFromTeamOrderResp['success'] = true;
        removeTeamFromTeamOrderResp['message'] = "Successfully added team to group stage";
        removeTeamFromTeamOrderResp['data'] = updateTeamOrder;
      }
      

      return removeTeamFromTeamOrderResp;
    } catch (e) {
      print("removeTeamFromTeamOrder error");
      print(e);
      return removeTeamFromTeamOrderResp;
    }
  }

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
    dynamic getMainEvent;
    tournament['events']['data'].forEach((event) {
      if (event['isMainEvent'] == true) {
        getMainEvent = event;
      }
    });
    
    return getMainEvent;
  }

  List<dynamic> sortTournaments(List<dynamic> tournaments, String sortBy){
    print("sortTournaments()");      
    print("sortBy: " + sortBy);
    List<dynamic> sortedTournaments = List.from(tournaments);
      
      sortedTournaments.sort((a, b) {
  dynamic mainEventA = EventCommand().getMainEvent(a['events']['data']);
  dynamic mainEventB = EventCommand().getMainEvent(b['events']['data']);
  print("mainEventA: " + mainEventA.toString());
  print("mainEventB: " + mainEventB.toString());
  if (mainEventA != null && mainEventB != null) {
    DateTime startTimeA = DateTime.fromMillisecondsSinceEpoch(int.parse(mainEventA['startTime']));
    DateTime startTimeB = DateTime.fromMillisecondsSinceEpoch(int.parse(mainEventB['startTime']));
    return startTimeB.compareTo(startTimeA);
  }

  // Handle cases where main events are not available
  return 0;
});
      return sortedTournaments;

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
      
      dynamic allTournaments =
          jsonDecode(response.body)['data']['allTournaments']['data'];
      print("allTournaments length: " + allTournaments.length.toString());
      if(allTournaments.length>0){
        allTournaments = sortTournaments(allTournaments, Constants.CREATEDATE);
      }

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
      Map<String, dynamic> locationInput, 
      dynamic league) async {
    print("createTournament");
    print("tournamentData: " + tournamentData.toString());
    print("league: " + league.toString());
    Map<String, dynamic> createTournamentResp = {
      "success": false,
      "message": "Something went wrong with creating game relationships",
      "data": null,
    };
    eventInput['price'] = eventInput['price']*100;
    eventInput['teamPrice'] = eventInput['teamPrice'] * 100;
    eventInput['user_id'] = appModel.currentUser['_id'];
    print("eventInput: " + eventInput.toString());
    var rng = Random();

    int numberOfTeams = tournamentData['numberOfTeams'] as int;
    int numberOfGroups = tournamentData['numberOfGroups'];
    print("numberOfGroups: " + numberOfGroups.toString());
    print("numberOfTeams: " + numberOfTeams.toString());
    dynamic bergerTables = [];
    //create groupStage
    for (int i = 0; i < numberOfGroups; i++) {
      List<dynamic> bergerTable = TournamentCommand().bergerTable(
          tournamentData['numberOfTeamsPerGroup'],
          tournamentData['numberOfRoundsPerTeam']);
      print("bergerTable length: " + bergerTable.length.toString());
      bergerTables.add(bergerTable);
      //create group
    }
    print("bergerTables: " + bergerTables.length.toString());

    http.Response response = await http.post(
      Uri.parse('https://graphql.fauna.com/graphql'),
      headers: <String, String>{
        'Authorization': 'Bearer ' + dotenv.env['FAUNADBSECRET'].toString(),
        'Content-Type': 'application/json'
      },
      body: jsonEncode(<String, String>{
        'query': TournamentMutations()
            .createTournament(tournamentData, eventInput, locationInput, league),
      }),
    );
    print("createTournament response: " + jsonDecode(response.body).toString());

    if(response.statusCode == 200){            
      Map<String, dynamic> createdTournament =
          jsonDecode(response.body)['data']['createTournament'];
      print("createdTournament: ");
      print(createdTournament);

    
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
            'Authorization': 'Bearer ' + dotenv.env['FAUNADBSECRET'].toString(),
            'Content-Type': 'application/json'
          },
          body: jsonEncode(<String, String>{
            'query': TournamentMutations().createGroup(groupInput),
          }),
        );

        print("createGroupResponse: " +
            jsonDecode(createGroupResponse.body).toString());
        Map<String, dynamic> createdGroup =
            jsonDecode(createGroupResponse.body)['data']['createGroup'];

        print("createdGroup: " + createdGroup.toString());
        groupsString += createdGroup['_id'] + ", ";

        //create TeamOrders inside group
        for(int i = 0;i<tournamentData['numberOfTeamsPerGroup'];i++){
          dynamic teamOrderInput = {
            "group_id": createdGroup['_id'],
            "points": 0,
            "order": i+1,
          };
          http.Response createTeamOrdersResponse = await http.post(
            Uri.parse('https://graphql.fauna.com/graphql'),
            headers: <String, String>{
              'Authorization': 'Bearer ' + dotenv.env['FAUNADBSECRET'].toString(),
              'Content-Type': 'application/json'
            },
            body: jsonEncode(<String, String>{
              'query': TournamentMutations().createTeamOrder(teamOrderInput),
            }),
          );

          dynamic createdTeamOrder = jsonDecode(createTeamOrdersResponse.body)['data']['createTeamOrder'];
          createdGroup['teamOrders']['data'].add(createdTeamOrder);
        }


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
          'Authorization': 'Bearer ' + dotenv.env['FAUNADBSECRET'].toString(),
          'Content-Type': 'application/json'
        },
        body: jsonEncode(<String, String>{
          'query': TournamentMutations().createGroupStage(groupStageInput)
        }),
      );

      print("createGroupStageResponse: " +
          jsonDecode(createGroupStageResponse.body).toString());
      Map<String, dynamic> createdGroupStage =
          jsonDecode(createGroupStageResponse.body)['data']['createGroupStage'];

      //create TournamentStage
      dynamic tournamentStageInput = {
        "numberOfTeams": tournamentData['roundOfX'],
        "tournament_id": createdTournament['_id'],
        "numberOfRoundsPerTeam": tournamentData['knockoutRounds'],
      };

      http.Response createTournamentStageResponse = await http.post(
        Uri.parse('https://graphql.fauna.com/graphql'),
        headers: <String, String>{
          'Authorization': 'Bearer ' + dotenv.env['FAUNADBSECRET'].toString(),
          'Content-Type': 'application/json'
        },
        body: jsonEncode(<String, String>{
          'query':
              TournamentMutations().createTournamentStage(tournamentStageInput)
        }),
      );

      print("createTournamentStageResponse: " +
          jsonDecode(createTournamentStageResponse.body).toString());

      dynamic createdTournamentStage =
          jsonDecode(createTournamentStageResponse.body)['data']
              ['createTournamentStage'];
      print("createdTournamentStage: " + createdTournamentStage.toString());

      //createEventOrder
      for (int i = 0; i < tournamentData['roundOfX'] / 2; i++) {
        //create EventOrder
        dynamic eventOrderInput = {
          "order": i + 1,
          "name": "Round ${i + 1}",
          "tournamentStage_id": createdTournamentStage['_id'],
        };

        http.Response createEventOrderResponse = await http.post(
          Uri.parse('https://graphql.fauna.com/graphql'),
          headers: <String, String>{
            'Authorization': 'Bearer ' + dotenv.env['FAUNADBSECRET'].toString(),
            'Content-Type': 'application/json'
          },
          body: jsonEncode(<String, String>{
            'query': TournamentMutations().createEventOrder(eventOrderInput)
          }),
        );

        print("createEventOrderResponse: " +
            jsonDecode(createEventOrderResponse.body).toString());
        dynamic createdEventOrder =
            jsonDecode(createEventOrderResponse.body)['data']['createEventOrder'];
        print("createdEventOrder: " + createdEventOrder.toString());
      }

      dynamic findTournamentByIdResponse =
          await findTournamentById(createdTournament['_id']);
      print(
          "findTournamentByIdResponse: " + findTournamentByIdResponse.toString());
      if (findTournamentByIdResponse['success']) {
        //update tournament models
        dynamic tournament = findTournamentByIdResponse['data'];
        tournament['tournamentStage'] = createdTournamentStage;
        tournament['groupStage'] = createdGroupStage;        

        print("tournament: " + tournament.toString());
        
      }

      createTournamentResp["success"] = true;
      createTournamentResp["message"] = "Tournament Created";
      createTournamentResp["data"] = createdTournament;
      

    }

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
      if(response.statusCode == 200){
        final result = jsonDecode(response.body)['data']['findTournamentByID'];

        findTournamentByIdResp["success"] = true;
        findTournamentByIdResp["message"] = "Tournament found";
        findTournamentByIdResp["data"] = result;

      }

      return findTournamentByIdResp;
      // }
    } catch (e) {
      print('Query failed: $e');
    }
    return findTournamentByIdResp;
  }

  //CREDIT TO https://github.com/sasatatar
  //LINK TO CODE: https://github.com/sasatatar/berger-table-generator/blob/master/index.js
  List<dynamic> bergerTable(int size, int numberOfRoundsPerTeam,
      {bool useDummy = false}) {
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
