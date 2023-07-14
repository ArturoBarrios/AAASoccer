import 'package:soccermadeeasy/commands/geolocation_command.dart';
import 'package:soccermadeeasy/commands/notifications_command.dart';
import 'package:soccermadeeasy/constants.dart';
import 'package:soccermadeeasy/models/events_model.dart';
import 'package:soccermadeeasy/models/home_page_model.dart';

import '../graphql/mutations/images.dart';
import '../graphql/mutations/users.dart';
import 'base_command.dart';
import 'package:amplify_api/amplify_api.dart';
import '../commands/game_command.dart';
import '../commands/player_command.dart';
import '../enums/EventType.dart';
import '../graphql/queries/games.dart';
import '../commands/user_command.dart';
import '../graphql/mutations/games.dart';
import '../graphql/mutations/requests.dart';
import '../commands/team_command.dart';
import '../commands/training_command.dart';
import '../commands/tryout_command.dart';
import '../commands/tournament_command.dart';
import '../commands/league_command.dart';
import 'package:http/http.dart' as http;
import '../graphql/mutations/events.dart';
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/intl.dart';

import 'home_page_command.dart';

class EventCommand extends BaseCommand {

  Future<Map<String, dynamic>> notifyEventParticipants(dynamic notifyEventParticipantInput
  ) async {
    Map<String, dynamic> notifyEventParticipantsResponse = {
      "success": false,
      "message": "Default Error",
      "data": null
    };
    print("notifyEventParticipants()");
    print("notifyEventParticipantInput: " + notifyEventParticipantInput.toString());
    try{
      notifyEventParticipantInput['userParticipants']['data'].
      forEach((userParticipantObject) async {
        print("userParticipantObject: " + userParticipantObject.toString());
        if (notifyEventParticipantInput['sendToUserType']==userParticipantObject['user']['userType'].toString()){
          List<String> phones = [];
          List<String> OSPIDs = [];
          phones.add(userParticipantObject['user']['phone']);
          OSPIDs.add(userParticipantObject['user']['OSPID']);
            Map<String, dynamic> sendUserParticipantsNotificationsInput = {
              "phones": phones,                        
              "OSPIDs": OSPIDs,
              "message": notifyEventParticipantInput['message'],
            };            
            await NotificationsCommand().sendUserParticipantsNotifications(sendUserParticipantsNotificationsInput);
        }
      });
    } on ApiException catch (e) {
      print('Mutation failed: $e');
      return notifyEventParticipantsResponse;
    }


    return notifyEventParticipantsResponse;
  }

  dynamic returnMyEventsModel(){
    return appModel.myEvents;

  }



  Future<Map<String, dynamic>> addTeamToEvent(dynamic eventInput,dynamic teamInput)async{
    print("addTeamToEvent()");
    Map<String, dynamic> addTeamToEventResp = {
      "success": false,
      "message": "Default Error",
      "data": null
    };
    
    try{
      print("eventInput: " + eventInput.toString());
      print("teamInput: " + teamInput.toString());
      http.Response response = await http.post(
        Uri.parse('https://graphql.fauna.com/graphql'),
        headers: <String, String>{
          'Authorization': 'Bearer ' + dotenv.env['FAUNADBSECRET'].toString(),
          'Content-Type': 'application/json'
        },
        body: jsonEncode(<String, String>{
          'query': EventMutations().addTeam(eventInput, teamInput),
        }),
      );

      print("response body: ");
      print(jsonDecode(response.body));

       addTeamToEventResp["success"] = true;
       addTeamToEventResp["message"] = "Team added";
       addTeamToEventResp["data"] = jsonDecode(response.body)['data']['updateEvent'];

      return addTeamToEventResp;
    } on ApiException catch (e) {
      print('Mutation failed: $e');
      return addTeamToEventResp;
    }
  }

  List<dynamic> getEventRoles(dynamic event, dynamic user){
    print("getMyTeamRoles()");
    List<dynamic> roles = [];
    dynamic userParticipants = event['userParticipants']['data'];
    print("userParticipants: " + userParticipants.toString());    
    for(int i = 0; i<userParticipants.length; i++){
      if(userParticipants[i]['user']['_id'] == user['_id']){
        roles = BaseCommand().parseRoles(userParticipants[i]['roles']);
      }
    }


    return roles;
  }

  Map<String, dynamic> checkIfUpdateRole(dynamic event, dynamic userObject){    
        print("checkIfUpdateRole");
        dynamic checkIfUpdateRoleResp = {
          "updateRole": false,
          "eventRequestId": ""
        };        
        print("event: " + event.toString());
        userObject['eventUserParticipants']['data']
            .forEach((eventUserParticipantElement) {
          if (eventUserParticipantElement['event']['_id'] == event['_id']) {
            //update role
            checkIfUpdateRoleResp['updateRole'] = true;
            checkIfUpdateRoleResp['eventUserParticipant'] = eventUserParticipantElement['_id'];
          }
          
        });
        print("checkIfUpdateRoleResp: $checkIfUpdateRoleResp");

        return checkIfUpdateRoleResp;
  }

  Future<Map<String, dynamic>> addUserToEvent(
      dynamic eventInput, dynamic userInput, String roles) async {
    print("addUserToEvent");
    Map<String, dynamic> addUserToEventResponse = {
      "success": false,
      "message": "Default Error",
      "data": null
    };
    try {      
      dynamic userObject = UserCommand().getAppModelUser();
      dynamic updateRoleResp = EventCommand().checkIfUpdateRole(eventInput, userObject);
      if(updateRoleResp['updateRole']){
        updateUserRolesInEvent(eventInput, userInput, roles, updateRoleResp['eventUserParticipant']);
      }
      else{
        http.Response response = await http.post(
        Uri.parse('https://graphql.fauna.com/graphql'),
        headers: <String, String>{
          'Authorization': 'Bearer ' + dotenv.env['FAUNADBSECRET'].toString(),
          'Content-Type': 'application/json'
        },
        body: jsonEncode(<String, String>{
          'query': EventMutations().addUserToEvent(eventInput, userInput, roles),
        }),
      );



      print("response body: ");
      print(jsonDecode(response.body));
      
      addEventToMyEvents(jsonDecode(response.body)['data']['updateEvent']);

      }

      return addUserToEventResponse;      
    } on ApiException catch (e) {
      print('Mutation failed: $e');
      return addUserToEventResponse;
    }
  }
  
  Future<Map<String, dynamic>> updateUserRolesInEvent(
      dynamic eventInput, dynamic userInput, String roles, String eventRequestId) async {
    print("updateUserRolesInEvent");
    Map<String, dynamic> addUserToEventResponse = {
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
        'query': EventMutations().updateUserRolesInEvent(eventInput, userInput, roles, eventRequestId),
      }),
    );



    print("response body: ");
    print(jsonDecode(response.body));
    
    addEventToMyEvents(jsonDecode(response.body)['data']['partialUpdateEventUserParticipant']['event']);

      return addUserToEventResponse;      
    } on ApiException catch (e) {
      print('Mutation failed: $e');
      return addUserToEventResponse;
    }
  }




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

  String getProcessedGameInput(dynamic gameInput){
    print("getProcessedGameInput");
    print("gameInput: " + gameInput.toString());
    
    String processedGameInput = """
    """;
    processedGameInput = """
      homegoals: 1,  
    """;

    return processedGameInput;

  }
  
  String getProcessedEventInput(dynamic eventInput){
    print("getProcessedEventInput");
    print("eventInput: " + eventInput.toString());
    String processedEventInput = """
    """;
    processedEventInput = """
      name: "test"
    """;

    return processedEventInput;
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

  Map<String, dynamic> processedGameEventInput = {
    'game': {
      '_id': gameEventInput['_id'],
      'data': getProcessedGameInput(gameEventInput),      
    },
    'event': {
      '_id': gameEventInput['event']['_id'],
      'data': getProcessedEventInput(gameEventInput['event'])
    },
  };

  String test = "name: \"Something Random\"";

    try{
      http.Response response = await http.post(
        Uri.parse('https://graphql.fauna.com/graphql'),
        headers: <String, String>{
          'Authorization': 'Bearer ' + dotenv.env['FAUNADBSECRET'].toString(),
          'Content-Type': 'application/json'
        },
        body: jsonEncode(<String, String>{
          'query':
              GameMutations().partiallyUpdateGameEvent(processedGameEventInput),
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
      if(event['events'] != null){
        event = getMainEvent(event['events']['data']);
      }
      else{
        event = event['event'];
      }
      
      print("event location check: " +
          event['location']['data'][0]['longitude'].toString());
      double latitude = event['location']['data'][0]['latitude'];
      double longitude = event['location']['data'][0]['longitude'];

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



  

  //send organizer event request
  Future<Map<String, dynamic>> sendOrganizerTournamentRequest(
      dynamic tournamentInput, String role) async {
    
    print("sendOrganizerEventRequestttt");
    Map<String, dynamic> sendOrganizerEventRequestResponse = {
      "success": false,
      "message": "Default Error",
      "data": null      
    };
    try {
      print("request for tournament: " + tournamentInput.toString());
      dynamic mainEvent = tournamentInput['events']['data'][0];
      print("mainEvent: " + mainEvent.toString());
      Map<String, dynamic> sendOrganizerEventRequestInput = {
        "sender_id": appModel.currentUser['_id'],
        "event_id": mainEvent['_id'],
        "fromOrganizer": false,
        "forRole": role,
        "type": Constants.TOURNAMENTREQUEST.toString()
      };
      print("sendOrganizerEventRequestInput");
      print(sendOrganizerEventRequestInput);
      

      bool isYourEvent = false;
      dynamic userParticipants =
          mainEvent['userParticipants']['data'];
      
      print("userParticipants: " + userParticipants.toString());
      String organizersString = "";
      String receiver = "";
      print("get OSPIDs");
      //populate list with onesignal player ids
      List<String> OSPIDs = [];
      List<String> phones = [];
      for (var i = 0; i < userParticipants.length; i++) {
        String toUserId = userParticipants[i]['user']['_id'];
        List<String> roles = BaseCommand().parseRoles(userParticipants[i]['roles']);
        print("roles: " + roles.toString());
        if(roles.contains("ORGANIZER")){
          organizersString += toUserId + ",";
          Map<String, dynamic> organizerUserInput = {"_id": toUserId};

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
        }

        
      }      
      sendOrganizerEventRequestInput['receivers'] 
          = organizersString;
      

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
          'query': RequestMutations().sendEventRequest(
              sendOrganizerEventRequestInput), //(fromInput, toInputs, gameInput),
        }),
      );

      print("responseee body: ");
      print(jsonDecode(response.body));

      dynamic createEventRequest =
          jsonDecode(response.body)['data']['createRequest'];
      print("createEventRequest: " + createEventRequest.toString());

      //send notification to organizer(s)
      Map<String, dynamic> sendOrganizerRequestNotificationInput = {
        "phones": phones,
        "message": appModel.currentUser['username'] +
            " has sent you a request to join event",
        "OSPIDs": OSPIDs
      };
      await NotificationsCommand().sendOrganizerRequestNotification(
          sendOrganizerRequestNotificationInput);

      sendOrganizerEventRequestResponse["success"] = true;
      sendOrganizerEventRequestResponse["message"] = "Event Request Created";
      sendOrganizerEventRequestResponse["data"] = jsonDecode(response.body)['data']['createRequest'];
    } catch (e) {}

    return sendOrganizerEventRequestResponse;
  }

  //send player event requests
  Future<Map<String, dynamic>> sendPlayerEventRequests(
      dynamic userPlayerObject,List<dynamic> eventsObject, List<dynamic> roles, String type) async {

    print("sendPlayerEventRequest");
    Map<String, dynamic> sendPlayerEventRequestResponse = {
      "success": false,
      "message": "Default Error",
      "data": null
    };

    try{
      print("userPlayerObject: " + userPlayerObject.toString());
      print("events: " + eventsObject.toString());
      print("roles: " + roles.toString());

      //loop through events
      for(int i = 0;i<eventsObject.length;i++){
        print("loop through events");
        for(int j = 0;j<roles.length;j++){
          print("loop through roles");
          print("roles[j]: " + roles[j]);          
          Map<String, dynamic> sendPlayerEventRequestInput = {
            "sender_id": appModel.currentUser['_id'],
            "event_id": eventsObject[i]['_id'],        
            "forRole": roles[j],
            "type": type,
            "receivers": userPlayerObject['_id']

          };

          print("sendOrganizerEventRequestInput: "+sendPlayerEventRequestInput.toString());

          List<String> OSPIDs = [userPlayerObject['OSPID']];
          List<String> phones = [userPlayerObject['phone']];

          http.Response response = await http.post(
            Uri.parse('https://graphql.fauna.com/graphql'),
            headers: <String, String>{
              'Authorization': 'Bearer ' + dotenv.env['FAUNADBSECRET'].toString(),
              'Content-Type': 'application/json'
            },
            body: jsonEncode(<String, String>{
              'query': RequestMutations().sendEventRequest(
                  sendPlayerEventRequestInput), //(fromInput, toInputs, gameInput),
            }),
          );

          print("responseee body: ");
          print(jsonDecode(response.body));

          Map<String, dynamic> sendPlayerRequestNotificationInput = {
            "phones": phones,
            "message": appModel.currentUser['username'] +
                " has sent you a request to join their event",
            "OSPIDs": OSPIDs
          };

          await NotificationsCommand().sendOrganizerRequestNotification(
              sendPlayerRequestNotificationInput);        
        }

      }

      sendPlayerEventRequestResponse["success"] = true;
      sendPlayerEventRequestResponse["message"] = "Event Requests Created";      


      return sendPlayerEventRequestResponse;
    } catch(e){
      print("error in sendPlayerEventRequest: " + e.toString());
      return sendPlayerEventRequestResponse;
    }


    

  }


  //send organizer event request
  Future<Map<String, dynamic>> sendOrganizerEventRequest(
      dynamic eventInput, String role, type) async {
    
    print("sendOrganizerEventRequestttt");
    Map<String, dynamic> sendOrganizerEventRequestResponse = {
      "success": false,
      "message": "Default Error",
      "data": null      
    };
    try {
      print("request for event: " + eventInput.toString());      

      
      Map<String, dynamic> sendOrganizerEventRequestInput = {
        "sender_id": appModel.currentUser['_id'],
        "event_id": eventInput['_id'],
        "fromOrganizer": false,
        "forRole": role,
        "type": type
      };
      print("sendOrganizerEventRequestInput");
      print(sendOrganizerEventRequestInput);
      

      bool isYourEvent = false;
      dynamic userParticipants =
          eventInput['userParticipants']['data'];
      
      print("userParticipants: " + userParticipants.toString());
      String organizersString = "";
      String receiver = "";
      print("get OSPIDs");
      //populate list with onesignal player ids
      List<String> OSPIDs = [];
      List<String> phones = [];
      for (var i = 0; i < userParticipants.length; i++) {
        String toUserId = userParticipants[i]['user']['_id'];
        List<String> roles = BaseCommand().parseRoles(userParticipants[i]['roles']);
        print("roles: " + roles.toString());
        if(roles.contains("ORGANIZER")){
          organizersString += toUserId + ",";
          Map<String, dynamic> organizerUserInput = {"_id": toUserId};

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
        }

        
      }      
      sendOrganizerEventRequestInput['receivers'] 
          = organizersString;
      

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
          'query': RequestMutations().sendEventRequest(
              sendOrganizerEventRequestInput), //(fromInput, toInputs, gameInput),
        }),
      );

      print("responseee body: ");
      print(jsonDecode(response.body));

      //send notification to organizer(s)
      Map<String, dynamic> sendOrganizerRequestNotificationInput = {
        "phones": phones,
        "message": appModel.currentUser['username'] +
            " has sent you a request to join event",
        "OSPIDs": OSPIDs
      };
      await NotificationsCommand().sendOrganizerRequestNotification(
          sendOrganizerRequestNotificationInput);

      sendOrganizerEventRequestResponse["success"] = true;
      sendOrganizerEventRequestResponse["message"] = "Event Request Created";
      sendOrganizerEventRequestResponse["data"] = jsonDecode(response.body)['data']['createRequest'];
    } catch (e) {}

    return sendOrganizerEventRequestResponse;
  }



  Future<Map<String, dynamic>> getEvent(
      Map<String, dynamic> eventInput) async {
    print("getEventt()");
    print("eventInput: " + eventInput.toString());
    Map<String, dynamic> getEventResponse = {
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
          'query': EventMutations().getEvent(eventInput),
        }),
      );

      print("response: "+ response.body);
      dynamic event = jsonDecode(response.body)['data']['findEventByID'];
      print("event: " + event.toString());
      
      getEventResponse["success"] = true;
      getEventResponse["message"] = "Event Found";
      getEventResponse["data"] = event;
    

    return getEventResponse;
  }

  Future<Map<String, dynamic>> getEventGame(
      Map<String, dynamic> eventRequest) async {
    print("getGameEvent()");
    print("eventRequest: " + eventRequest.toString());
    Map<String, dynamic> getEventResponse = {
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
          'query': GameQueries().getEventGame(eventRequest['_id']),
        }),
      );

      print("response: "+ response.body);
      dynamic game = jsonDecode(response.body)['data']['findEventByID'];
      print("game: " + game.toString());
      
      getEventResponse["success"] = true;
      getEventResponse["message"] = "Event Found";
      getEventResponse["data"] = game;
    

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
    print("eventRequestInput: " + eventRequestInput.toString());
    dynamic getEventGameResp = await getEventGame(eventRequestInput);
    print("getGameEventResp: " + getEventGameResp.toString());
    if(getEventGameResp['success']){
      dynamic eventGame = getEventGameResp['data'];
      print("event: "+getEventGameResp.toString());        
      print("before appModel.myEvents: " + appModel.myEvents.toString());
      appModel.myEvents.add(eventGame);
      
      print("after appModel.myEvents: " + appModel.myEvents.toString());
      addEventToMyEventsResponse["success"] = true;
    }

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
        'query': EventMutations().addPlayerToEventDoesntWork(eventInput, playerInput),
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

  dynamic getMainEvent(List<dynamic> events){
    print("getMainEvent()");
    dynamic event = null;
    for(int i = 0;i<events.length;i++){
      print("events[i]]: " + events[i].toString());
      if(events[i]['isMainEvent'] && 
      (events[i]['type'] == "TOURNAMENT" ||
      events[i]['type'] == "LEAGUE")){
        print("found mainEvent: " + events[i].toString());
        event = events[i];

      }
    }
    print("finish getMainEvent");
    return event;
  }

  Future<Map<String, dynamic>> removeTeamFromEvent(dynamic removeTeamFromEventInput)async{
    print("removeTeamFromEvent()");
    Map<String, dynamic> removeTeamFromEventResponse = {
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
          'query': EventMutations().removeTeamFromEvent(removeTeamFromEventInput),
        }),
      );

      print("response body: ");
      print(jsonDecode(response.body));



      if(jsonDecode(response.body)['data'] != null){
        dynamic removeTeamFromEvent = jsonDecode(response.body)['data']['updateEvent'];
        removeTeamFromEventResponse["success"] = true;
        removeTeamFromEventResponse["message"] = "Team Removed From Event";
        removeTeamFromEventResponse["data"] = removeTeamFromEvent;
      }



      return removeTeamFromEventResponse;
    } on Exception catch (e) {
      print('Mutation failed: $e');
      return removeTeamFromEventResponse;
    } 
  }
  
  //gets isMyEvent, isMember
  Future<Map<String,dynamic>> getUserEventDetails(List<dynamic> events)async {
    print("getUserEventDetails()");

    dynamic isMyEventResp = {
      "success": true,
      "isMine": false,
      "isMember": false,      
      "amountPaid": "0.00",      
      "amountRemaining": "0.00",
      "teamAmountPaid": "0.00",      
      "teamAmountRemaining": "0.00",
      "price": {},
      "paymentObjects": [],
      "mainEvent": null, 
      "team": null,      
      "players": [],
      "freeAgents": [],
      "organizers": [],
      "teams": [],
      "roles": [],
      "chats": [],
      "allEvents": [],
      "groupData": [],
      "groupStage": [],  
      "tournamentStage": [],
      "userParticipants": [],
    };
    print("events length: " + events.length.toString());

    try{      



      //get event
      dynamic event;
      //tournament or league
      if(events.length>1){      
        for(int i = 0;i<events.length;i++){
          print("events[i]: " + events[i].toString());
          if(events[i]['isMainEvent'] && 
          (events[i]['type'] == "TOURNAMENT" ||
          events[i]['type'] == "LEAGUE")){
            print("found mainEvent: " + events[i].toString());
            event = events[i];

          }
          else {
            isMyEventResp['allEvents'].add(events[i]);
          }
        }
      }
      else{
        event = events[0];

      }         
      //get updated event
      dynamic updatedEventResp = await getEventGame(event);
      event = updatedEventResp['data'];

      isMyEventResp['mainEvent'] = event;
      print("main event: " + event.toString());
      print("main event user participants: "+ event['userParticipants'].toString());

      //get main event requests
      Map<String,dynamic> getMainEventResp = await getEvent(event);
      print("getMainEventResp: " + getMainEventResp.toString());
      print("requestssss: "+ getMainEventResp['data']['requests']['data'].toString());


      //get chats
      dynamic chats = event['chats']['data'];

      List<dynamic> myObjectRoles = getEventRoles(event,appModel.currentUser);
      print("myObjectRoles: " + myObjectRoles.toString());
      
      isMyEventResp['roles'] = myObjectRoles;
      isMyEventResp['isMine'] = myObjectRoles.contains("ORGANIZER");
      isMyEventResp['isMember'] = myObjectRoles.contains("PLAYER");


      //get teams
      dynamic teams = event['teams']['data'];
      print("teams:: " + teams.toString());
      isMyEventResp['teams'] = teams;

      //get userParticipation data      
      dynamic userParticipants = event['userParticipants']['data'];
      isMyEventResp['userParticipants'] = userParticipants;
      print("userParticipants: " + userParticipants.toString());
      for(int i = 0; i<userParticipants.length; i++){        
          dynamic userParticipant = userParticipants[i];
          List<String> roles = parseRoles(userParticipant['roles']);
          if(roles.contains("ORGANIZER")){            
            print("isMyEvent() = true");
            isMyEventResp['organizers'].add(userParticipant);
          }
          if(roles.contains("PLAYER")){            
            print("isMember() = true");          
            isMyEventResp['players'].add(userParticipant);
            //check if player belongs to team
            //this code is causing error!
            // if(userParticipant['user']['teams']['data'].length>0&&teams.length>0){
            //   bool playerBelongsToTeam = BaseCommand().checkElementExists(userParticipant['teams']['data'], teams);                                          
            //   print("playerBelongsToTeam: " + playerBelongsToTeam.toString());
            //   if(!playerBelongsToTeam){
            //     isMyEventResp['freeAgents'].add(userParticipant);
            //   }

            // }
            // else{
            //     isMyEventResp['freeAgents'].add(userParticipant);

            // }
          }        
      }     

      print("players: " + isMyEventResp['players'].toString());    
      

      //get payment data
      dynamic payments = event['payments']['data'];
      isMyEventResp['paymentData'] = payments;
      // isMyEventResp['amountPaid'] = "0.00";
      // isMyEventResp['amountRemaining'] = "0.00";
      isMyEventResp['price'] = event['price'];
      if(event['price'] != null){        
        print("event['price']: " + event['price'].toString());
        print("payments: " + payments.toString());      
        //get payment data
        double amountPaid = 0.00;
        double teamAmountPaid = 0.00;        
        for(int i = 0; i<payments.length; i++){          
          if(payments[i]['user']['_id'] == appModel.currentUser['_id']){
            if(payments[i]['isPlayerPayment']){
              print("isPlayerPayment");
              print("amount before parsing: " + payments[i]['amount'].toString());
              amountPaid += double.parse(payments[i]['amount']);            
            }
            else if(payments[i]['isTeamPayment']){
              print("isTeamPayment");
              print("amount before parsing: " + payments[i]['amount'].toString());
              teamAmountPaid += double.parse(payments[i]['amount']);            
            }
          }

        }
        print("aaaaaaaaaaaaaaaaa");
        isMyEventResp['amountPaid'] = (amountPaid).toStringAsFixed(2);
        print("bbbbbbbbbbbbbbbbbb");
        isMyEventResp['amountRemaining'] = (double.parse(event['price']['amount']) - amountPaid).toStringAsFixed(2);        
        print("cccccccccccccccccc");
        isMyEventResp['teamAmountPaid'] = (teamAmountPaid).toStringAsFixed(2);
        print("ddddddddddddddddddddd");        
        isMyEventResp['teamAmountRemaining'] = (double.parse(event['price']['teamAmount']) - teamAmountPaid).toStringAsFixed(2);
        print("eeeeeeeeeeeeeeeeeeeeeeeeeeeeee");
      }
        print("successfully ran details function");
      isMyEventResp["success"] = true;
    } on Exception catch (e) {
      print('Mutation failed: $e');
      return isMyEventResp;
    }


    return isMyEventResp;
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

  

  



  Future<Map<String, dynamic>> setupEventsFromCurrentUser(dynamic user) async {
    print("setupEvents()()");
    
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
          GameCommand().filterGames(games);

      print("started testing!");
      print("games: " + games.toString());

      // for(int i = 0;i<games.length;i++){
      //   List<dynamic> userParticipants =  games[i]['event']['userParticipants']['data'];
      //   for(int j = 0;j<userParticipants.length;j++){
      //     dynamic roles = userParticipants[j]['roles'];                    
      //     BaseCommand().parseRoles(roles);          
      //   }        
      // }
      print("done parsing roles!");
      eventsModel.games = filteredGamesResp['activeEvents'];      
      eventsModel.archivedGames = filteredGamesResp['archivedEvents'];
      eventsModel.events.addAll(games);      
      
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
      print("players length: ");
      print(players.length);
      //remove the current user from the list
      players.removeWhere((element) => element['_id'] == appModel.currentUser['_id']);
      appModel.players = players;
      appModel.playersNearMe = players;
    }
    

    //currentUser is setup by this point. Either from login,
    // or getting user again at top of function
    print("friends: ");
    if(!appModel.isGuest){
      print(appModel.currentUser['friends']['data']);
      appModel.friends = appModel.currentUser['friends']['data'];
      List<dynamic> allMyEvents = appModel.currentUser['eventUserParticipants']['data'];
      print("allMyEvents: "+allMyEvents.toString());
      List myEvents = allMyEvents;
      print("myEvents.length before: "+myEvents.length.toString());
      List myArchivedEvents = [];
      //filter out archived events
      myEvents.removeWhere((event) => BaseCommand().dateTimeFromMilliseconds(event['event']['endTime'].toString()).isBefore(DateTime.now()));
      appModel.myEvents = myEvents;//appModel.currentUser['eventUserParticipants']['data'];
      print("myEvents.length after: "+myEvents.length.toString());
    }

    
    return setupEventsResp;
  }  

  // updates models for views dependent on EventsModel
  Future<Map<String, dynamic>> updateViewModelsWithGame(
      Map<String, dynamic> game, bool add) async {
    print("updateViewModelsWithGame()");
    Map<String, dynamic> updateViewModelsWithGameResp = {
      "success": false,
      "message": "Default Error",
      "data": []
    };
    print("length of events modeL games: ");
    print(eventsModel.games.length);
    print("length of homePageModel selectedObjects: ");
    if(add){
      // await addGame(game, true); 
      //appModel.myEvents = appModel.currentUser['eventUserParticipants']['data'];
      appModel.myEvents.add(game['userParticipants']['data'][0]);
          
    }
    else{
      //in BaseCommand
      appModel.myEvents.remove(game);     
      // await EventCommand().removeGame(game, true);
    }
    UserCommand().findMyUserById();
    if(homePageModel.selectedKey.toString() == Constants.PICKUP.toString()){      
      // homePageModel.selectedKey = Constants.LEAGUE;
      print("homePageModel.selectedObjects.length before: "+ homePageModel.selectedObjects.length.toString());
      if(add){
        homePageModel.selectedObjects.add(game);
      }
      else{
        homePageModel.selectedObjects.remove(game);
      }      
      print("homePageModel.selectedObjects.length after: "+ homePageModel.selectedObjects.length.toString());
      // homePageModel.selectedKey = Constants.PICKUP;
      
    }

    // updateViewModelsWithGameResp["data"]["homePageModel"]["selectedObjects"] 
    //   = homePageModel.selectedObjects;
    
    return updateViewModelsWithGameResp;
  }
 
  Future<Map<String, dynamic>> updateViewModelsWithTournament(
      Map<String, dynamic> tournament, bool add) async {
    print("updateViewModelsWithTournament()");
    Map<String, dynamic> updateViewModelsWithTournamentResp = {
      "success": false,
      "message": "Default Error",
      "data": []
    };
    print("length of events modeL tournament: ");
    print(eventsModel.tournaments.length);
    print("length of homePageModel selectedObjects: ");
    if(add){
      await EventCommand().addTournament(tournament);
    }
    else{
      // await EventCommand().removeTournament(tournament);
    }
    UserCommand().findMyUserById();
    if(homePageModel.selectedKey.toString() == Constants.TOURNAMENT.toString()){
      homePageModel.selectedObjects = List.from(eventsModel.tournaments);
    }
    
    return updateViewModelsWithTournamentResp;
  }
  
  Future<Map<String, dynamic>> updateViewModelsWithLeague(
      Map<String, dynamic> league, bool add) async {
    print("updateViewModelsWithLeague()");
    Map<String, dynamic> updateViewModelsWithLeagueResp = {
      "success": false,
      "message": "Default Error",
      "data": []
    };
    print("length of events modeL league: ");
    print(eventsModel.leagues.length);
    print("length of homePageModel selectedObjects: ");
    if(add){
      await EventCommand().addLeague(league);
    }
    else{
      // await EventCommand().removeLeague(league);
    }
      
    UserCommand().findMyUserById();
    if(homePageModel.selectedKey.toString() == Constants.LEAGUE.toString()){
      homePageModel.selectedObjects = List.from(eventsModel.leagues);
    }
    
    return updateViewModelsWithLeagueResp;
  }

  Future<Map<String, dynamic>> updateViewModelsWithTraining(
      Map<String, dynamic> training) async {
    print("updateViewModelsWithTraining()");
    Map<String, dynamic> updateViewModelsWithTrainingResp = {
      "success": false,
      "message": "Default Error",
      "data": []
    };
    print("length of events modeL trainings: ");
    print(eventsModel.trainings.length);
    print("length of homePageModel selectedObjects: ");
    await EventCommand().addTraining(training, true);
    UserCommand().findMyUserById();
    if(homePageModel.selectedKey.toString() == Constants.TRAINING.toString()){
      homePageModel.selectedObjects = List.from(eventsModel.trainings);
    }
    
    return updateViewModelsWithTrainingResp;
  }
  
  Future<Map<String, dynamic>> updateViewModelsWithTryout(
      Map<String, dynamic> tryout) async {
    print("updateViewModelsWithTryout()");
    Map<String, dynamic> updateViewModelsWithTryoutResp = {
      "success": false,
      "message": "Default Error",
      "data": []
    };
    print("length of events modeL tryouts: ");
    print(eventsModel.tryouts.length);
    print("length of homePageModel selectedObjects: ");

    await EventCommand().addTryout(tryout, true);
    // homePageModel.selectedObjects = [];
    if(homePageModel.selectedKey.toString() == Constants.TRYOUT.toString()){
      homePageModel.selectedObjects = List.from(eventsModel.tryouts);
    }

    return updateViewModelsWithTryoutResp;
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
    if (updateViewModelsBool) await updateViewModelsWithGame(game, true);

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
    print("adding game: " + game.toString());
    print(eventsModel.games.length);
    eventsModel.games.insert(0,game);
    print("length of games after adding game: ");
    print(eventsModel.games.length);
    print("updateViewModelsBool: ");
    print(updateViewModelsBool);
    // if (updateViewModelsBool) await updateViewModelsWithGame(game);

    return addGameResp;
  }
  Future<Map<String, dynamic>> addTournament(
      Map<String, dynamic> tournament) async {
    Map<String, dynamic> addtournamentResp = {
      "success": false,
      "message": "Default Error",
      "data": []
    };
    print("length of tournaments before adding game: ");
    print("adding tournament: " + tournament.toString());
    print(eventsModel.tournaments.length);
    eventsModel.tournaments.insert(0,tournament);
    print("length of trainings after adding tournaments: ");
    print(eventsModel.tournaments.length);    
    // if (updateViewModelsBool) await updateViewModelsWithGame(game);

    return addtournamentResp;
  }
  
  Future<Map<String, dynamic>> addLeague(
      Map<String, dynamic> league) async {
    Map<String, dynamic> addLeagueResp = {
      "success": false,
      "message": "Default Error",
      "data": []
    };
    print("length of tournaments before adding game: ");
    print("adding league: " + league.toString());
    print(eventsModel.leagues.length);
    eventsModel.leagues.insert(0,league);
    print("length of trainings after adding leagues: ");
    print(eventsModel.leagues.length);    
    // if (updateViewModelsBool) await updateViewModelsWithGame(game);

    return addLeagueResp;
  }

  Future<Map<String, dynamic>> addTraining(
      Map<String, dynamic> training, bool updateViewModelsBool) async {
    Map<String, dynamic> addtrainingResp = {
      "success": false,
      "message": "Default Error",
      "data": []
    };
    print("length of trainings before adding game: ");
    print("adding training: " + training.toString());
    print(eventsModel.trainings.length);
    eventsModel.trainings.insert(0,training);
    print("length of trainings after adding training: ");
    print(eventsModel.trainings.length);
    print("updateViewModelsBool: ");
    print(updateViewModelsBool);
    // if (updateViewModelsBool) await updateViewModelsWithGame(game);

    return addtrainingResp;
  }
  
  Future<Map<String, dynamic>> addTryout(
      Map<String, dynamic> tryout, bool updateViewModelsBool) async {
    print("addTryout()");
    Map<String, dynamic> addTryoutResp = {
      "success": false,
      "message": "Default Error",
      "data": []
    };
    print("length of games before adding tryout: ");
    print(eventsModel.tryouts.length);
    eventsModel.tryouts.add(tryout);
    print("length of tryouts after adding game: ");
    print(eventsModel.tryouts.length);
    print("updateViewModelsBool: ");
    print(updateViewModelsBool);
    // if (updateViewModelsBool) await updateViewModelsWithTryout(tryout);

    return addTryoutResp;
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

  

  Future<Map<String, dynamic>> removeUsersRolesFromEvent(dynamic event ,List<dynamic> users, List<dynamic>roles ) async {
    print("removePlayersFromTeam");
    print("event: " + event.toString());
    print("users: " + users.toString());
    print("roles: " + roles.toString());
    
    Map<String, dynamic> removeUsersRolesFromEventResponse = {
      "success": false,
      "message": "Default Error",
      "data": null
    };
      

    // http.Response response = await http.post(
    //   Uri.parse('https://graphql.fauna.com/graphql'),
    //   headers: <String, String>{
    //     'Authorization': 'Bearer ' + dotenv.env['FAUNADBSECRET'].toString(),
    //     'Content-Type': 'application/json'
    //   },
    //   body: jsonEncode(<String, String>{
    //     'query': UserMutations().removeTeamFromUser(userInput, teamInput),
    //   }),
    // );

    // print("response body: ");
    // print(jsonDecode(response.body));

  

    removeUsersRolesFromEventResponse["success"] = true;
    removeUsersRolesFromEventResponse["message"] = "Team Removed";
    // removePlayersFromTeamResponse["data"] =
    //     jsonDecode(response.body)['data']['updateTeam'];

    return removeUsersRolesFromEventResponse;
  }
  
  Future<Map<String, dynamic>> addUsersRolesInEvent(dynamic event ,List<dynamic> users, List<dynamic>roles ) async {
    print("addUsersRolesInEvent");
    print("event: " + event.toString());
    print("users: " + users.toString());
    print("roles: " + roles.toString());
    
    Map<String, dynamic> addUsersRolesInEventResponse = {
      "success": false,
      "message": "Default Error",
      "data": null
    };
      

    // http.Response response = await http.post(
    //   Uri.parse('https://graphql.fauna.com/graphql'),
    //   headers: <String, String>{
    //     'Authorization': 'Bearer ' + dotenv.env['FAUNADBSECRET'].toString(),
    //     'Content-Type': 'application/json'
    //   },
    //   body: jsonEncode(<String, String>{
    //     'query': UserMutations().removeTeamFromUser(userInput, teamInput),
    //   }),
    // );

    // print("response body: ");
    // print(jsonDecode(response.body));

  

    addUsersRolesInEventResponse["success"] = true;
    addUsersRolesInEventResponse["message"] = "Team Removed";
    // removePlayersFromTeamResponse["data"] =
    //     jsonDecode(response.body)['data']['updateTeam'];

    return addUsersRolesInEventResponse;
  }


  //ensure safety of team
  //todo add a make team safe property on Event
  Future<Map<String, dynamic>> removeUsersFromEvent(dynamic event ,List<dynamic> users) async {
    print("removeUsersFromEvent");
    print("event: " + event.toString());
    print("users: " + users.toString());    
    
    Map<String, dynamic> removeUsersFromEventResponse = {
      "success": false,
      "message": "Default Error",
      "data": null
    };
      

    try{
      users.forEach((user) async {
        dynamic userInput = {
          "_id": user['_id'],

        };      

        http.Response response = await http.post(
          Uri.parse('https://graphql.fauna.com/graphql'),
          headers: <String, String>{
            'Authorization': 'Bearer ' + dotenv.env['FAUNADBSECRET'].toString(),
            'Content-Type': 'application/json'
          },
          body: jsonEncode(<String, String>{
            'query': UserMutations().removeEventFromUser(userInput, event),
          }),
        );

        print("response body: ");
        print(jsonDecode(response.body));

        removeUsersFromEventResponse['success'] = true;
        removeUsersFromEventResponse['message'] = "Team from players";

      });
      return removeUsersFromEventResponse;
    } on Exception catch (e) {
      print("Mutation failed: $e");
      return removeUsersFromEventResponse;
    }
    
  }

  Future<Map<String, dynamic>> updateEventUserParticipant(dynamic eventUserParticipant, String newRoles ) async {
    print("updateEventUserParticipant");
    print("newRoles: " + newRoles.toString());
    
    Map<String, dynamic> updateEventUserParticipantResponse = {
      "success": false,
      "message": "Default Error",
      "data": null
    };
      
      dynamic updateEventUserParticipantInput = {
        "_id": eventUserParticipant['_id'],
        "roles": newRoles
      };

    http.Response response = await http.post(
      Uri.parse('https://graphql.fauna.com/graphql'),
      headers: <String, String>{
        'Authorization': 'Bearer ' + dotenv.env['FAUNADBSECRET'].toString(),
        'Content-Type': 'application/json'
      },
      body: jsonEncode(<String, String>{
        'query': EventMutations().updateEventUserParticipant(updateEventUserParticipantInput),
      }),
    );

    print("response body: ");
    print(jsonDecode(response.body));

  

    updateEventUserParticipantResponse["success"] = true;
    updateEventUserParticipantResponse["message"] = "Event User Participant Updated";
    updateEventUserParticipantResponse["data"] =
        jsonDecode(response.body)['data']['updateEventUserParticipant'];

    return updateEventUserParticipantResponse;
  }



}
