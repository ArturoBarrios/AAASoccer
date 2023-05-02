import 'dart:convert';
import 'base_command.dart';
import 'package:amplify_api/amplify_api.dart';
import 'package:faunadb_http/faunadb_http.dart';
import 'package:faunadb_http/query.dart';
import '../models/app_model.dart';
import 'package:http/http.dart' as http;
import '../graphql/mutations/teams.dart';
import '../graphql/mutations/requests.dart';
import '../graphql/mutations/locations.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../commands/geolocation_command.dart';
// import 'package:geolocator/geolocator.dart';
import '../graphql/queries/teams.dart';
import '../commands/notifications_command.dart';
import '../commands/user_command.dart';
import '../constants.dart';
import '../graphql/mutations/users.dart';

class TeamCommand extends BaseCommand {

  bool isMyTeam(dynamic team){
    print("isMyTeam()");

    bool resp = false;
    dynamic userParticipants = team['userParticipants']['data'];
    print("userParticipants: " + userParticipants.toString());
    for(int i = 0; i<userParticipants.length; i++){
      if(userParticipants[i]['user']['_id'] == appModel.currentUser['_id']){
        resp = true;
        print("isMyTeam() = true");
      }
    }

    return resp;
  }

  List<dynamic> getAppModelTeamsNearMe() {
    print("getAppModelTeamsNearMe");
    print("appModel.teamsNearMe: "+appModel.teamsNearMe.toString());
    return appModel.teamsNearMe;
  }

  Future<Map<String, dynamic>> getTeamsNearLocation() async {
    print("getTeamsNearLocation");
    Map<String, dynamic> getTrainingsNearLocationResp = {
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
          'query': TeamQueries().getTeams(),
        }),
      );

      print("response body: ");
      print(jsonDecode(response.body));

      final result = jsonDecode(response.body)['data']['allTeams']['data'];
      getTrainingsNearLocationResp["success"] = true;
      getTrainingsNearLocationResp["message"] = "Games Retrieved";
      getTrainingsNearLocationResp["data"] = result;
    } on Exception catch (e) {
      print('Mutation failed: $e');
    }

    return getTrainingsNearLocationResp;
  }

  //send player event requests
  Future<Map<String, dynamic>> sendPlayerTeamRequests(
      dynamic userPlayerObject,List<dynamic> teamsObject, List<String> roles) async {

    print("sendPlayerEventRequest");
    Map<String, dynamic> sendPlayerTeamRequestsResponse = {
      "success": false,
      "message": "Default Error",
      "data": null
    };

    try{
      print("userPlayerObject: " + userPlayerObject.toString());
      print("teams: " + teamsObject.toString());
      print("roles: " + roles.toString());

      //loop through events
      for(int i = 0;i<teamsObject.length;i++){
        for(int j = 0;j<roles.length;j++){
          Map<String, dynamic> sendPlayerTeamRequestInput = {
            "sender_id": appModel.currentUser['_id'],
            "team_id": teamsObject[i]['_id'],            
            "forRole": roles[j],
            "type": Constants.TEAMREQUEST.toString(),
            "receivers": userPlayerObject['_id']

          };

          print("sendOrganizerEventRequestInput: "+sendPlayerTeamRequestInput.toString());

          List<String> OSPIDs = [userPlayerObject['OSPID']];
          List<String> phones = [userPlayerObject['phone']];

          http.Response response = await http.post(
            Uri.parse('https://graphql.fauna.com/graphql'),
            headers: <String, String>{
              'Authorization': 'Bearer ' + dotenv.env['FAUNADBSECRET'].toString(),
              'Content-Type': 'application/json'
            },
            body: jsonEncode(<String, String>{
              'query': RequestMutations().sendTeamRequest(
                  sendPlayerTeamRequestInput), //(fromInput, toInputs, gameInput),
            }),
          );

          print("responseee body: ");
          print(jsonDecode(response.body));

          Map<String, dynamic> sendPlayerRequestNotificationInput = {
            "phones": phones,
            "message": appModel.currentUser['username'] +
            " has sent you a request to join team",
            "OSPIDs": OSPIDs
          };

          await NotificationsCommand().sendOrganizerRequestNotification(
              sendPlayerRequestNotificationInput);        
        }

      }

      sendPlayerTeamRequestsResponse["success"] = true;
      sendPlayerTeamRequestsResponse["message"] = "Event Requests Created";      


      return sendPlayerTeamRequestsResponse;
    } catch(e){
      print("error in sendPlayerEventRequest: " + e.toString());
      return sendPlayerTeamRequestsResponse;
    }


    

  }

  
  //send event request to team organizers
  Future<Map<String, dynamic>> sendTeamEventRequest(
      dynamic teamInput, dynamic event
  ) async{
    print("sendTeamEventRequest");
    Map<String, dynamic> sendTeamEventRequestResponse = {
      "success": false,
      "message": "Default Error",
      "data": null
    };
    try{
      dynamic sendTeamEventRequestInput = {
        "sender_id": appModel.currentUser['_id'],
        "team_id": teamInput['_id'],
        "event_id": event['_id'],
        "type": Constants.TOURNAMENTREQUEST.toString(),
     
      };      


      dynamic userParticipants = teamInput['userParticipants']['data'];
      print("teamParticipants");
      print(userParticipants);
      String organizersString = "";
      print("get OSPIDs");
      //populate list with onesignal player ids
      List<String> OSPIDs = [];
      List<String> phones = [];
      for (var i = 0; i < userParticipants.length; i++) {
        String toUserId = userParticipants[i]['user']['_id'];
        List<String> roles =
            BaseCommand().parseRoles(userParticipants[i]['roles']);
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

      print("organizersString: " + organizersString);
      print("OSPIDs: " + OSPIDs.toString());
      sendTeamEventRequestInput['receivers'] = organizersString;


      http.Response response = await http.post(
        Uri.parse('https://graphql.fauna.com/graphql'),
        headers: <String, String>{
          'Authorization': 'Bearer ' + dotenv.env['FAUNADBSECRET'].toString(),
          'Content-Type': 'application/json'
        },
        body: jsonEncode(<String, String>{
          'query':
              RequestMutations().sendTeamEventRequest(sendTeamEventRequestInput)
        }),
      );

      print("response: "+ response.body.toString());
      print("sendTeamEventRequest");

      Map<String, dynamic> sendOrganizerRequestNotificationInput = {
        "phones": phones,
        "message": appModel.currentUser['username'] +
            " has sent your team a request to join tournament called"+event['name'],
        "OSPIDs": OSPIDs
      };
      await NotificationsCommand().sendOrganizerRequestNotification(
          sendOrganizerRequestNotificationInput);


      sendTeamEventRequestResponse["success"] = true;
      sendTeamEventRequestResponse["message"] = "Event Request to Team Created";

      return sendTeamEventRequestResponse;
    } catch(e){
      print("error in sendTeamEventRequest: " + e.toString());
      return sendTeamEventRequestResponse;
    }
  }

  //send event request to event organizers for team
  Future<Map<String,dynamic>> sendEventRequestForMyTeam(
    dynamic eventInput, dynamic teamInput
  ) async{
    print("sendEventRequestForMyTeam");
    Map<String, dynamic> sendEventRequestForMyTeamResponse = {
      "success": false,
      "message": "Default Error",
      "data": null
    };

    try{
      print("teamInput: "+ teamInput.toString());
      dynamic sendEventRequestForMyTeamInput = {
        "sender_id": appModel.currentUser['_id'],
        "team_id": teamInput['_id'],
        "event_id": eventInput['_id'],
        "type": Constants.TOURNAMENTREQUEST.toString(),                
      };

      dynamic userParticipants = eventInput['userParticipants']['data'];
      print("userParticipants");
      print(userParticipants);
      String organizersString = "";
      print("get OSPIDs");
      //populate list with onesignal player ids
      List<String> OSPIDs = [];
      List<String> phones = [];
      for (var i = 0; i < userParticipants.length; i++) {
        String toUserId = userParticipants[i]['user']['_id'];
        List<String> roles =
            BaseCommand().parseRoles(userParticipants[i]['roles']);
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

      print("organizersString: " + organizersString);
      print("OSPIDs: " + OSPIDs.toString());
      print("phones: " + phones.toString());
      sendEventRequestForMyTeamInput['receivers'] = organizersString;

      http.Response response = await http.post(
        Uri.parse('https://graphql.fauna.com/graphql'),
        headers: <String, String>{
          'Authorization': 'Bearer ' + dotenv.env['FAUNADBSECRET'].toString(),
          'Content-Type': 'application/json'
        },
        body: jsonEncode(<String, String>{
          'query':
              RequestMutations().sendTeamEventRequest(sendEventRequestForMyTeamInput)
        }),
      );

      print("response: "+ response.body.toString());
      print("sendTeamEventRequest");
      
       Map<String, dynamic> sendOrganizerRequestNotificationInput = {
        "phones": phones,
        "message": appModel.currentUser['username']+" from "+teamInput['name'] +
            " has sent you a request to join your tournament "+ eventInput['name'],
        "OSPIDs": OSPIDs
      };
      print("sendOrganizerRequestNotificationInput: "+sendOrganizerRequestNotificationInput.toString());
      await NotificationsCommand().sendOrganizerRequestNotification(
          sendOrganizerRequestNotificationInput
      );


      sendEventRequestForMyTeamResponse["success"] = true;
      sendEventRequestForMyTeamResponse["message"] = "Event Request to Team Created";


      return sendEventRequestForMyTeamResponse;
    }catch (e){
      print("error in sendEventRequestForMyTeam: " + e.toString());
      return sendEventRequestForMyTeamResponse;
    }
  }

  //send team organizers team request
  Future<Map<String, dynamic>> sendTeamOrganizersRequest(
      dynamic teamInput, String role) async {
    print("sendTeamRequest");
    Map<String, dynamic> sendTeamRequestResponse = {
      "success": false,
      "message": "Default Error",
      "data": null
    };
    try {
      Map<String, dynamic> sendOrganizerTeamRequestInput = {
        "sender_id": appModel.currentUser['_id'],
        "team_id": teamInput['_id'],
        "forRole": role,
        "type": Constants.TEAMREQUEST.toString()
      };
      teamInput["sender_id"] = appModel.currentUser['_id'];

      print("teamRequestInput");
      print(teamInput);
      //useful for preventing spam(set max to 50 per day)
      //possible solution for creating EventRequest
      //create string with _ids and syntax and call in
      //tos
      dynamic userParticipants = teamInput['userParticipants']['data'];
      print("teamParticipants");
      print(userParticipants);
      String organizersString = "";
      print("get OSPIDs");
      //populate list with onesignal player ids
      List<String> OSPIDs = [];
      List<String> phones = [];
      for (var i = 0; i < userParticipants.length; i++) {
        String toUserId = userParticipants[i]['user']['_id'];
        List<String> roles =
            BaseCommand().parseRoles(userParticipants[i]['roles']);
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
      sendOrganizerTeamRequestInput['receivers'] = organizersString;

      print("organizersString");
      print(organizersString);
      print("time to goooo");
      //check if from and to are the same
      http.Response response = await http.post(
        Uri.parse('https://graphql.fauna.com/graphql'),
        headers: <String, String>{
          'Authorization': 'Bearer ' + dotenv.env['FAUNADBSECRET'].toString(),
          'Content-Type': 'application/json'
        },
        body: jsonEncode(<String, String>{
          'query':
              RequestMutations().sendTeamRequest(sendOrganizerTeamRequestInput)
        }),
      );

      print("response body: ");
      print(jsonDecode(response.body));

      dynamic createTeamRequest =
          jsonDecode(response.body)['data']['createTeamRequest'];

      Map<String, dynamic> sendOrganizerRequestNotificationInput = {
        "phones": phones,
        "message": appModel.currentUser['username'] +
            " has sent you a request to join team",
        "OSPIDs": OSPIDs
      };
      await NotificationsCommand().sendOrganizerRequestNotification(
          sendOrganizerRequestNotificationInput);

      sendTeamRequestResponse["success"] = true;
      sendTeamRequestResponse["message"] = "Event Request Created";
      sendTeamRequestResponse["data"] =
          jsonDecode(response.body)['data']['CreateTeamRequest'];
    } catch (e) {}

    return sendTeamRequestResponse;
  }

  void updateModelsWithTeam(dynamic team) {
    print("updateModelsWithTeam");
    print(team);

    appModel.teams.add(team);
    appModel.myTeams.add(team);

    // appModel.currentUser['teamUserParticipants']['data'].add(userParticipantObject);
    // if (homePageModel.selectedKey == Constants.TEAM) {
    //   homePageModel.selectedObjects.add(team);
    // }
  }

  Future<Map<String, dynamic>> createTeam(Map<String, dynamic> teamInput,
      Map<String, dynamic> locationInput) async {
    print("createTeam");
    Map<String, dynamic> createTeamResponse = {
      "success": false,
      "message": "Default Error",
      "data": null
    };
    try {
      print("team input: ");
      print(teamInput);
      teamInput['user_id'] = appModel.currentUser['_id'];
      http.Response response = await http.post(
        Uri.parse('https://graphql.fauna.com/graphql'),
        headers: <String, String>{
          'Authorization': 'Bearer ' + dotenv.env['FAUNADBSECRET'].toString(),
          'Content-Type': 'application/json'
        },
        body: jsonEncode(<String, String>{
          'query': TeamMutations().createTeam(teamInput, locationInput),
        }),
      );

      print("response body: ");
      print(jsonDecode(response.body));
      if (response.statusCode == 200) {
        dynamic createdTeam = 
        createTeamResponse["data"] =
            jsonDecode(response.body)['data']['createTeam'];
        
        TeamCommand().updateModelsWithTeam(createdTeam);
        createTeamResponse["success"] = true;
        createTeamResponse["message"] = "Location Created";
        
      } else {
        //rollback somehow???
        // If the server did not return a 200 OK response,
        // then throw an exception.
        throw Exception('Failed to load album');
      }
      return createTeamResponse;
    } on ApiException catch (e) {
      print('Mutation failed: $e');
      return createTeamResponse;
    }
  }

  Future<Map<String, dynamic>> removeTeam(String teamId) async {
    print("removeTeam");
    print("teamId: " + teamId);
    Map<String, dynamic> removeTeamResponse = {
      "success": false,
      "message": "Default Error",
      "data": null
    };
    Map<String, dynamic> userInput = {
      "_id": appModel.currentUser['_id'],
    };
    Map<String, dynamic> teamInput = {
      "_id": teamId,
    };

    http.Response response = await http.post(
      Uri.parse('https://graphql.fauna.com/graphql'),
      headers: <String, String>{
        'Authorization': 'Bearer ' + dotenv.env['FAUNADBSECRET'].toString(),
        'Content-Type': 'application/json'
      },
      body: jsonEncode(<String, String>{
        'query': UserMutations().removeTeamFromUser(userInput, teamInput),
      }),
    );

    print("response body: ");
    print(jsonDecode(response.body));

    //remove team from eventsModel.teams
    print("remove team from appModel.teams: " + appModel.teams.toString());
    var i = 0;
    var found = false;
    while (i < appModel.teams.length - 1 && !found) {
      if (appModel.teams[i]['id'] == jsonDecode(response.body)['id']) {
        var removed = appModel.teams.removeAt(i);
        print("removedTeamObject: ");
        print(removed);
        found = true;
      }
      i += 1;
    }
    print("length of teams after archiving team: ");
    print(appModel.teams.length);

    removeTeamResponse["success"] = true;
    removeTeamResponse["message"] = "Team Removed";
    removeTeamResponse["data"] =
        jsonDecode(response.body)['data']['updateTeam'];

    return removeTeamResponse;
  }
}
