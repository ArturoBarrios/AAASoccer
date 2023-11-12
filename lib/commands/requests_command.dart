import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/cupertino.dart';
import 'package:soccermadeeasy/commands/team_command.dart';
import 'package:soccermadeeasy/styles/colors.dart';

import '../components/Cards/event_request_card.dart';
import '../components/Cards/friend_request_card.dart';
import '../components/Cards/team_request_card.dart';
import '../components/Cards/tsn_event_request_card.dart';
import '../constants.dart';
import 'base_command.dart';
import '../commands/event_command.dart';
import '../commands/user_command.dart';
import '../graphql/mutations/games.dart';
import '../graphql/mutations/users.dart';
import '../graphql/mutations/teams.dart';
import '../graphql/queries/requests.dart';
import '../graphql/mutations/requests.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../../commands/tournament_command.dart';
import '../commands/notifications_command.dart';
import '../models/enums/RequestStatus.dart';

class RequestsCommand extends BaseCommand {
  

   Future<Widget> getRequestCard(
      String selectedKey, dynamic requestObject) async {
    print("getRequestCard()");
    print("selectedKey: " + selectedKey);
    print("requestObject: " + requestObject.toString());
    print("requestObject['type'].toString(): " +
        requestObject['type'].toString());
    dynamic user = UserCommand().getAppModelUser();
    bool didSendRequest = user['_id'] == requestObject['sender']['_id'];
    if (requestObject['type'].toString() ==
        Constants.FRIENDREQUEST.toString()) {
      Widget card = FriendRequestCard(
        friendRequestObject: requestObject,
        didSendRequest: didSendRequest,
      );
      return card;
    } else if (requestObject['type'].toString() ==
            Constants.GAMEREQUEST.toString() ||
        requestObject['type'].toString() ==
            Constants.TOURNAMENTREQUEST.toString() ||
        requestObject['type'].toString() ==
            Constants.LEAGUEREQUEST.toString() ||
        requestObject['type'].toString() ==
            Constants.TRAININGREQUEST.toString() ||
        requestObject['type'].toString() ==
            Constants.TRYOUTREQUEST.toString()) {
       Widget card = TSNEventRequestCard(
          eventRequestCardDetails: requestObject,                    
          backgroundColor: AppColors.tsnAlmostBlack,
      );
      // Widget card = EventRequestCard(
      //     eventRequestObject: requestObject,
      //     type: requestObject['type'],
      //     didSendRequest: didSendRequest);
      return card;
    } else {
      print("elseeeeee");
      print("team: " + requestObject['team'].toString());
      dynamic findTeamByIdResponse = await TeamCommand()
          .findTeamById({"_id": requestObject['team']['_id']});
      dynamic team = findTeamByIdResponse['data'];
      print("team: " + team.toString());
      dynamic teamDetails = await TeamCommand().getUserTeamDetails(team, false);
      print("teamDetails: " + teamDetails.toString());
      Widget card = TeamRequestCard(
        teamRequestObject: requestObject,
        didSendRequest: didSendRequest,
        userTeamDetails: teamDetails,
      );
      return card;
    }
  }
  

  //gets most up to date user model and assigns
  //requests appropriately
  Future<void> updatedSelectedRequests(String requestType) async {
    print("updatedSelectedRequests");
    print("requestType: " + requestType);
    Map<String, dynamic> getRequestsResp =
        await UserCommand().getCurrentUserByEmail();
    print("getRequestsResp: " + getRequestsResp.toString());

    if (getRequestsResp['success']) {      
      List requestsSent = getRequestsResp['data']['requestsSent']['data'];
      List requestsReceived =
          getRequestsResp['data']['requestsReceived']['data'];
      print("requestsSent: " + requestsSent.toString());
      print("requestsReceived: " + requestsReceived.toString());
      requestsModel.requestsSent = requestsSent;
      requestsModel.requestsReceived = requestsReceived;
      if (requestType == "SENT") {
        print("sent");
        requestsPageModel.selectedObjects = requestsSent;
      } else {
        requestsPageModel.selectedObjects = requestsReceived;
        ;
      }
    }
  }

  Future<Map<String, dynamic>> getEventRequests() async {
    print("getEventRequests");
    Map<String, dynamic> getRequestsResp = {
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
          'query': RequestsQueries().getEventRequests(),
        }),
      );

      print("response body: ");
      print(jsonDecode(response.body));

      final result =
          jsonDecode(response.body)['data']['allEventRequests']['data'];
      print("result: ");
      print(result);
      getRequestsResp["success"] = true;
      getRequestsResp["message"] = "Event Requests Retrieved";
      getRequestsResp["data"] = result;
    } on Exception catch (e) {
      print('Mutation failed: $e');
    }

    return getRequestsResp;
  }

  Future<Map<String, dynamic>> getTeamRequests() async {
    print("getTeamRequests");
    Map<String, dynamic> getTeamRequestsResp = {
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
          'query': RequestsQueries().getTeamRequests(),
        }),
      );

      print("response body: ");
      print(jsonDecode(response.body));

      final result =
          jsonDecode(response.body)['data']['allTeamRequests']['data'];
      print("result: ");
      print(result);
      getTeamRequestsResp["success"] = true;
      getTeamRequestsResp["message"] = "Event Requests Retrieved";
      getTeamRequestsResp["data"] = result;
    } on Exception catch (e) {
      print('Mutation failed: $e');
    }

    return getTeamRequestsResp;
  }


  //eventRequestInput is basically Game, Tournament, League, Training, with attached event
  Future<Map<String, dynamic>> updateEventRequests(
      Map<String, dynamic> eventRequestInput) async {
    print("updateEventRequest");
    Map<String, dynamic> updateEventRequestResponse = {
      "success": false,
      "message": "Default Error",
      "data": null
    };
    try {
      print("user id before updateEventRequests: ");
      print(appModel.currentUser['_id']);
      eventRequestInput['acceptedBy_id'] = appModel.currentUser['_id'];
      // ????
      // eventRequestInput['status'] = RequestStatus.ACCEPTED;
      print("eventRequestInput: " + eventRequestInput.toString());
      //check if from and to are the same
      http.Response response = await http.post(
        Uri.parse('https://graphql.fauna.com/graphql'),
        headers: <String, String>{
          'Authorization': 'Bearer ' + dotenv.env['FAUNADBSECRET'].toString(),
          'Content-Type': 'application/json'
        },
        body: jsonEncode(<String, String>{
          'query': RequestMutations().updateRequest(
              eventRequestInput), //(fromInput, toInputs, gameInput),
        }),
      );

      print("response body: ");
      print(jsonDecode(response.body));
      dynamic updateEventRequest =
          jsonDecode(response.body)['data']['updateRequest'];
      Map<String, dynamic> userInput = {
        "_id": appModel.currentUser['_id'],
      };
      print("a");
      Map<String, dynamic> eventInput = {
        "_id": eventRequestInput['event']['_id'],
      };

      

      print("updateEventRequest: " + updateEventRequest.toString());
      print("updateEventRequest['status']: " +
          updateEventRequest['status'].toString());
      print("RequestStatus.ACCEPTED:" + RequestStatus.ACCEPTED.toString());
      print(
          "updateEventRequest['status'].toString() == RequestStatus.ACCEPTED.toString(): " +
              (updateEventRequest['status'].toString() ==
                      RequestStatus.ACCEPTED.toString())
                  .toString());
      // add to my events if it's your event
      if (updateEventRequest['status'].toString() == "ACCEPTED") {
        print("before UserCommand().addEvent()");
        String role = "{" + updateEventRequest['forRole'] + "}";
        //todo check if user or team is already in event
        if(eventRequestInput['team'] == null){
          Map<String, dynamic> addEventResp =
              await EventCommand().addUserToEvent(eventInput, userInput, role);
          print("addEventResp: " + addEventResp.toString());
          print("before EventCommand().addEvent()");
        }
        else{
          dynamic teamInput = {
            "_id": eventRequestInput['team']['_id'],
          };
          Map<String, dynamic> addEventResp =
              await EventCommand().addTeamToEvent(eventInput, teamInput);
          print("addEventResp: " + addEventResp.toString());
          print("before EventCommand().addEvent()");


        }
        
      }

      // updateEventRequestModels();
      // updateTeamModels();
      // updateEventModels();


      print("prepare notification data");
      Map<String, dynamic> sender = eventRequestInput['sender'];
      print("sender: " + sender.toString());
      List<String> phones = [sender['phone']];
      List<String> OSPIDs = [sender['OSPID']];
      Map<String, dynamic> sendOrganizerRequestNotificationInput = {
        "phones": phones,
        "message": appModel.currentUser['username'] +
            " has accepted your request "+ 
            (eventRequestInput['team']==null ? "" : "for team"+eventRequestInput['team']['name']) +" to join event",
        "OSPIDs": OSPIDs
      };
      await NotificationsCommand().sendAcceptedRequestNotification(
          sendOrganizerRequestNotificationInput);

      //todo
      //add check and revert entirely if adding event fails???
      updateEventRequestResponse["success"] = true;
      updateEventRequestResponse["message"] = "Event Request Created";
      updateEventRequestResponse["data"] =
          jsonDecode(response.body)['data']['updateRequest'];
    } catch (e) {}

    return updateEventRequestResponse;
  }

  Future<Map<String, dynamic>> updateTeamRequests(
      Map<String, dynamic> teamRequestInput) async {
    print("updateTeamRequests");
    print("teamRequestInput: " + teamRequestInput.toString());
    Map<String, dynamic> updateTeamRequestsResponse = {
      "success": false,
      "message": "Default Error",
      "data": null
    };
    try {
      print("user id before updateTeamRequests: ");
      print(appModel.currentUser['_id']);
      teamRequestInput['acceptedBy_id'] = appModel.currentUser['_id'];
      // ????
      // eventRequestInput['status'] = RequestStatus.ACCEPTED;
      //check if from and to are the same
      http.Response response = await http.post(
        Uri.parse('https://graphql.fauna.com/graphql'),
        headers: <String, String>{
          'Authorization': 'Bearer ' + dotenv.env['FAUNADBSECRET'].toString(),
          'Content-Type': 'application/json'
        },
        body: jsonEncode(<String, String>{
          'query': RequestMutations().updateRequest(
              teamRequestInput), //(fromInput, toInputs, gameInput),
        }),
      );

      print("response body: ");
      print(jsonDecode(response.body));
      dynamic updateTeamRequest =
          jsonDecode(response.body)['data']['updateRequest'];
      Map<String, dynamic> userInput = {
        "_id": appModel.currentUser['_id'],
      };
      Map<String, dynamic> teamInput = {
        "_id": teamRequestInput['team']['_id'],
      };
      if (updateTeamRequest['status'].toString() == "ACCEPTED") {
         String role = "{" + teamRequestInput['forRole'] + "}";
        await UserCommand().addTeam(userInput, teamInput, role);
      }

      //get sender information for push notification
      // Map<String, dynamic> findTeamRequestResp = await findTeamRequest(teamRequestInput);
      // print("findTeamRequestResp: " + findTeamRequestResp.toString());
      // if(findTeamRequestResp['success'] == true){
      // prepare notification data
      print("prepare notification data");
      dynamic sender = teamRequestInput['sender'];
      print("sender: " + sender.toString());
      // Map<String, dynamic> sender = findTeamRequestResp['data']['sender'];
      List<String> phones = [sender['phone']];
      List<String> OSPIDs = [sender['OSPID']];
      Map<String, dynamic> sendOrganizerRequestNotificationInput = {
        "phones": phones,
        "message": appModel.currentUser['username'] +
            " has accepted your request to join " +
            teamRequestInput['team']['name'],
        "OSPIDs": OSPIDs
      };
      await NotificationsCommand().sendAcceptedRequestNotification(
          sendOrganizerRequestNotificationInput);
      // }

      updateTeamRequestsResponse["success"] = true;
      updateTeamRequestsResponse["message"] = "Event Request Created";
      updateTeamRequestsResponse["data"] =
          jsonDecode(response.body)['data']['updateEventRequest'];
    } catch (e) {}

    return updateTeamRequestsResponse;
  }

  Future<Map<String, dynamic>> findFriendRequest(
      Map<String, dynamic> friendRequestInput) async {
    print("findFriendRequest()");
    print("friendRequestInput: " + friendRequestInput.toString());

    Map<String, dynamic> findFriendRequestResponse = {
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
          'query': RequestsQueries().findFriendRequest(friendRequestInput),
        }),
      );
      print("response body: ");
      print(jsonDecode(response.body));
      findFriendRequestResponse["success"] = true;
      findFriendRequestResponse["message"] = "Friend Request Retrieved";
      findFriendRequestResponse["data"] =
          jsonDecode(response.body)['data']['findFriendRequestByID'];

      return findFriendRequestResponse;
    } catch (e) {
      print("error in findFriendRequest");
      return findFriendRequestResponse;
    }
  }

  Future<Map<String, dynamic>> findEventRequest(
      Map<String, dynamic> eventRequestInput) async {
    print("findEventRequest()");
    print("eventRequestInput: " + eventRequestInput.toString());

    Map<String, dynamic> findEventRequestResponse = {
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
          'query': RequestsQueries().findEventRequest(eventRequestInput),
        }),
      );
      print("response body: ");
      print(jsonDecode(response.body));
      findEventRequestResponse["success"] = true;
      findEventRequestResponse["message"] = "Event Request Retrieved";
      findEventRequestResponse["data"] =
          jsonDecode(response.body)['data']['findEventRequestByID'];

      return findEventRequestResponse;
    } catch (e) {
      print("error in findEventRequest");
      return findEventRequestResponse;
    }
  }

  Future<Map<String, dynamic>> findTeamRequest(
      Map<String, dynamic> teamRequestInput) async {
    print("findTeamRequest()");
    print("teamRequestInput: " + teamRequestInput.toString());

    Map<String, dynamic> findTeamRequestResponse = {
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
          'query': RequestsQueries().findTeamRequest(teamRequestInput),
        }),
      );
      print("response body: ");
      print(jsonDecode(response.body));
      findTeamRequestResponse["success"] = true;
      findTeamRequestResponse["message"] = "Event Request Retrieved";
      findTeamRequestResponse["data"] =
          jsonDecode(response.body)['data']['findTeamRequestByID'];

      return findTeamRequestResponse;
    } catch (e) {
      print("error in findEventRequest");
      return findTeamRequestResponse;
    }
  }

  

  Map<String, dynamic> updateEventRequestsModel(dynamic eventRequest) {
    print("updateEventRequestModel");
    print(eventRequest);
    Map<String, dynamic> updateEventRequestsModelResp = {
      "success": false,
      "message": "Default Error",
      "data": null
    };

    print("updateEventRequestsModel eventRequests to set: ");
    print(eventRequest);
    print("updateEventRequestsModel before set eventRequests");
    print(requestsModel.eventRequests);
    requestsModel.eventRequests.add(eventRequest);
    // requestsPageModel.selectedObjects = eventRequests;
    print("updateEventRequestsModel after set eventRequests");
    print(requestsModel.eventRequests);

    updateEventRequestsModelResp["success"] = true;

    return updateEventRequestsModelResp;
  }

  Map<String, dynamic> updateRequestsPageSelectedModel(List requests) {
    print("updateRequestsPageSelectedModel()");
    print("requests: " + requests.toString());
    Map<String, dynamic> updateRequestsPageSelectedModelResp = {
      "success": false,
      "message": "Default Error",
      "data": null
    };

    print("selectedObjects before set: " +
        requestsPageModel.selectedObjects.toString());
    requestsPageModel.selectedObjects = requests;
    print("selectedObjects after set: " +
        requestsPageModel.selectedObjects.toString());

    updateRequestsPageSelectedModelResp["success"] = true;
    updateRequestsPageSelectedModelResp["message"] =
        "requestsPageModel.selectedObjects updated";
    updateRequestsPageSelectedModelResp["data"] =
        requestsPageModel.selectedObjects;

    return updateRequestsPageSelectedModelResp;
  }

  Map<String, dynamic> updateTeamRequestsModel(
      List teamRequests, String requestType) {
    print("updateTeamRequestsModel");
    print(teamRequests);
    Map<String, dynamic> updateTeamRequestsModelResp = {
      "success": false,
      "message": "Default Error",
      "data": null
    };

    print("updateTeamRequestsModel teamRequests to set: ");
    print(teamRequests);
    print("updateTeamRequestsModel before set teamRequests");
    print(requestsModel.teamRequests);
    List teamRequestsToShow = [];
    //loop through teamRequests
    requestsModel.teamRequests.forEach((teamRequests) {
      if (requestType == "RECIEVED") {
        if (teamRequests['sender']['_id'] != appModel.currentUser['_id']) {
          teamRequestsToShow.add(teamRequests);
        }
      } else {
        if (teamRequests['sender']['_id'] == appModel.currentUser['_id']) {
          teamRequestsToShow.add(teamRequests);
        }
      }
    });
    requestsModel.teamRequests = teamRequestsToShow;
    // requestsPageModel.selectedObjects = eventRequests;
    print("updated requestsModel.teamRequests: " +
        requestsModel.teamRequests.toString());

    updateTeamRequestsModelResp["success"] = true;
    updateTeamRequestsModelResp['data'] = requestsModel.teamRequests;

    return updateTeamRequestsModelResp;
  }

  Map<String, dynamic> updateFriendRequestsModel(List friendRequests) {
    print("updateFriendRequestsModel");
    print(friendRequests);
    Map<String, dynamic> updateFriendRequestsModelResp = {
      "success": false,
      "message": "Default Error",
      "data": null
    };

    print("updateFriendRequestsModel friendRequests to set: ");
    print(friendRequests);
    print("updateFriendRequestsModel before set eventRequests");
    print(requestsModel.friendRequests);
    requestsModel.friendRequests = friendRequests;
    // requestsPageModel.selectedObjects = friendRequests;
    print("updateFriendRequestsModel after set eventRequests");
    print(requestsModel.eventRequests);

    updateFriendRequestsModelResp["success"] = true;

    return updateFriendRequestsModelResp;
  }

  
}
