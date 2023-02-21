import 'package:soccermadeeasy/commands/geolocation_command.dart';
import 'package:soccermadeeasy/commands/notifications_command.dart';
import 'package:soccermadeeasy/models/events_model.dart';

import 'base_command.dart';
import 'package:amplify_api/amplify_api.dart';
import '../models/Event.dart';
import '../models/app_model.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:faunadb_http/faunadb_http.dart';
import 'package:faunadb_http/query.dart';
import '../models/app_model.dart';
import '../commands/game_command.dart';
import '../commands/player_command.dart';
import '../enums/EventType.dart';
import '../graphql/queries/games.dart';
import '../commands/user_command.dart';
import '../graphql/mutations/games.dart';
import '../commands/team_command.dart';
import '../commands/training_command.dart';
import '../commands/requests_command.dart';
import '../commands/tryout_command.dart';
import '../commands/tournament_command.dart';
import '../commands/league_command.dart';
import '../commands/notifications_command.dart';
import 'package:http/http.dart' as http;
import '../graphql/mutations/events.dart';
import '../graphql/mutations/events.dart';
import '../enums/RequestStatus.dart';
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import './game_command.dart';

class EventCommand extends BaseCommand {
  Future<Map<String, dynamic>> createEvent(
      Map<String, dynamic> eventInput) async {
    print("createEvent");
    Map<String, dynamic> createEventResponse = {
      "success": false,
      "message": "Default Error",
      "data": null
    };
    try {
      return createEventResponse;
    } on ApiException catch (e) {
      print('Mutation failed: $e');
      return createEventResponse;
    }
  }

  Future<Map<String, dynamic>> partiallyUpdateGame(
  dynamic gameEventInput ) async {
    print("partiallyUpdateGame");
    print("gameInput: " + gameEventInput.toString());
    Map<String, dynamic> partiallyUpdateGameResponse = {
      "success": false,
      "message": "Default Error",
      "data": null
    };
  // Map<String, dynamic> gameEventInput = {
  //   'game': {
  //     '_id': gameInput['_id'],
  //     'name': 'Something Random'
  //   },
  //   'event': {
  //     '_id': gameInput['event']['_id'],
  //   },
  // };

    try{
      http.Response response = await http.post(
        Uri.parse('https://graphql.fauna.com/graphql'),
        headers: <String, String>{
          'Authorization': 'Bearer ' + dotenv.env['FAUNADBSECRET'].toString(),
          'Content-Type': 'application/json'
        },
        body: jsonEncode(<String, String>{
          'query':
              GameMutations().partiallyUpdateGameEvent(gameEventInput),
        }),
      );
      print("response body: ");
      print(jsonDecode(response.body));


      return partiallyUpdateGameResponse;
    } on ApiException catch (e) {
      print('Mutation failed: $e');
      return partiallyUpdateGameResponse;


    }
  }

  Future<Map<String, dynamic>> sendPlayerEventRequest(
      Map<String, dynamic> gameInput) async {
    print("sendPlayerEventRequest");
    Map<String, dynamic> sendPlayerEventRequestResponse = {
      "success": false,
      "message": "Default Error",
      "data": null
    };

    return sendPlayerEventRequestResponse;
  }

  Future<Map<String, dynamic>> findEventsNearPoint(
      dynamic events, double distanceFrom) async {
    print("findEventsNearPoint()");
    Map<String, dynamic> findEventsNearPointResp = {
      "success": false,
      "message": "Default Error",
      "data": null
    };
    //iterate through events
    print("iterate through events: " + events.toString());
    events.forEach((event) async {
      print("event: " + event.toString());
      print("event location check: " +
          event['event']['location']['data'][0]['longitude'].toString());
      double latitude = event['event']['location']['data'][0]['latitude'];
      double longitude = event['event']['location']['data'][0]['longitude'];

      double distanceFromUser =
          await GeoLocationCommand().getDistanceFromUser(latitude, longitude);
      print("distanceFromUser: " + distanceFromUser.toString());
      if (distanceFromUser > distanceFrom) {
        events.remove(event);
      }
      //set events in appModel
      eventsModel.eventsNearMe = events;
      print("eventsModel.eventsNearMe: " + eventsModel.eventsNearMe.toString());
    });
    findEventsNearPointResp["success"] = true;
    findEventsNearPointResp["message"] = "Events Near me Found";
    findEventsNearPointResp["data"] = events;

    return findEventsNearPointResp;
  }

  Future<Map<String, dynamic>> sendOrganizerEventRequest(
      dynamic gameInput) async {
    
    print("sendOrganizerEventRequestttt");
    Map<String, dynamic> sendOrganizerEventRequestResponse = {
      "success": false,
      "message": "Default Error",
      "data": null      
    };
    try {
      print("request for event: " + gameInput.toString());
      Map<String, dynamic> sendOrganizerEventRequestInput = {
        "sender_id": appModel.currentUser['_id'],
        "event_id": gameInput['event']['_id'],
      };
      print("sendOrganizerEventRequestInput");
      print(sendOrganizerEventRequestInput);
      //useful for preventing spam(set max to 50 per day)
      //possible solution for creating EventRequest
      //create string with _ids and syntax and call in
      //tos
      bool isYourEvent = false;
      dynamic eventUserOrganizers =
          gameInput['event']['eventUserOrganizers']['users']['data'];
      print("eventUserOrganizers: " + eventUserOrganizers.toString());
      String organizersString = "";
      print("get OSPIDs");
      //populate list with onesignal player ids
      List<String> OSPIDs = [];
      List<String> phones = [];
      for (var i = 0; i < eventUserOrganizers.length; i++) {
        String toUserId = eventUserOrganizers[i]['_id'];
        if (appModel.currentUser['_id'] == toUserId) {
          print("is your event!");
          isYourEvent = true;
        }
        Map<String, dynamic> organizerUserInput = {"user_id": toUserId};

        Map<String, dynamic> getUserResp =
            await UserCommand().findUserById(organizerUserInput);
        print("in for getUserResp: ");
        print(getUserResp);
        if (getUserResp["success"] == true) {
          Map<String, dynamic> user = getUserResp["data"];
          print("user: " + user.toString());
          if (user != null) {
            //it shouldn't be null here, risk for bug
            OSPIDs.add(user['OSPID']);
            phones.add(user['phone']);
          }
        }

        organizersString = organizersString + toUserId + ",";

        //send onesignal notification
      }
      print("organizersString");
      print(organizersString);
      //check if from and to are the same
      http.Response response = await http.post(
        Uri.parse('https://graphql.fauna.com/graphql'),
        headers: <String, String>{
          'Authorization': 'Bearer ' + dotenv.env['FAUNADBSECRET'].toString(),
          'Content-Type': 'application/json'
        },
        body: jsonEncode(<String, String>{
          'query': EventMutations().sendEventRequest(
              sendOrganizerEventRequestInput,
              organizersString,
              organizersString), //(fromInput, toInputs, gameInput),
        }),
      );

      print("responseee body: ");
      print(jsonDecode(response.body));

      dynamic createEventRequest =
          jsonDecode(response.body)['data']['createEventRequest'];
      print("createEventRequest: " + createEventRequest.toString());
      //check if it's from the same user
      //updateEventRequest if it is
      print("check if isYourEvent: " + isYourEvent.toString());
      if (isYourEvent) {
        print("isYourEvent");
        Map<String, dynamic> eventRequestInput = {
          "_id": createEventRequest['_id'],
          "status": RequestStatus.ACCEPTED.toString(),
          "acceptedBy_id": appModel.currentUser['_id'],
          "event": {
            "_id": gameInput['event']['_id'],
          }
        };
        //get event
        await RequestsCommand().updateEventRequests(eventRequestInput);
      }

      Map<String, dynamic> sendOrganizerRequestNotificationInput = {
        "phones": phones,
        "message": appModel.currentUser['name'] +
            " has sent you a request to join event",
        "OSPIDs": OSPIDs
      };
      await NotificationsCommand().sendOrganizerRequestNotification(
          sendOrganizerRequestNotificationInput);

      sendOrganizerEventRequestResponse["success"] = true;
      sendOrganizerEventRequestResponse["message"] = "Event Request Created";
      // sendOrganizerEventRequestResponse["data"] = jsonDecode(response.body)['data']['CreateEventRequest'];
    } catch (e) {}

    return sendOrganizerEventRequestResponse;
  }

  Future<Map<String, dynamic>> getEvent(
      Map<String, dynamic> eventRequest) async {
    print("getEvent()");
    Map<String, dynamic> getEventResponse = {
      "success": false,
      "message": "Default Error",
      "data": null
    };
    //get event
    if (eventRequest['event']['EventType'] == EventType.GAME) {
      http.Response response = await http.post(
        Uri.parse('https://graphql.fauna.com/graphql'),
        headers: <String, String>{
          'Authorization': 'Bearer ' + dotenv.env['FAUNADBSECRET'].toString(),
          'Content-Type': 'application/json'
        },
        body: jsonEncode(<String, String>{
          'query': GameQueries().getGame(eventRequest['game_id']),
        }),
      );
    }

    return getEventResponse;
  }

  Future<Map<String, dynamic>> addEventToMyEvents(
      Map<String, dynamic> eventRequestInput) async {
    print("addEventToMyEvents");
    Map<String, dynamic> addEventToMyEventsResponse = {
      "success": false,
      "message": "Default Error",
      "data": null
    };
    print("before getEvent");
    dynamic event = getEvent(eventRequestInput['event']['_id']);
    print("event: " + event.toString());
    appModel.myEvents.add(event);
    addEventToMyEventsResponse["success"] = true;

    return addEventToMyEventsResponse;
  }

  Future<Map<String, dynamic>> addPlayerToEvent(
      Map<String, dynamic> eventInput, Map<String, dynamic> playerInput) async {
    print("addPlayerToEvent");
    Map<String, dynamic> addPlayerToEventResponse = {
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
        'query': EventMutations().addPlayerToEvent(eventInput, playerInput),
      }),
    );

    print("response body: ");
    print(jsonDecode(response.body));

    addPlayerToEventResponse["success"] = true;
    addPlayerToEventResponse["message"] = "Game Created";
    addPlayerToEventResponse["data"] =
        jsonDecode(response.body)['data']['updateEvent'];

    return addPlayerToEventResponse;
  }

  Future<Map<String, dynamic>> getEvents() async {
    Map<String, dynamic> getEventsResp = {
      "success": false,
      "message": "Default Error",
      "data": []
    };
    try {
      // http.Response response = await http.post(
      //   Uri.parse('https://graphql.fauna.com/graphql'),
      //   headers: <String, String>{
      //     'Authorization': 'Bearer '+ dotenv.env['FAUNADBSECRET'].toString(),
      //     'Content-Type': 'application/json'
      //   },
      //   body: jsonEncode(<String, String>{
      //     'query': EventQueries().getEvents(),
      //   }),
      // );

      // print("response body: ");
      // print(jsonDecode(response.body));
      // getEventsResp["success"] = true;
      // getEventsResp["message"] = "Events Retrieved";
      // getEventsResp["data"] = jsonDecode(response.body)['data']['allEvent']['data'];

    } on Exception catch (e) {
      print('Mutation failed: $e');
      return getEventsResp;
    } on Exception catch (e) {
      print('Mutation failed: $e');
    }

    return getEventsResp;
  }

  Future<Map<String, dynamic>> getGames(bool pickup) async {
    Map<String, dynamic> getEventResp = {
      "success": false,
      "message": "Default Error",
      "data": []
    };
    try {
      // http.Response response = await http.post(
      //   Uri.parse('https://graphql.fauna.com/graphql'),
      //   headers: <String, String>{
      //     'Authorization': 'Bearer '+ dotenv.env['FAUNADBSECRET'].toString(),
      //     'Content-Type': 'application/json'
      //   },
      //   body: jsonEncode(<String, String>{
      //     'query': EventQueries().getEvent(id),
      //   }),
      // );

      // print("response body: ");
      // print(jsonDecode(response.body));
      // getEventResp["success"] = true;
      // getEventResp["message"] = "Event Retrieved";
      // getEventResp["data"] = jsonDecode(response.body)['data']['findEventByID']['data'];

    } on Exception catch (e) {
      print('Mutation failed: $e');
      return getEventResp;
    } on Exception catch (e) {
      print('Mutation failed: $e');
    }

    return getEventResp;
  }

  bool isMyEvent(dynamic event){
    bool resp = false;
    dynamic eventUserOrganizers = event['eventUserOrganizers']['users']['data'];

    for(int i = 0; i<eventUserOrganizers.length; i++){
      if(eventUserOrganizers[i]['_id'] == appModel.currentUser['_id']){
        resp = true;
      }
    }

    return resp;
  }

  Future<Map<String, dynamic>> createPrice(dynamic paymentInput, dynamic eventInput) async {
    print("createPrice()");
    Map<String, dynamic> createPriceResp = {
      "success": false,
      "message": "Default Error",
      "data": []
    };

    try {
      http.Response response = await http.post(
        Uri.parse('https://graphql.fauna.com/graphql'),
        headers: <String, String>{
          'Authorization': 'Bearer ' + dotenv.env['FAUNADBSECRET'].toString(),
          'Content-Type': 'application/json'
        },
        body: jsonEncode(<String, String>{
          'query': EventMutations()
              .createPrice(paymentInput, eventInput),
        }),
      );
      print("response body: ");
      print(jsonDecode(response.body));
      Map<String, dynamic> createdPayment = jsonDecode(response.body)['data']['createPrice'];
      print("createdPayment: " + createdPayment.toString());
      createPriceResp["success"] = true;
      createPriceResp["message"] = "Payment Created";
      createPriceResp["data"] = createdPayment;

      return createPriceResp;

    } on Exception catch (e) {
      print("Mutation failed: $e");
      return createPriceResp;
    }

  }

  Future<Map<String, dynamic>> setupEvents(dynamic user) async {
    print("setupEvents()()");
    print("user: " + user.toString());
    Map<String, dynamic> setupEventsResp = {
      "success": false,
      "message": "Default Error",
      "data": []
    };
    //think of sorting friends by location
    //
    print("getGamesNearLocation in setupEvents()");
    Map<String, dynamic> getGamesNearLocationResp =
        await GameCommand().getGamesNearLocation();
    if (getGamesNearLocationResp['success']) {
      List<dynamic> games = getGamesNearLocationResp['data'];
      print("in if statement");
      print("games: " + games.toString());
      print("length of games: " + games.length.toString());
      //add games to eventsModel
      //filter out archived games
      Map<String, dynamic> filteredGamesResp =
          await GameCommand().filterGames(games);

      eventsModel.games = filteredGamesResp['activeEvents'];
      eventsModel.archivedGames = filteredGamesResp['archivedEvents'];
      eventsModel.events.addAll(games);
      homePageModel.selectedObjects =
          json.decode(json.encode(filteredGamesResp['activeEvents']));
      print("length of games: " + games.length.toString());
    }
    Map<String, dynamic> getLeaguesNearLocationResp =
        await LeagueCommand().getLeaguesNearLocation();
    if (getLeaguesNearLocationResp['success']) {
      List<dynamic> leagues = getLeaguesNearLocationResp['data'];
      print("in if statement");
      print("leagues: " + leagues.toString());
      eventsModel.leagues = leagues;
      eventsModel.events.addAll(leagues);
    }
    Map<String, dynamic> getTournamentsNearLocationResp =
        await TournamentCommand().getTournamentsNearLocation();
    if (getTournamentsNearLocationResp['success']) {
      List<dynamic> tournaments = getTournamentsNearLocationResp['data'];
      print("in if statement");
      print("tournaments: " + tournaments.toString());
      eventsModel.tournaments = tournaments;
      eventsModel.events.addAll(tournaments);
    }
    Map<String, dynamic> getTrainingsNearLocationResp =
        await TrainingCommand().getTrainingsNearLocation();
    if (getTrainingsNearLocationResp['success']) {
      List<dynamic> trainings = getTrainingsNearLocationResp['data'];
      print("trainings: ");
      print(trainings);
      eventsModel.trainings = trainings;
      eventsModel.events.addAll(trainings);
    }
    Map<String, dynamic> getTryoutsNearLocationResp =
        await TryoutCommand().getTryoutsNearLocation();
    if (getTryoutsNearLocationResp['success']) {
      List<dynamic> tryouts = getTryoutsNearLocationResp['data'];
      print("tryouts: ");
      print(tryouts);
      eventsModel.tryouts = tryouts;
      eventsModel.events.addAll(tryouts);
    }
    Map<String, dynamic> getPlayersNearLocationResp =
        await PlayerCommand().getPlayersNearLocation();
    if (getPlayersNearLocationResp['success']) {
      List<dynamic> players = getPlayersNearLocationResp['data'];
      print("players: ");
      print(players);
      appModel.players = players;
      appModel.playersNearMe = players;
    }
    Map<String, dynamic> getTeamsNearLocationResp =
        await TeamCommand().getTeamsNearLocation();
    if (getTeamsNearLocationResp['success']) {
      List<dynamic> teams = getTeamsNearLocationResp['data'];
      print("teams: ");
      print(teams);
      appModel.teams = teams;
    }

    //currentUser is setup by this point. Either from login,
    // or getting user again at top of function
    print("friends: ");
    print(appModel.currentUser['friends']['data']);
    appModel.friends = appModel.currentUser['friends']['data'];
    appModel.myEvents = appModel.currentUser['events']['data'];

    return setupEventsResp;
  }

  // updates models for views dependent on EventsModel
  Future<Map<String, dynamic>> updateViewModelsWithGame(
      Map<String, dynamic> game) async {
    print("updateViewModelsWithGame()");
    Map<String, dynamic> updateViewModelsWithGameResp = {
      "success": false,
      "message": "Default Error",
      "data": []
    };
    print("length of events modeL games: ");
    print(eventsModel.games.length);
    print("length of homePageModel selectedObjects: ");
    homePageModel.selectedObjects = List.from(eventsModel.games);

    return updateViewModelsWithGameResp;
  }

  Future<Map<String, dynamic>> archiveGame(
      Map<String, dynamic> game, bool updateViewModelsBool) async {
    Map<String, dynamic> archiveGameResp = {
      "success": false,
      "message": "Default Error",
      "data": []
    };
    print("length of games before archiving game: ");
    print(eventsModel.games.length);
    var i = 0;
    var found = false;
    while (i < eventsModel.games.length - 1 && !found) {
      if (eventsModel.games[i]['id'] == game['id']) {
        var removed = eventsModel.games.removeAt(i);
        print("removedGameObject: ");
        print(removed);
        found = true;
      }
      i += 1;
    }
    print("length of games after archiving game: ");
    print(eventsModel.games.length);
    print("updateViewModelsBool: ");
    print(updateViewModelsBool);
    if (updateViewModelsBool) await updateViewModelsWithGame(game);

    return archiveGameResp;
  }

  Future<Map<String, dynamic>> addGame(
      Map<String, dynamic> game, bool updateViewModelsBool) async {
    Map<String, dynamic> addGameResp = {
      "success": false,
      "message": "Default Error",
      "data": []
    };
    print("length of games before adding game: ");
    print(eventsModel.games.length);
    eventsModel.games.add(game);
    print("length of games after adding game: ");
    print(eventsModel.games.length);
    print("updateViewModelsBool: ");
    print(updateViewModelsBool);
    if (updateViewModelsBool) await updateViewModelsWithGame(game);

    return addGameResp;
  }

  Future<Map<String, dynamic>> removeEvent(
      Map<String, dynamic> event, bool updateViewModelsBool) async {
    Map<String, dynamic> removeEventResp = {
      "success": false,
      "message": "Default Error",
      "data": []
    };

    print("length of events before removing events: ");
    print(eventsModel.events.length);
    eventsModel.events.add(event);
    print("length of games after removing game: ");
    print(eventsModel.events.length);
    print("updateViewModelsBool: ");
    print(updateViewModelsBool);
    // if (updateViewModelsBool) await removeEventFromViewModels(game);

    return removeEventResp;
  }

  Future<Map<String, dynamic>> setupMappedEvents() async {
    Map<String, dynamic> setupMappedEventsResp = {
      "success": false,
      "message": "Default Error",
      "data": null
    };
    try {
      EventsModel().mappedEvents = {
        "0": EventsModel().games,
        "3": EventsModel().tryouts,
        "4": EventsModel().tournaments,
        "5": EventsModel().leagues,
      };
    } on Exception catch (e) {
      print('Could not setup mapped events: $e');
      return setupMappedEventsResp;
    }

    return setupMappedEventsResp;
  }
}
