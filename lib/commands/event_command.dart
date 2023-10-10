import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:soccermadeeasy/commands/geolocation_command.dart';
import 'package:soccermadeeasy/commands/network/base_api_client.dart';
import 'package:soccermadeeasy/commands/network_models/fql_request_models/in_body.dart';
import 'package:soccermadeeasy/commands/network_models/fql_request_models/object_params_body.dart';
import 'package:soccermadeeasy/commands/network_models/fql_request_models/social_media_app_data.dart';
import 'package:soccermadeeasy/commands/notifications_command.dart';
import 'package:soccermadeeasy/constants.dart';
import 'package:soccermadeeasy/extensions/parse_roles.dart';
import 'package:soccermadeeasy/graphql/fragments/event_fragments.dart';
import 'package:soccermadeeasy/models/pageModels/event_page_model.dart';

import '../components/join_condition.dart';
import '../graphql/queries/events.dart';
import '../views/social_media_cards_view/social_media_cards_view.dart';
import 'base_command.dart';
import 'package:amplify_api/amplify_api.dart';
import '../commands/player_command.dart';
import '../models/enums/EventType.dart';
import '../graphql/queries/games.dart';
import '../commands/user_command.dart';
import '../graphql/mutations/games.dart';
import '../graphql/mutations/requests.dart';
import '../commands/tournament_command.dart';
import '../commands/league_command.dart';
import 'package:http/http.dart' as http;
import '../graphql/mutations/events.dart';
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'home_page_command.dart';
import 'images_command.dart';
import 'network/util/api_graphql_operation_type.dart';
import 'network/util/api_response.dart';
import 'network_models/add_social_media_apps_request.dart';
import 'network_models/base_update_response_model.dart';
import 'network_models/fql_request_models/add_social_media_apps.dart';
import 'network_models/fql_request_models/add_social_media_apps_let.dart';
import 'network_models/fql_request_models/collection_body.dart';
import 'network_models/fql_request_models/ref_body.dart';
import 'network_models/fql_request_models/var_body.dart';
import 'package:soccermadeeasy/extensions/share_image_text.dart';

class EventCommand extends BaseCommand {  
  void addTeamCallback(dynamic team) {
   
  }

  Future<void> onTapShare(String mainImageKey) async {
    await 'Hey there, check out this event'
        .share(imageKey: mainImageKey);
  }

  Future<void> onTapSocialMediaApp(BuildContext context) async {
    Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (BuildContext context) => const SocialMediaCardsView(
            // object: widget.game,
            ),
      ),
    );
  }

  List<dynamic> sortEventsBy(List<dynamic> events) {
    print("sortEventsBy");
    List<dynamic> sortedEvents = List.from(events);
    sortedEvents.sort((a, b) {
      int aCreatedAt = int.tryParse(a["event"]["createdAt"]) ?? 0;
      int bCreatedAt = int.tryParse(b["event"]["createdAt"]) ?? 0;
      print("aCreatedAt: $aCreatedAt");
      print("bCreatedAt: $bCreatedAt");
      return bCreatedAt.compareTo(aCreatedAt);
    });

    return sortedEvents;
  }

  List getEventUserRoles() {
    List eventUserRoles = [
      Constants.PLAYER,
      Constants.ORGANIZER,
      Constants.REF
    ];
    return eventUserRoles;
  }

  Future<Map<String, dynamic>> archiveEvent(dynamic eventObject) async {
    Map<String, dynamic> archiveEventResp = {
      "success": false,
      "message": "Pickup deleted successfully"
    };
    print("eventObject: $eventObject");
    http.Response response = await http.post(
      Uri.parse('https://graphql.fauna.com/graphql'),
      headers: <String, String>{
        'Authorization': 'Bearer ${dotenv.env['FAUNADBSECRET']}',
        'Content-Type': 'application/json'
      },
      body: jsonEncode(<String, String>{
        'query': GameMutations().archiveEvent(eventObject),
      }),
    );

    print("response body: ");
    print(jsonDecode(response.body));

    if (response.statusCode == 200) {
      dynamic archivedEvent = jsonDecode(response.body)['data']['updateEvent'];

      print("type GAME");
      EventCommand().updateViewModelsWithEvent(archivedEvent, false);
      archiveEventResp["success"] = true;
    }

    return archiveEventResp;
  }

  dynamic returnMyEventsModel() {
    return appModel.myEvents;
  }

  void addEventToEventModels(dynamic event) {
    // print("addEventtoEventModels()");
    // print("event: " + event.toString());
    String enumValue = event['type'].toString().split('.').last;
    print("enumValue: $enumValue");
    print("event: $event");
    switch (enumValue) {
      case "GAME":
        eventsModel.games.add(event);
        break;
      case "TRAINING":
        eventsModel.trainings.add(event);
        break;
      case "TRYOUT":
        eventsModel.tryouts.add(event);
        break;
      case "TOURNAMENT":
        eventsModel.tournaments.add(event);
        break;
      case "LEAGUE":
        eventsModel.leagues.add(event);
        break;
      default:
        print("event type not found");
    }
  }

  Future<Map<String, dynamic>> addTeamToEvent(
      dynamic eventInput, dynamic teamInput) async {
    print("addTeamToEvent()");
    Map<String, dynamic> addTeamToEventResp = {
      "success": false,
      "message": "Default Error",
      "data": null
    };

    try {
      print("eventInput: $eventInput");
      print("teamInput: $teamInput");
      http.Response response = await http.post(
        Uri.parse('https://graphql.fauna.com/graphql'),
        headers: <String, String>{
          'Authorization': 'Bearer ${dotenv.env['FAUNADBSECRET']}',
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
      addTeamToEventResp["data"] =
          jsonDecode(response.body)['data']['updateEvent'];

      return addTeamToEventResp;
    } on ApiException catch (e) {
      print('Mutation failed: $e');
      return addTeamToEventResp;
    }
  }

  Map<String, dynamic> checkIfUpdateRole(dynamic event, dynamic userObject) {
    print("checkIfUpdateRole");
    dynamic checkIfUpdateRoleResp = {"updateRole": false, "eventRequestId": ""};
    print("event: $event");
    userObject['eventUserParticipants']['data']
        .forEach((eventUserParticipantElement) {
      if (eventUserParticipantElement['event']['_id'] == event['_id']) {
        //update role
        checkIfUpdateRoleResp['updateRole'] = true;
        checkIfUpdateRoleResp['eventUserParticipant'] =
            eventUserParticipantElement['_id'];
      }
    });
    print("checkIfUpdateRoleResp: $checkIfUpdateRoleResp");

    return checkIfUpdateRoleResp;
  }

  Future<Map<String, dynamic>> removeUserFromEvent(
      dynamic eventInput, dynamic userInput) async {
    print("removeUserFromEvent");
    print("eventInput: ${eventInput['userParticipants']}");
    Map<String, dynamic> removeUserFromEventResponse = {
      "success": false,
      "message": "Default Error",
      "data": null
    };
    try {
      //get userParticipant where user is the user
      dynamic userParticipant = eventInput['userParticipants']['data']
          .firstWhere((element) => element['user']['_id'] == userInput['_id']);
      print("userParticipant: $userParticipant");
      eventInput['eventUserParticipantId'] = userParticipant['_id'];

      http.Response response = await http.post(
        Uri.parse('https://graphql.fauna.com/graphql'),
        headers: <String, String>{
          'Authorization': 'Bearer ' + dotenv.env['FAUNADBSECRET'].toString(),
          'Content-Type': 'application/json'
        },
        body: jsonEncode(<String, String>{
          'query': EventMutations().deleteEventUserParticipant(eventInput),
        }),
      );

      print("response body: ");
      print(jsonDecode(response.body));

      // addEventToMyEvents(jsonDecode(response.body)['data']['deleteEventUserParticipant']);
      removeUserFromEventResponse["success"] = true;
      removeUserFromEventResponse["message"] = "User removed from event";
      removeUserFromEventResponse["data"] =
          jsonDecode(response.body)['data']['deleteEventUserParticipant'];

      return removeUserFromEventResponse;
    } on ApiException catch (e) {
      print('Mutation failed: $e');
      return removeUserFromEventResponse;
    }
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
      dynamic updateRoleResp =
          EventCommand().checkIfUpdateRole(eventInput, userObject);
      if (updateRoleResp['updateRole']) {
        await updateUserRolesInEvent(eventInput, userInput, roles,
            updateRoleResp['eventUserParticipant']);
      } else {
        print("will add user to event with input: " +
            eventInput.toString() +
            "\n" +
            userInput.toString() +
            "\n" +
            roles.toString());
        http.Response response = await http.post(
          Uri.parse('https://graphql.fauna.com/graphql'),
          headers: <String, String>{
            'Authorization': 'Bearer ' + dotenv.env['FAUNADBSECRET'].toString(),
            'Content-Type': 'application/json'
          },
          body: jsonEncode(<String, String>{
            'query':
                EventMutations().addUserToEvent(eventInput, userInput, roles),
          }),
        );

        print("response body: ");
        print(jsonDecode(response.body));
        addUserToEventResponse['data'] =
            jsonDecode(response.body)['data']['updateEvent'];

        await addEventToMyEvents(
            jsonDecode(response.body)['data']['updateEvent']);
      }

      return addUserToEventResponse;
    } on ApiException catch (e) {
      print('Mutation failed: $e');
      return addUserToEventResponse;
    }
  }

  Future<Map<String, dynamic>> updateUserRolesInEvent(dynamic eventInput,
      dynamic userInput, String roles, String eventRequestId) async {
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
          'query': EventMutations().updateUserRolesInEvent(
              eventInput, userInput, roles, eventRequestId),
        }),
      );

      print("response body: ");
      print(jsonDecode(response.body));

      await addEventToMyEvents(jsonDecode(response.body)['data']
          ['partialUpdateEventUserParticipant']['event']);

      return addUserToEventResponse;
    } on ApiException catch (e) {
      print('Mutation failed: $e');
      return addUserToEventResponse;
    }
  }

  Future<ApiResponse<BaseUpdateResponseModel, void>> updateSocialMedia({
    required final String type,
    required final String url,
    required final String eventId,
    required final String userId,
  }) async {
    final body = AddSocialMediaApps(
      let: [
        AddSocialMediaAppsLet(
          eventRef: RefBody(
            id: eventId,
            ref: const CollectionBody(collection: 'Event'),
          ),
        ),
        AddSocialMediaAppsLet(
          userRef: RefBody(
            id: userId,
            ref: const CollectionBody(collection: 'User'),
          ),
        ),
        AddSocialMediaAppsLet(
          socialMediaAppData: SocialMediaAppData(
            object: SocialMediaAppObjectData(
              type: type,
              url: url,
              user: const VarBody(varProperty: 'userRef'),
              event: const VarBody(varProperty: 'eventRef'),
            ),
          ),
        )
      ],
      inProperty: const InBody(
        create: CollectionBody(collection: 'SocialMediaApp'),
        params: ObjectParamsBody(
          objectObjectParamsBody: ObjectParamsBodyData(
            data: VarBody(varProperty: 'socialMediaAppData'),
          ),
        ),
      ),
    );

    return BaseApiClient().fqlRequest(
      jsonBody: body.toJson(),
    );
  }

  Future<Map<String, dynamic>> deleteSocialMedia(dynamic eventInput) async {
    print("updateSocialMediaOfEvent");
    Map<String, dynamic> deleteSocialMediaAppResponse = {
      "success": false,
      "message": "Default Error",
      "data": null
    };
    try {
      log('start');
      log(EventMutations().deleteSocialMediaApps(eventInput));
      http.Response response = await http.post(
        Uri.parse('https://graphql.fauna.com/graphql'),
        headers: <String, String>{
          'Authorization': 'Bearer ' + dotenv.env['FAUNADBSECRET'].toString(),
          'Content-Type': 'application/json'
        },
        body: jsonEncode(<String, String>{
          'query': EventMutations().deleteSocialMediaApps(eventInput),
        }),
      );

      deleteSocialMediaAppResponse['data'] =
          jsonDecode(response.body)['data']['deleteSocialMediaApp'];
      log("response body: ");

      return deleteSocialMediaAppResponse;
    } on ApiException catch (e) {
      print('Mutation failed: $e');
      return deleteSocialMediaAppResponse;
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

  String getProcessedGameInput(dynamic gameInput) {
    print("getProcessedGameInput");
    print("gameInput: " + gameInput.toString());

    String processedGameInput = """
    """;
    processedGameInput = """
      homegoals: 1,  
    """;

    return processedGameInput;
  }

  String getProcessedEventInput(dynamic eventInput) {
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
      dynamic gameEventInput) async {
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

    try {
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
      if (event['events'] != null) {
        event = getMainEvent(event['events']['data']);
      } else {
        event = event['event'];
      }

      print("event location check: " +
          event['location']['data'][0]['longitude'].toString());
      double latitude = event['location']['data'][0]['latitude'];
      double longitude = event['location']['data'][0]['longitude'];

      double distanceFromUser =
          await GeoLocationCommand().getDistanceFromPoint(latitude, longitude, appModel.currentPosition);
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
      dynamic userParticipants = mainEvent['userParticipants']['data'];

      print("userParticipants: " + userParticipants.toString());
      String organizersString = "";
      String receiver = "";
      print("get OSPIDs");
      //populate list with onesignal player ids
      List<String> OSPIDs = [];
      List<String> phones = [];
      for (var i = 0; i < userParticipants.length; i++) {
        String toUserId = userParticipants[i]['user']['_id'];
        List<String> roles =
            userParticipants[i]['roles'].toString().parseRoles();
        print("roles: " + roles.toString());
        if (roles.contains("ORGANIZER")) {
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
      sendOrganizerEventRequestInput['receivers'] = organizersString;

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
      sendOrganizerEventRequestResponse["data"] =
          jsonDecode(response.body)['data']['createRequest'];
    } catch (e) {}

    return sendOrganizerEventRequestResponse;
  }

  //send player event requests
  Future<Map<String, dynamic>> sendPlayerEventRequests(dynamic userPlayerObject,
      List<dynamic> eventsObject, List<dynamic> roles, String type) async {
    print("sendPlayerEventRequest");
    Map<String, dynamic> sendPlayerEventRequestResponse = {
      "success": false,
      "message": "Default Error",
      "data": null
    };

    try {
      print("userPlayerObject: " + userPlayerObject.toString());
      print("events: " + eventsObject.toString());
      print("roles: " + roles.toString());

      //loop through events
      for (int i = 0; i < eventsObject.length; i++) {
        print("loop through events");
        for (int j = 0; j < roles.length; j++) {
          print("loop through roles");
          print("roles[j]: " + roles[j]);
          Map<String, dynamic> sendPlayerEventRequestInput = {
            "sender_id": appModel.currentUser['_id'],
            "event_id": eventsObject[i]['_id'],
            "forRole": roles[j],
            "type": type,
            "receivers": userPlayerObject['_id']
          };

          print("sendOrganizerEventRequestInput: " +
              sendPlayerEventRequestInput.toString());

          List<String> OSPIDs = [userPlayerObject['OSPID']];
          List<String> phones = [userPlayerObject['phone']];

          http.Response response = await http.post(
            Uri.parse('https://graphql.fauna.com/graphql'),
            headers: <String, String>{
              'Authorization':
                  'Bearer ' + dotenv.env['FAUNADBSECRET'].toString(),
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
    } catch (e) {
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
      dynamic userParticipants = eventInput['userParticipants']['data'];

      print("userParticipants: " + userParticipants.toString());
      String organizersString = "";
      String receiver = "";
      print("get OSPIDs");
      //populate list with onesignal player ids
      List<String> OSPIDs = [];
      List<String> phones = [];
      for (var i = 0; i < userParticipants.length; i++) {
        String toUserId = userParticipants[i]['user']['_id'];
        List<String> roles =
            userParticipants[i]['roles'].toString().parseRoles();
        print("roles: " + roles.toString());
        if (roles.contains("ORGANIZER")) {
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
      sendOrganizerEventRequestInput['receivers'] = organizersString;

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
      sendOrganizerEventRequestResponse["data"] =
          jsonDecode(response.body)['data']['createRequest'];
    } catch (e) {}

    return sendOrganizerEventRequestResponse;
  }

  Future<Map<String, dynamic>> getSelectedEvent(
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
        'query': EventQueries().getEvent(eventRequest['_id']),
      }),
    );
    print("response: " + response.body);
    dynamic event = jsonDecode(response.body)['data']['findEventByID'];

    eventPageModel.mainEvent = event;

    getEventResponse["success"] = true;
    getEventResponse["message"] = "Event Found";
    getEventResponse["data"] = event;

    return getEventResponse;
  }

  Future<Map<String, dynamic>> removeEventFromMyEvents(
      Map<String, dynamic> eventRequestInput) async {
    print("removeEventFromMyEvents");
    Map<String, dynamic> removeEventFromMyEventsResponse = {
      "success": false,
      "message": "Default Error",
      "data": null
    };
    print("before getEvent");
    print("eventRequestInput: " + eventRequestInput.toString());

    print("before appModel.myEvents: " + appModel.myEvents.toString());
    //remove where _id == eventRequestInput['_id']
    appModel.myEvents
        .removeWhere((event) => event['_id'] == eventRequestInput['_id']);

    print("after appModel.myEvents: " + appModel.myEvents.toString());
    removeEventFromMyEventsResponse["success"] = true;

    return removeEventFromMyEventsResponse;
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
    dynamic getEventGameResp = await getSelectedEvent(eventRequestInput);
    print("getGameEventResp: " + getEventGameResp.toString());
    if (getEventGameResp['success']) {
      dynamic eventGame = getEventGameResp['data'];
      print("event: " + getEventGameResp.toString());
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
        'query': EventMutations()
            .addPlayerToEventDoesntWork(eventInput, playerInput),
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

  Future<Map<String, dynamic>> getAllUserEventParticipants(
      dynamic allUserEventParticipantsInput) async {
    Map<String, dynamic> getUserEventParticipantsResponse = {
      "success": false,
      "message": "Default Error",
      "data": null
    };
    print("getUserEventParticipants()");
    print("allUserEventParticipantsInput: " +
        allUserEventParticipantsInput.toString());
    try {
      http.Response response = await http.post(
        Uri.parse('https://graphql.fauna.com/graphql'),
        headers: <String, String>{
          'Authorization': 'Bearer ' + dotenv.env['FAUNADBSECRET'].toString(),
          'Content-Type': 'application/json'
        },
        body: jsonEncode(<String, String>{
          'query': EventQueries()
              .allUserEventParticipants(allUserEventParticipantsInput),
        }),
      );

      print("getUserEventParticipants response body: " +
          jsonDecode(response.body).toString());
      if (response.statusCode == 200) {
        dynamic allEvents = jsonDecode(response.body)['data']
            ['allCurrentUserEventParticipants'];
        print("allEventsOfType length: " + allEvents.length.toString());
        getUserEventParticipantsResponse["success"] = true;
        getUserEventParticipantsResponse["message"] = "events Retrieved";
        getUserEventParticipantsResponse["data"] = allEvents;
      }

      return getUserEventParticipantsResponse;
    } catch (e) {
      print("getUserEventParticipants error: " + e.toString());
      return getUserEventParticipantsResponse;
    }
  }

  Future<Map<String, dynamic>> getEventsOfTypeNearLocation(EventType eventType,
      String eventFragment, String startDateTimestamp) async {
    print("getEventsOfTypeNearLocation()");
    print("eventType: " + eventType.toString());
    print("startDateTimestamp: " + startDateTimestamp.toString());
    Map<String, dynamic> getGamesNearLocationResp = {
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
          'query': EventQueries()
              .allEventsOfType(startDateTimestamp, eventType, eventFragment),
        }),
      );

      print("getEventsOfTypeNearLocation response body: ");
      print(jsonDecode(response.body));

      if (response.statusCode == 200) {
        dynamic allEvents =
            jsonDecode(response.body)['data']['allEventsOfType'];
        print("allEventsOfType length: " + allEvents.length.toString());
        getGamesNearLocationResp["success"] = true;
        getGamesNearLocationResp["message"] = "events Retrieved";
        getGamesNearLocationResp["data"] = allEvents;
        return getGamesNearLocationResp;
      }
    } on Exception catch (e) {
      print('Mutation failed: $e');
    }

    return getGamesNearLocationResp;
  }

  Future<Map<String, dynamic>> getEventsOfAllTypesNearLocation(
      String eventFragment, String startDateTimestamp) async {
    print("getEventsOfAllTypesNearLocation()");
    Map<String, dynamic> getGamesNearLocationResp = {
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
          'query': EventQueries()
              .allEventsOfAllTypes(startDateTimestamp, eventFragment),
        }),
      );

      print("getEventsNearLocation response body: ");
      print(jsonDecode(response.body));

      if (response.statusCode == 200) {
        dynamic allEvents =
            jsonDecode(response.body)['data']['allEventsOfAllTypes'];
        print("allEvents length: " + allEvents.length.toString());
        getGamesNearLocationResp["success"] = true;
        getGamesNearLocationResp["message"] = "events Retrieved";
        getGamesNearLocationResp["data"] = allEvents;
      }
    } on Exception catch (e) {
      print('Mutation failed: $e');
    }

    return getGamesNearLocationResp;
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

  dynamic getMainEvent(List<dynamic> events) {
    print("getMainEvent()");
    dynamic event = null;
    for (int i = 0; i < events.length; i++) {
      print("events[i]]: " + events[i].toString());
      if (events[i]['isMainEvent'] &&
          (events[i]['type'] == "TOURNAMENT" ||
              events[i]['type'] == "LEAGUE")) {
        print("found mainEvent: " + events[i].toString());
        event = events[i];
      }
    }
    print("finish getMainEvent");
    return event;
  }

  Future<Map<String, dynamic>> removeTeamFromEvent(
      dynamic removeTeamFromEventInput) async {
    print("removeTeamFromEvent()");
    Map<String, dynamic> removeTeamFromEventResponse = {
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
          'query':
              EventMutations().removeTeamFromEvent(removeTeamFromEventInput),
        }),
      );

      print("response body: ");
      print(jsonDecode(response.body));

      if (jsonDecode(response.body)['data'] != null) {
        dynamic removeTeamFromEvent =
            jsonDecode(response.body)['data']['updateEvent'];
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

  void updateEventChat(dynamic chat) {
    eventPageModel.chats = chat;
  }

 

   List<dynamic> getEventRoles(dynamic user, List<dynamic> userParticipants) {
    List<dynamic> tempRoles = [];

    for (int i = 0; i < eventPageModel.userParticipants.length; i++) {
      if (eventPageModel.userParticipants[i]['user']['_id'] == user['_id']) {
        tempRoles = userParticipants[i]['roles'].toString().parseRoles();
      }
    }

    return tempRoles;
  }




    

  
  Future<Map<String, dynamic>> getUserEventDetails(List<dynamic> events, bool addToEventPageModel) async {
    print("getUserEventDetails()");
    print("events: " + events.toString());
    dynamic isMyEventResp = {
      "success": true,
      "isMine": false,
      "isMember": false,
      "amountPaid": "0.00",
      "amountRemaining": "0.00",
      "teamAmountPaid": "0.00",
      "teamAmountRemaining": "0.00",
      "price": {},
      "mainEvent": null,
      "players": [],
      "organizers": [],
      "teams": [],
      "roles": [],
      "chats": [],
      "groupStage": [],
      "tournamentStage": [],
      "userParticipants": [],      
      "fieldLocations": [],
    };
    print("events length: " + events.length.toString());

    try {
      //get event
      dynamic event = events[0];

      print("getEventGame(): " + event.toString());
      

      print("event type: " + event['type'].toString());
      if (event['type'] == "TOURNAMENT") {
        print("type is tournament");
        dynamic findTournamentByIdResp = await TournamentCommand()
            .findTournamentById(event['tournaments']['data'][0]['_id']);
        if (findTournamentByIdResp['success']) {
          dynamic tournament = findTournamentByIdResp['data'];
          isMyEventResp['groupStage'] = tournament['groupStage'];
          isMyEventResp['tournamentStage'] = tournament['tournamentStage'];
          // eventPageModel.groupStage = tournament['groupStage'];
          // eventPageModel.tournamentStage = tournament['tournamentStage'];
        }
      }
      if (event['type'] == "LEAGUE") {
        print("type is league");
        dynamic findLeagueByIdResp = await LeagueCommand()
            .findLeagueById(event['leagues']['data'][0]['_id']);
        if (findLeagueByIdResp['success']) {
          dynamic league = findLeagueByIdResp['data'];
          isMyEventResp['league'] = league;
          // eventPageModel.league = league;
        }
      }
      

      isMyEventResp['mainEvent'] = event;
      isMyEventResp['allEvents'] = events;

      
      // eventPageModel.mainEvent = event;   
      // eventPageModel.allEvents = events;
      // print("eventPageModel.mainEvent['joinConditions']: " + eventPageModel.mainEvent['joinConditions'].toString());
      //join conditions
      isMyEventResp['mainEvent']['joinConditions']['data'].forEach((joinCondition) {
        if(joinCondition['forEvent'] != null){
          isMyEventResp['eventRequestJoin'] = new JoinCondition(label: "With Request", withRequest: joinCondition['withRequest']); 
          isMyEventResp['eventPaymentJoin'] = new JoinCondition(label: "With Payment", withRequest: joinCondition['withPayment']);                     
        }
        else{
          isMyEventResp['teamRequestJoin'] = new JoinCondition(label: "With Request", withRequest: joinCondition['withRequest']); 
          isMyEventResp['teamPaymentJoin'] = new JoinCondition(label: "With Payment", withRequest: joinCondition['withPayment']); 
        } 
      });

      // eventPageModel.objectImageInput = await loadEventMainImage(event, eventPageModel.isMine);
      isMyEventResp['userParticipants'] = isMyEventResp['mainEvent']['userParticipants']['data'];
      isMyEventResp['roles'] = getEventRoles(appModel.currentUser, isMyEventResp['userParticipants']);
      isMyEventResp['isMine'] = isMyEventResp['roles'].contains("ORGANIZER");
      isMyEventResp['isMember'] = isMyEventResp['roles'].contains("PLAYER");
      isMyEventResp['chats'] = isMyEventResp['mainEvent']['chats']['data'];
      isMyEventResp['teams'] = isMyEventResp['mainEvent']['teams']['data'];
      isMyEventResp['startTime'] = isMyEventResp['mainEvent']['startTime'];
      isMyEventResp['endTime'] = isMyEventResp['mainEvent']['endTime'];      
      isMyEventResp['formattedEventTime'] = BaseCommand().formatEventTime(isMyEventResp['startTime'], isMyEventResp['endTime']);
    
      isMyEventResp['fieldLocations'] = isMyEventResp['mainEvent']['fieldLocations']['data'];
      for (int i = 0; i < isMyEventResp['userParticipants'].length; i++) {
        dynamic participant = isMyEventResp['userParticipants'][i];
        List<String> roles = participant['roles'].toString().parseRoles();
        if (roles.contains("ORGANIZER")) {
          isMyEventResp['organizers'].add(participant);
        }
        if (roles.contains("PLAYER")) {
          isMyEventResp['players'].add(participant);
        }
      }

      isMyEventResp['price'] = isMyEventResp['mainEvent']['price'];
  
      isMyEventResp['payments'] = isMyEventResp['mainEvent']['payments']['data'];
             

      double tempAmountPaid = 0.00;
      double tempTeamAmountPaid = 0.00;

      for (int i = 0; i < isMyEventResp['payments'].length; i++) {
        if (isMyEventResp['payments'][i]['user']['_id'] == appModel.currentUser['_id']) {
          if (isMyEventResp['payments'][i]['isPlayerPayment']) {
            tempAmountPaid += double.parse(isMyEventResp['payments'][i]['amount']);
          } else if (isMyEventResp['payments'][i]['isTeamPayment']) {
            tempTeamAmountPaid += double.parse(isMyEventResp['payments'][i]['amount']);
          }
        }
      }
      isMyEventResp['amountPaid'] = (tempAmountPaid).toStringAsFixed(2);
      isMyEventResp['teamAmountPaid'] = (tempTeamAmountPaid).toStringAsFixed(2);
      isMyEventResp['amountRemaining'] =
          (double.parse(isMyEventResp['mainEvent']['price']['amount']) - tempAmountPaid)
              .toStringAsFixed(2);
      isMyEventResp['teamAmountRemaining'] =
          (double.parse(isMyEventResp['mainEvent']['price']['teamAmount']) - tempTeamAmountPaid)
              .toStringAsFixed(2);



      if(addToEventPageModel){
        eventPageModel.mainEvent = isMyEventResp['mainEvent'];
        eventPageModel.objectImageInput = await loadEventMainImage(event, eventPageModel.isMine);
        eventPageModel.roles = isMyEventResp['roles'];
        eventPageModel.isMine = isMyEventResp['isMine'];
        eventPageModel.isMember = isMyEventResp['isMember'];
        eventPageModel.amountRemaining = isMyEventResp['amountRemaining'];
        eventPageModel.amountPaid = isMyEventResp['amountPaid'];
        eventPageModel.teamAmountRemaining = isMyEventResp['teamAmountRemaining'];
        eventPageModel.teamAmountPaid = isMyEventResp['teamAmountPaid'];
        eventPageModel.userParticipants = isMyEventResp['userParticipants'];
        eventPageModel.teams = isMyEventResp['teams'];
        eventPageModel.players = isMyEventResp['players'];
        eventPageModel.chats = isMyEventResp['chats'];
        eventPageModel.payments = isMyEventResp['payments'];
        eventPageModel.fieldLocations = isMyEventResp['fieldLocations'];
        eventPageModel.price = isMyEventResp['price'];
        eventPageModel.eventRequestJoin = isMyEventResp['eventRequestJoin'];
        eventPageModel.eventPaymentJoin = isMyEventResp['eventPaymentJoin'];
        eventPageModel.teamRequestJoin = isMyEventResp['teamRequestJoin'];
        eventPageModel.teamPaymentJoin = isMyEventResp['teamPaymentJoin'];
      }


      print("successfully ran details function");
      isMyEventResp["success"] = true;
    } on Exception catch (e) {
      print('Mutation failed: $e');
      return isMyEventResp;
    }

    return isMyEventResp;
  }


  Future<dynamic> loadEventMainImage(dynamic event, bool isMine,  ) async {
    print("loadEventMainImage() "+event.toString());
    String? imageKey = event['mainImageKey'];
    String imageUrl = "";
    dynamic objectImageInput = {
      "imageUrl": "",
      "containerType": Constants.IMAGEBANNER,
      "mainEvent": event,
      "isMine": isMine
    };

    if (imageKey != null) {
      dynamic imageInput = {"key": imageKey};
      print("imageKey: $imageKey");
      Map<String, dynamic> getImageUrlResp =
          await ImagesCommand().getImageUrl(imageInput);
      print("getImageUrlRespppp: $getImageUrlResp");
      if (getImageUrlResp['success']) {
        imageUrl = getImageUrlResp['data'];
        event['mainImageUrl'] = imageUrl;

        objectImageInput = {
          "imageUrl": imageUrl,
          "containerType": Constants.IMAGEBANNER,
          "mainEvent": event,
          "isMine": isMine,
        };
      }
    }
    return objectImageInput;
  }

  Future<Map<String, dynamic>> createPrice(
      dynamic paymentInput, dynamic eventInput) async {
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
          'query': EventMutations().createPrice(paymentInput, eventInput),
        }),
      );
      print("response body: ");
      print(jsonDecode(response.body));
      Map<String, dynamic> createdPayment =
          jsonDecode(response.body)['data']['createPrice'];
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

  Future<Map<String, dynamic>> setupEvents(
      dynamic type, String afterTimestamp) async {
    print("setupEvents()()");

    Map<String, dynamic> setupEventsResp = {
      "success": false,
      "message": "Default Error",
      "data": []
    };

    if (type == Constants.MYEVENTS) {
      //first part is to get all events
      print("testing getEventsNearLocation");
      //get userEventParticipants
      if (!appModel.isGuest) {
        print("is not guest");
        //get eventUserParticipants
        dynamic allUserEventParticipantsInput = {
          "userId": appModel.currentUser['_id'],
          "startTime": afterTimestamp,
          "eventFragment": EventFragments().userEventParticipants()
        };
        Map<String, dynamic> getAllUserEventParticipantsResp =
            await getAllUserEventParticipants(allUserEventParticipantsInput);
        print("getAllUserEventParticipantss: " +
            getAllUserEventParticipantsResp.toString());
        if (getAllUserEventParticipantsResp['success']) {
          print("successss!!!!");
          List<dynamic> allMyEvents = getAllUserEventParticipantsResp['data'];
          print("allMyEvents: " + allMyEvents.toString());
          List myEvents = allMyEvents;
          print("myEvents.length before: " + myEvents.length.toString());
          //filter out archived events
          myEvents.removeWhere((event) => BaseCommand()
              .dateTimeFromMilliseconds(event['event']['endTime'].toString())
              .isBefore(DateTime.now()));
          //sort by createdAt
          myEvents.sort((a, b) {
            int aCreatedAt = int.tryParse(a["event"]["createdAt"]) ?? 0;
            int bCreatedAt = int.tryParse(b["event"]["createdAt"]) ?? 0;
            print("aCreatedAt: " + aCreatedAt.toString());
            print("bCreatedAt: " + bCreatedAt.toString());
            return bCreatedAt.compareTo(aCreatedAt);
          });
          appModel.myEvents = myEvents;
          for (var event in myEvents) {
            var createdAt = event["event"]["createdAt"];
            print("createdAtt: $createdAt");
          }
          print("myEvents after sort: " + myEvents.length.toString());
        }
      }
    }
    //get other type of events
    else {
      Map<String, dynamic> getEventsOfAllTypesNearLocationResp =
          await EventCommand().getEventsOfTypeNearLocation(
              EventType.GAME, EventFragments().fullEvent(), afterTimestamp);

      print("getEventsNearLocationResp: " +
          getEventsOfAllTypesNearLocationResp.toString());

      //events retrieved successfully
      List<dynamic> events = getEventsOfAllTypesNearLocationResp['data'];
      events.sort((a, b) {
        int aCreatedAt = int.tryParse(a["createdAt"]) ?? 0;
        int bCreatedAt = int.tryParse(b["createdAt"]) ?? 0;
        print("aCreatedAt: " + aCreatedAt.toString());
        print("bCreatedAt: " + bCreatedAt.toString());
        return bCreatedAt.compareTo(aCreatedAt);
      });
      print("events: " + events.toString());
      eventsModel.games = events;
      // print("length of events: " + events.length.toString());
      //iterate through events
      // for (int i = 0; i < events.length; i++) {
      //   dynamic type = events[i]['type'];
      //   bool isMainEvent = events[i]['isMainEvent'];
      //   if (isMainEvent) {
      //     addEventToEventModels(events[i]);
      //   }
      // }
      print("games in eventsModel: " + eventsModel.games.toString());
    }

    Map<String, dynamic> getPlayersNearLocationResp =
        await PlayerCommand().getPlayersNearLocation();
    print(
        "getPlayersNearLocationResp: " + getPlayersNearLocationResp.toString());
    if (getPlayersNearLocationResp['success']) {
      List<dynamic> players = getPlayersNearLocationResp['data'];
      print("playerssss length: ");
      print(players.length);
      //remove the current user from the list
      players.removeWhere(
          (element) => element['_id'] == appModel.currentUser['_id']);
      appModel.players = players;
      appModel.playersNearMe = players;
    }

    return setupEventsResp;
  }

  Future<Map<String, dynamic>> updateViewModelsWithEvent(
      Map<String, dynamic> event, bool add) async {
    print("updateViewModelsWithEvent()");
    print("event: " + event.toString());

    Map<String, dynamic> updateViewModelsWithGameResp = {
      "success": false,
      "message": "Default Error",
      "data": []
    };

    if (event['type'] == "GAME") {
      if (add) {
        appModel.myEvents.insert(0, {"event": event});
        eventsModel.games.insert(0, event);
      } else {
        int indexToRemove = -1;
        for (int i = 0; i < eventsModel.games.length; i++) {
          if (eventsModel.games[i]['_id'] == event['_id']) {
            indexToRemove = i;
            break;
          }
        }

        if (indexToRemove != -1) {
          eventsModel.games.removeAt(indexToRemove);
        }
      }
    } else if (event['type'] == "TRAINING") {
      if (add) {
        appModel.myEvents.insert(0, {"event": event});
        eventsModel.trainings.insert(0, event);
      } else {
        int indexToRemove = -1;
        for (int i = 0; i < eventsModel.trainings.length; i++) {
          if (eventsModel.trainings[i]['_id'] == event['_id']) {
            indexToRemove = i;
            break;
          }
        }
        if (indexToRemove != -1) {
          eventsModel.trainings.removeAt(indexToRemove);
        }
      }
    } else if (event['type'] == "TRYOUT") {
      if (add) {
        appModel.myEvents.insert(0, {"event": event});
        eventsModel.tryouts.insert(0, event);
      } else {
        int indexToRemove = -1;
        for (int i = 0; i < eventsModel.tryouts.length; i++) {
          if (eventsModel.tryouts[i]['_id'] == event['_id']) {
            indexToRemove = i;
            break;
          }
        }
        if (indexToRemove != -1) {
          eventsModel.tryouts.removeAt(indexToRemove);
        }
      }
    } else if (event['type'] == "TOURNAMENT") {
      print("event type tournament");
      print("eventModel.tournaments.length: " +
          eventsModel.tournaments.length.toString());
      if (add) {
        appModel.myEvents.insert(0, {"event": event});
        eventsModel.tournaments.insert(0, event);
      } else {
        int indexToRemove = -1;
        for (int i = 0; i < eventsModel.tournaments.length; i++) {
          if (eventsModel.tournaments[i]['_id'] == event['_id']) {
            indexToRemove = i;
            break;
          }
        }
        if (indexToRemove != -1) {
          eventsModel.tournaments.removeAt(indexToRemove);
        }
      }
    } else if (event['type'] == "LEAGUE") {
      print("event type league");
      print("eventModel.leagues.length: " +
          eventsModel.leagues.length.toString());
      if (add) {
        appModel.myEvents.insert(0, {"event": event});
        eventsModel.leagues.insert(0, event);
      } else {
        int indexToRemove = -1;
        for (int i = 0; i < eventsModel.leagues.length; i++) {
          if (eventsModel.leagues[i]['_id'] == event['_id']) {
            indexToRemove = i;
            break;
          }
        }
        if (indexToRemove != -1) {
          eventsModel.leagues.removeAt(indexToRemove);
        }
      }
    }

    //remove from myEvents
    if (!add) {
      List<dynamic> myEvents = appModel.myEvents;
      int indexToRemove = -1;
      for (int i = 0; i < myEvents.length; i++) {
        if (myEvents[i]['event']['_id'] == event['_id']) {
          indexToRemove = i;
          break;
        }
      }
      if (indexToRemove != -1) {
        myEvents.removeAt(indexToRemove);
      }
    }

    HomePageCommand().updateUpdatedCards(true);

    return updateViewModelsWithGameResp;
  }

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
    if (add) {
      appModel.myEvents.add(game['event']['userParticipants']['data'][0]);
      eventsModel.games.add(game['event']);
    } else {
      int indexToRemove = -1;
      for (int i = 0; i < eventsModel.games.length; i++) {
        if (eventsModel.games[i]['_id'] == game['_id']) {
          indexToRemove = i;
          break;
        }
      }
      if (indexToRemove != -1) {
        eventsModel.games.removeAt(indexToRemove);
      }
    }
    HomePageCommand().updateUpdatedCards(true);

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
    if (add) {
      await EventCommand().addTournament(tournament);
    } else {
      // await EventCommand().removeTournament(tournament);
    }
    UserCommand().findMyUserById();
    if (homePageModel.selectedKey.toString() ==
        Constants.TOURNAMENT.toString()) {
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
    if (add) {
      await EventCommand().addLeague(league);
    } else {
      // await EventCommand().removeLeague(league);
    }

    UserCommand().findMyUserById();
    if (homePageModel.selectedKey.toString() == Constants.LEAGUE.toString()) {
      homePageModel.selectedObjects = List.from(eventsModel.leagues);
    }

    return updateViewModelsWithLeagueResp;
  }

  Future<Map<String, dynamic>> updateViewModelsWithTraining(
      Map<String, dynamic> event, bool add) async {
    print("updateViewModelsWithTraining()");
    Map<String, dynamic> updateViewModelsWithTrainingResp = {
      "success": false,
      "message": "Default Error",
      "data": []
    };
    print("length of events modeL trainings: ");
    print(eventsModel.trainings.length);
    print("length of homePageModel selectedObjects: ");
    if (add) {
      appModel.myEvents.add(event['userParticipants']['data'][0]);
      eventsModel.trainings.add(event);
    } else {
      int indexToRemove = -1;
      for (int i = 0; i < eventsModel.trainings.length; i++) {
        if (eventsModel.trainings[i]['_id'] == event['_id']) {
          indexToRemove = i;
          break;
        }
      }
      if (indexToRemove != -1) {
        eventsModel.trainings.removeAt(indexToRemove);
      }
    }

    HomePageCommand().updateUpdatedCards(true);

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
    if (homePageModel.selectedKey.toString() == Constants.TRYOUT.toString()) {
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
    eventsModel.games.insert(0, game);
    print("length of games after adding game: ");
    print(eventsModel.games.length);
    print("updateViewModelsBool: ");
    print(updateViewModelsBool);

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
    eventsModel.tournaments.insert(0, tournament);
    print("length of trainings after adding tournaments: ");
    print(eventsModel.tournaments.length);

    return addtournamentResp;
  }

  Future<Map<String, dynamic>> addLeague(Map<String, dynamic> league) async {
    Map<String, dynamic> addLeagueResp = {
      "success": false,
      "message": "Default Error",
      "data": []
    };
    print("length of tournaments before adding game: ");
    print("adding league: " + league.toString());
    print(eventsModel.leagues.length);
    eventsModel.leagues.insert(0, league);
    print("length of trainings after adding leagues: ");
    print(eventsModel.leagues.length);

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
    eventsModel.trainings.insert(0, training);
    print("length of trainings after adding training: ");
    print(eventsModel.trainings.length);
    print("updateViewModelsBool: ");
    print(updateViewModelsBool);

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

  Future<Map<String, dynamic>> removeUsersRolesFromEvent(
      dynamic event, List<dynamic> users, List<dynamic> roles) async {
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

  Future<Map<String, dynamic>> addUsersRolesInEvent(
      dynamic event, List<dynamic> users, List<dynamic> roles) async {
    print("addUsersRolesInEvent");
    print("event: $event");
    print("users: $users");
    print("roles: $roles");

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

  Future<Map<String, dynamic>> updateEventUserParticipant(
      dynamic eventUserParticipant, String newRoles) async {
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
        'query': EventMutations()
            .updateEventUserParticipant(updateEventUserParticipantInput),
      }),
    );

    print("response body: ");
    print(jsonDecode(response.body));

    updateEventUserParticipantResponse["success"] = true;
    updateEventUserParticipantResponse["message"] =
        "Event User Participant Updated";
    updateEventUserParticipantResponse["data"] =
        jsonDecode(response.body)['data']['updateEventUserParticipant'];

    return updateEventUserParticipantResponse;
  }

  Future<Map<String, dynamic>> updateEventUserParticipantRsv(
      dynamic eventUserParticipantRsv) async {
    print("updateEventUserParticipant");

    Map<String, dynamic> updateEventUserParticipantResponse = {
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
        'query': EventMutations()
            .updateEventUserParticipantRsv(eventUserParticipantRsv),
      }),
    );

    print("response body: ");
    print(jsonDecode(response.body));

    updateEventUserParticipantResponse["success"] = true;
    updateEventUserParticipantResponse["message"] =
        "Event User Participant Updated";
    updateEventUserParticipantResponse["data"] =
        jsonDecode(response.body)['data']['updateEventUserParticipant']['event']
            ['userParticipants']['data'];

    return updateEventUserParticipantResponse;
  }
}
