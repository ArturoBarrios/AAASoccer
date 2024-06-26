import 'dart:convert';

import 'package:soccermadeeasy/extensions/parse_roles.dart';

import '../components/join_condition.dart';
import '../graphql/fragments/team_fragments.dart';
import 'base_command.dart';
import 'package:amplify_api/amplify_api.dart';
import 'package:http/http.dart' as http;
import '../graphql/mutations/teams.dart';
import '../graphql/mutations/requests.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:geolocator/geolocator.dart';
import '../graphql/queries/teams.dart';
import '../commands/notifications_command.dart';
import '../commands/user_command.dart';
import '../constants.dart';
import '../graphql/mutations/users.dart';
import 'home_page_command.dart';

class TeamCommand extends BaseCommand {
  List getTeamUserRoles() {
    List teamUserRoles = [
      Constants.PLAYER,
      Constants.MAINCOACH,
      Constants.ASSISTANTCOACH,
    ];
    return teamUserRoles;
  }

  Future<Map<String,dynamic>> getUserTeamDetails(dynamic team, bool addToEventPageModel) async {
    print("getUserTeamDetails()");

    Map<String,dynamic> userTeamDetails = {
      "success": false,
       "isMine": false,
      "isMember": "",
      "amountPaid": 0,
      "paymentObjects": [],
      "mainEvent": null,
      "team": team,
      "players": [],
      "organizers": [],
      "events": [],
      "roles": [],
      "chats": [],
      "userParticipants": [], 
    
    };

    try{
       dynamic teamResp = await findTeamById(team);
    print("teamResp: $teamResp");
    team = teamResp['data'];
    

    
    

    //get chats
    dynamic chats = team['chats']['data'];
    userTeamDetails['chats'] = chats;
    
    print("length of chats in userTeamDetails: ${chats.length}");

    List<dynamic> myTeamRoles = getMyTeamRoles(team, appModel.currentUser);
    print("myTeamRoless: $myTeamRoles");
    print("myTeamRoles.contains organizer: ${myTeamRoles.contains("ORGANIZER")}");

    userTeamDetails['roles'] = myTeamRoles;
    
    userTeamDetails['isMine'] = myTeamRoles.contains("ORGANIZER");
    
    userTeamDetails['isMember'] = myTeamRoles.contains("PLAYER");
    
    userTeamDetails['teamLocations'] = team['teamLocations']['data'];

    List<dynamic> userParticipants = team['userParticipants']['data'];
    userTeamDetails['userParticipants'] = userParticipants;   
    for (int i = 0; i < userParticipants.length; i++) {
      if (myTeamRoles.contains("PLAYER")) {
        userTeamDetails['players'].add(userParticipants[i]['user']);
        
      }
      if (myTeamRoles.contains("ORGANIZER")) {
        userTeamDetails['organizers'].add(userParticipants[i]['user']);
        
      }
    }

    //join conditions
      userTeamDetails['team']['joinConditions']['data'].forEach((joinCondition) {
        if(joinCondition['forTeam']){
          userTeamDetails['teamRequestJoin'] = new JoinCondition(label: "Join With Request", required: joinCondition['withRequest']); 
          userTeamDetails['teamPaymentJoin'] = new JoinCondition(label: "Join With Payment", required: joinCondition['withPayment']);                     
        }        
      });

    //get price and payment info
    List payments = team['payments']['data'];
    userTeamDetails['payments'] = payments;
    
    userTeamDetails['amountPaid'] = "0.00";
    
    userTeamDetails['amountRemaining'] = "0.00";
    
    userTeamDetails['price'] = team['price'];
    
    if (team['price'] != null) {
      print("payments: $payments");
      //get payment data
      double amountPaid = 0.0;
      for (int i = 0; i < payments.length; i++) {
        if (payments[i]['user']['_id'] == appModel.currentUser['_id']) {
          print("amount before parsing: ${payments[i]['amount']}");
          amountPaid += double.parse(payments[i]['amount']);
        }
      }
      userTeamDetails['amountPaid'] = (amountPaid).toStringAsFixed(2);
      
      userTeamDetails['amountRemaining'] =
          (double.parse(team['price']['amount']) - amountPaid)
              .toStringAsFixed(2);      
    }

    print(
        "getUserTeamDetails() finished with userTeamDetails: $userTeamDetails");

    if (addToEventPageModel) {
      teamPageModel.team = userTeamDetails['team'];
      teamPageModel.chats = userTeamDetails['chats'];
      teamPageModel.roles = userTeamDetails['roles'];
      teamPageModel.isMine = userTeamDetails['isMine'];
      teamPageModel.isMember = userTeamDetails['isMember'];
      teamPageModel.userParticipants = userTeamDetails['userParticipants'];
      teamPageModel.players = userTeamDetails['players'];
      teamPageModel.organizers = userTeamDetails['organizers'];
      teamPageModel.payments = userTeamDetails['payments'];
      teamPageModel.amountPaid = userTeamDetails['amountPaid'];
      teamPageModel.amountRemaining = userTeamDetails['amountRemaining'];
      teamPageModel.price = userTeamDetails['price'];
      teamPageModel.teamLocations = userTeamDetails['teamLocations'];
      teamPageModel.teamRequestJoin = userTeamDetails['teamRequestJoin'];
      teamPageModel.teamPaymentJoin = userTeamDetails['teamPaymentJoin'];
    }

      userTeamDetails['success'] = true; 

      return userTeamDetails;
    } catch(e){
      print("error in getUserTeamDetails: $e");
      return userTeamDetails;
    }
    
      
  }

  Future<Map<String, dynamic>> findTeamById(
    Map<String, dynamic> teamInput,
  ) async {
    print("getTeam");
    Map<String, dynamic> getTeamResp = {
      "success": false,
      "message": "no team found",
      "data": null
    };
    try {
      print("teamInput: ");
      print(teamInput);

      http.Response response = await http.post(
        Uri.parse('https://graphql.fauna.com/graphql'),
        headers: <String, String>{
          'Authorization': 'Bearer ${dotenv.env['FAUNADBSECRET']}',
          'Content-Type': 'application/json'
        },
        body: jsonEncode(<String, String>{
          'query': TeamQueries().findTeamByID(teamInput),
        }),
      );

      print("response: ");
      print(jsonDecode(response.body));
      final result = jsonDecode(response.body)['data']['findTeamByID'];
      // appModel.currentTeam = result;
      // if (result != null) {
      getTeamResp["success"] = true;
      getTeamResp["message"] = "team found";
      getTeamResp["data"] = result;
      // }
    } catch (e) {
      print('Query failed: $e');
    }
    return getTeamResp;
  }

  List<dynamic> getMyTeamRoles(dynamic team, dynamic user) {
    print("getMyTeamRoles()");
    List<dynamic> roles = [];
    dynamic userParticipants = team['userParticipants']['data'];
    print("userParticipants: $userParticipants");
    for (int i = 0; i < userParticipants.length; i++) {
      if (userParticipants[i]['user']['_id'] == user['_id']) {
        roles = userParticipants[i]['roles'].toString().parseRoles();
      }
    }

    return roles;
  }

  Future<void> setupTeamsFromCurrentUser(dynamic user) async {
    print("setupTeamsFromUser()");
    Map<String, dynamic> getTeamsNearLocationResp =
        await TeamCommand().getTeamsNearLocation(TeamFragments().minimalTeam());
    if (getTeamsNearLocationResp['success']) {
      List<dynamic> teams = getTeamsNearLocationResp['data'];
      print("teams: ");
      print(teams);
      appModel.teams = teams;      
    }

    if (!appModel.isGuest) {
      appModel.myTeams = user['teamUserParticipants']['data'];
    }
  }

  List<dynamic> getAppModelTeams(){
    return appModel.teams;
  }



  List<dynamic> sortTeams(List<dynamic> teams, String sortBy) {
    //assume teams are sorted by date for now
    print("sortTeams()");
    print("sortBy: $sortBy");
    List<dynamic> sortedTeams = List.from(teams);
    sortedTeams.sort((a, b) {
      int aCreatedAt = int.tryParse(a["createdAt"]) ?? 0;
      int bCreatedAt = int.tryParse(b["createdAt"]) ?? 0;
      print("aCreatedAt: $aCreatedAt");
      print("bCreatedAt: $bCreatedAt");
      return bCreatedAt.compareTo(aCreatedAt);
    });

    return sortedTeams;
  }

  Future<Map<String, dynamic>> getAllTeams(
      String from, String teamFragment) async {
    print("getAllTeams");
    Map<String, dynamic> getAllTeamsResp = {
      "success": false,
      "message": "Default Error",
      "data": null
    };
    try {
      http.Response response = await http.post(
        Uri.parse('https://graphql.fauna.com/graphql'),
        headers: <String, String>{
          'Authorization': 'Bearer ${dotenv.env['FAUNADBSECRET']}',
          'Content-Type': 'application/json'
        },
        body: jsonEncode(<String, String>{
          'query': TeamQueries().getAllTeams(from, teamFragment),
        }),
      );

      print("response body: ");
      print(jsonDecode(response.body));
      if (response.statusCode == 200) {
        dynamic result = jsonDecode(response.body)['data']['getAllTeams'];
        print("getAllTeams result: $result");
        getAllTeamsResp["success"] = true;
        getAllTeamsResp["message"] = "Games Retrieved";
        getAllTeamsResp["data"] = result;
      }
      return getAllTeamsResp;
    } on Exception catch (e) {
      print('Mutation failed: $e');
      return getAllTeamsResp;
    }
  }

  Future<Map<String, dynamic>> getAllTeamUserParticipants(
      String userId, String teamFragment) async {
    print("getAllTeamUserParticipants");
    Map<String, dynamic> getAllTeamsResp = {
      "success": false,
      "message": "Default Error",
      "data": null
    };
    try {
      http.Response response = await http.post(
        Uri.parse('https://graphql.fauna.com/graphql'),
        headers: <String, String>{
          'Authorization': 'Bearer ${dotenv.env['FAUNADBSECRET']}',
          'Content-Type': 'application/json'
        },
        body: jsonEncode(<String, String>{
          'query':
              TeamQueries().getAllTeamUserParticipants(userId, teamFragment),
        }),
      );

      print("response body: ");
      print(jsonDecode(response.body));
      if (response.statusCode == 200) {
        dynamic result =
            jsonDecode(response.body)['data']['getAllTeamUserParticipants'];
        print("getAllTeams result: $result");
        getAllTeamsResp["success"] = true;
        getAllTeamsResp["message"] = "Games Retrieved";
        getAllTeamsResp["data"] = result;
      }
      return getAllTeamsResp;
    } on Exception catch (e) {
      print('Mutation failed: $e');
      return getAllTeamsResp;
    }
  }

  Future<Map<String, dynamic>> getTeamsNearLocation(String teamFragment) async {
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
          'Authorization': 'Bearer ${dotenv.env['FAUNADBSECRET']}',
          'Content-Type': 'application/json'
        },
        body: jsonEncode(<String, String>{
          'query': TeamQueries().getTeams(teamFragment),
        }),
      );

      print("response body: ");
      print(jsonDecode(response.body));

      dynamic result = jsonDecode(response.body)['data']['allTeams']['data'];
      if (result.length > 0) {
        result = sortTeams(result, Constants.CREATEDATE);
      }
      getTrainingsNearLocationResp["success"] = true;
      getTrainingsNearLocationResp["message"] = "Games Retrieved";
      getTrainingsNearLocationResp["data"] = result;
    } on Exception catch (e) {
      print('Mutation failed: $e');
    }

    return getTrainingsNearLocationResp;
  }

  //send player event requests
  Future<Map<String, dynamic>> sendPlayerTeamRequests(dynamic userPlayerObject,
      List<dynamic> teamsObject, List<dynamic> roles) async {
    print("sendPlayerEventRequest");
    Map<String, dynamic> sendPlayerTeamRequestsResponse = {
      "success": false,
      "message": "Default Error",
      "data": null
    };

    try {
      print("userPlayerObject: $userPlayerObject");
      print("teams: $teamsObject");
      print("roles: $roles");

      //loop through events
      for (int i = 0; i < teamsObject.length; i++) {
        for (int j = 0; j < roles.length; j++) {
          Map<String, dynamic> sendPlayerTeamRequestInput = {
            "sender_id": appModel.currentUser['_id'],
            "team_id": teamsObject[i]['_id'],
            "forRole": roles[j],
            "type": Constants.TEAMREQUEST.toString(),
            "receivers": userPlayerObject['_id']
          };

          print("sendOrganizerEventRequestInput: $sendPlayerTeamRequestInput");

          List<String> OSPIDs = [userPlayerObject['OSPID']];
          List<String> phones = [userPlayerObject['phone']];

          http.Response response = await http.post(
            Uri.parse('https://graphql.fauna.com/graphql'),
            headers: <String, String>{
              'Authorization': 'Bearer ${dotenv.env['FAUNADBSECRET']}',
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
    } catch (e) {
      print("error in sendPlayerEventRequest: $e");
      return sendPlayerTeamRequestsResponse;
    }
  }

  //send event request to team organizers
  Future<Map<String, dynamic>> sendTeamEventRequest(
      dynamic teamInput, dynamic event) async {
    print("sendTeamEventRequest");
    Map<String, dynamic> sendTeamEventRequestResponse = {
      "success": false,
      "message": "Default Error",
      "data": null
    };
    try {
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
            userParticipants[i]['roles'].toString().parseRoles();
        print("roles: $roles");
        if (roles.contains("ORGANIZER")) {
          organizersString += "$toUserId,";
          Map<String, dynamic> organizerUserInput = {"_id": toUserId};
          Map<String, dynamic> getUserResp =
              await UserCommand().findUserById(organizerUserInput);
          print("in for getUserResp: ");
          print(getUserResp);
          if (getUserResp["success"] == true) {
            Map<String, dynamic> user = getUserResp["data"];
            print("user: $user");
            if (user != null) {
              //it shouldn't be null here, risk for bug
              OSPIDs.add(user['OSPID']);
              phones.add(user['phone']);
            }
          }
        }
      }

      print("organizersString: $organizersString");
      print("OSPIDs: $OSPIDs");
      sendTeamEventRequestInput['receivers'] = organizersString;

      http.Response response = await http.post(
        Uri.parse('https://graphql.fauna.com/graphql'),
        headers: <String, String>{
          'Authorization': 'Bearer ${dotenv.env['FAUNADBSECRET']}',
          'Content-Type': 'application/json'
        },
        body: jsonEncode(<String, String>{
          'query':
              RequestMutations().sendTeamEventRequest(sendTeamEventRequestInput)
        }),
      );

      print("response: ${response.body}");
      print("sendTeamEventRequest");

      Map<String, dynamic> sendOrganizerRequestNotificationInput = {
        "phones": phones,
        "message": appModel.currentUser['username'] +
            " has sent your team a request to join tournament called" +
            event['name'],
        "OSPIDs": OSPIDs
      };
      await NotificationsCommand().sendOrganizerRequestNotification(
          sendOrganizerRequestNotificationInput);

      sendTeamEventRequestResponse["success"] = true;
      sendTeamEventRequestResponse["message"] = "Event Request to Team Created";

      return sendTeamEventRequestResponse;
    } catch (e) {
      print("error in sendTeamEventRequest: $e");
      return sendTeamEventRequestResponse;
    }
  }

  //send event request to event organizers for team
  Future<Map<String, dynamic>> sendEventRequestForMyTeam(
      dynamic eventInput, dynamic teamInput) async {
    print("sendEventRequestForMyTeam");
    Map<String, dynamic> sendEventRequestForMyTeamResponse = {
      "success": false,
      "message": "Default Error",
      "data": null
    };

    try {
      print("teamInput: $teamInput");
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
            userParticipants[i]['roles'].toString().parseRoles();
        print("roles: $roles");
        if (roles.contains("ORGANIZER")) {
          organizersString += "$toUserId,";
          Map<String, dynamic> organizerUserInput = {"_id": toUserId};
          Map<String, dynamic> getUserResp =
              await UserCommand().findUserById(organizerUserInput);
          print("in for getUserResp: ");
          print(getUserResp);
          if (getUserResp["success"] == true) {
            Map<String, dynamic> user = getUserResp["data"];
            print("user: $user");
            if (user != null) {
              //it shouldn't be null here, risk for bug
              OSPIDs.add(user['OSPID']);
              phones.add(user['phone']);
            }
          }
        }
      }

      print("organizersString: $organizersString");
      print("OSPIDs: $OSPIDs");
      print("phones: $phones");
      sendEventRequestForMyTeamInput['receivers'] = organizersString;

      http.Response response = await http.post(
        Uri.parse('https://graphql.fauna.com/graphql'),
        headers: <String, String>{
          'Authorization': 'Bearer ${dotenv.env['FAUNADBSECRET']}',
          'Content-Type': 'application/json'
        },
        body: jsonEncode(<String, String>{
          'query': RequestMutations()
              .sendTeamEventRequest(sendEventRequestForMyTeamInput)
        }),
      );

      print("response: ${response.body}");
      print("sendTeamEventRequest");

      Map<String, dynamic> sendOrganizerRequestNotificationInput = {
        "phones": phones,
        "message": appModel.currentUser['username'] +
            " from " +
            teamInput['name'] +
            " has sent you a request to join your tournament " +
            eventInput['name'],
        "OSPIDs": OSPIDs
      };
      print(
          "sendOrganizerRequestNotificationInput: $sendOrganizerRequestNotificationInput");
      await NotificationsCommand().sendOrganizerRequestNotification(
          sendOrganizerRequestNotificationInput);

      sendEventRequestForMyTeamResponse["success"] = true;
      sendEventRequestForMyTeamResponse["message"] =
          "Event Request to Team Created";

      return sendEventRequestForMyTeamResponse;
    } catch (e) {
      print("error in sendEventRequestForMyTeam: $e");
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
            userParticipants[i]['roles'].toString().parseRoles();
        print("roles: $roles");
        if (roles.contains("ORGANIZER")) {
          organizersString += "$toUserId,";
          Map<String, dynamic> organizerUserInput = {"_id": toUserId};
          Map<String, dynamic> getUserResp =
              await UserCommand().findUserById(organizerUserInput);
          print("in for getUserResp: ");
          print(getUserResp);
          if (getUserResp["success"] == true) {
            Map<String, dynamic> user = getUserResp["data"];
            print("user: $user");
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
          'Authorization': 'Bearer ${dotenv.env['FAUNADBSECRET']}',
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

  void updateModelsWithTeam(dynamic team, bool add) {
    print("updateModelsWithTeam");
    print(team);

    if (add) {
      appModel.teams.add(team);
      appModel.myTeams.add(team);
    } else {
      appModel.teams.removeWhere((element) => element['_id'] == team['_id']);
      appModel.myTeams.removeWhere((element) => element['_id'] == team['_id']);
    }

    HomePageCommand().updateUpdatedCards(true);

    // appModel.currentUser['teamUserParticipants']['data'].add(userParticipantObject);
    // if (homePageModel.selectedKey == Constants.TEAM) {
    //   homePageModel.selectedObjects.add(team);
    // }
  }

  Future<Map<String, dynamic>> createTeam(
    Map<String, dynamic> teamInput,
    Map<String, dynamic> locationInput,
  ) async {
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
      teamInput['price'] = teamInput['price'] * 100;
      http.Response response = await http.post(
        Uri.parse('https://graphql.fauna.com/graphql'),
        headers: <String, String>{
          'Authorization': 'Bearer ${dotenv.env['FAUNADBSECRET']}',
          'Content-Type': 'application/json'
        },
        body: jsonEncode(<String, String>{
          'query': TeamMutations().createTeam(teamInput, locationInput),
        }),
      );

      print("response body: ");
      print(jsonDecode(response.body));
      if (response.statusCode == 200) {
        dynamic createdTeam = createTeamResponse["data"] =
            jsonDecode(response.body)['data']['createTeam'];

        createTeamResponse["data"] = createdTeam;
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

  Future<Map<String, dynamic>> createPrice(
      dynamic paymentInput, dynamic teamInput) async {
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
          'Authorization': 'Bearer ${dotenv.env['FAUNADBSECRET']}',
          'Content-Type': 'application/json'
        },
        body: jsonEncode(<String, String>{
          'query': TeamMutations().createPrice(paymentInput, teamInput),
        }),
      );
      print("response body: ");
      print(jsonDecode(response.body));
      Map<String, dynamic> createdPayment =
          jsonDecode(response.body)['data']['createPrice'];
      print("createdPayment: $createdPayment");
      createPriceResp["success"] = true;
      createPriceResp["message"] = "Payment Created";
      createPriceResp["data"] = createdPayment;

      return createPriceResp;
    } on Exception catch (e) {
      print("Mutation failed: $e");
      return createPriceResp;
    }
  }

  Future<Map<String, dynamic>> removeUsersFromTeam(
      dynamic team, List<dynamic> users) async {
    print("removePlayersFromTeam");
    print("team: $team");
    print("players: $users");

    Map<String, dynamic> removePlayersFromTeamResponse = {
      "success": false,
      "message": "Default Error",
      "data": null
    };

    try {
      users.forEach((user) async {
        dynamic userInput = {
          "_id": user['_id'],
        };

        http.Response response = await http.post(
          Uri.parse('https://graphql.fauna.com/graphql'),
          headers: <String, String>{
            'Authorization': 'Bearer ${dotenv.env['FAUNADBSECRET']}',
            'Content-Type': 'application/json'
          },
          body: jsonEncode(<String, String>{
            'query': UserMutations().removeTeamFromUser(userInput, team),
          }),
        );

        print("response body: ");
        print(jsonDecode(response.body));

        removePlayersFromTeamResponse['success'] = true;
        removePlayersFromTeamResponse['message'] = "Team from players";
      });
      return removePlayersFromTeamResponse;
    } on Exception catch (e) {
      print("Mutation failed: $e");
      return removePlayersFromTeamResponse;
    }
  }

  Future<Map<String, dynamic>> addUserToTeam(
      dynamic teamInput, dynamic userInput, String roles) async {
    print("addUserToTeam");
    Map<String, dynamic> addUserToTeamResponse = {
      "success": false,
      "message": "Default Error",
      "data": null
    };
    try {
      dynamic userObject = UserCommand().getAppModelUser();
      dynamic updateRoleResp = TeamCommand()
          .checkIfUpdateRole(teamInput, userObject, teamInput['forRole']);
      if (updateRoleResp['updateRole']) {
        await updateUserRolesInTeam(
            teamInput, userInput, roles, updateRoleResp['teamUserParticipant']);
      } else {
        http.Response response = await http.post(
          Uri.parse('https://graphql.fauna.com/graphql'),
          headers: <String, String>{
            'Authorization': 'Bearer ${dotenv.env['FAUNADBSECRET']}',
            'Content-Type': 'application/json'
          },
          body: jsonEncode(<String, String>{
            'query': UserMutations().addUserToTeam(userInput, teamInput, roles),
          }),
        );

        print("response body: ");
        print(jsonDecode(response.body));

        await addTeamToMyTeams(jsonDecode(response.body)['data']['updateTeam']);
      }

      return addUserToTeamResponse;
    } on ApiException catch (e) {
      print('Mutation failed: $e');
      return addUserToTeamResponse;
    }
  }

  Future<Map<String, dynamic>> addTeamToMyTeams(
      Map<String, dynamic> teamInput) async {
    print("addTeamToMyTeams");
    print("teamInput: $teamInput");
    Map<String, dynamic> addTeamToMyTeamsResponse = {
      "success": false,
      "message": "Default Error",
      "data": null
    };
    print("before getTeam");
    dynamic team = findTeamById(teamInput);
    print("team: $team");
    print("before appModel.myTeams: ${appModel.myTeams}");
    appModel.myTeams.add(team);

    print("after appModel.myTeams: ${appModel.myTeams}");
    addTeamToMyTeamsResponse["success"] = true;

    return addTeamToMyTeamsResponse;
  }

  Future<Map<String, dynamic>> updateUserRolesInTeam(dynamic teamInput,
      dynamic userInput, String roles, String teamRequestId) async {
    print("updateUserRolesInTeam");
    Map<String, dynamic> addUserToTeamResponse = {
      "success": false,
      "message": "Default Error",
      "data": null
    };
    try {
      http.Response response = await http.post(
        Uri.parse('https://graphql.fauna.com/graphql'),
        headers: <String, String>{
          'Authorization': 'Bearer ${dotenv.env['FAUNADBSECRET']}',
          'Content-Type': 'application/json'
        },
        body: jsonEncode(<String, String>{
          'query': TeamMutations().updateUserRolesInTeam(
              teamInput, userInput, roles, teamRequestId),
        }),
      );

      print("response body: ");
      print(jsonDecode(response.body));

      addTeamToMyTeams(jsonDecode(response.body)['data']
          ['partialUpdateTeamUserParticipant']['team']);

      return addUserToTeamResponse;
    } on ApiException catch (e) {
      print('Mutation failed: $e');
      return addUserToTeamResponse;
    }
  }

  Map<String, dynamic> checkIfUpdateRole(
      dynamic team, dynamic userObject, String role) {
    print("checkIfUpdateRole");
    dynamic checkIfUpdateRoleResp = {"updateRole": false, "teamRequestId": ""};
    userObject['teamUserParticipants']['data']
        .forEach((teamUserParticipantElement) {
      if (teamUserParticipantElement['team']['_id'] == team['_id']) {
        //update role
        checkIfUpdateRoleResp['updateRole'] = true;
        checkIfUpdateRoleResp['teamUserParticipant'] =
            teamUserParticipantElement['_id'];
      }
    });
    print("checkIfUpdateRoleResp: $checkIfUpdateRoleResp");

    return checkIfUpdateRoleResp;
  }

  Future<Map<String, dynamic>> updateTeamUserParticipant(
      dynamic teamUserParticipant, String newRoles) async {
    print("updateTeamUserParticipant");
    print("newRoles: $newRoles");

    Map<String, dynamic> updateTeamUserParticipantResponse = {
      "success": false,
      "message": "Default Error",
      "data": null
    };

    dynamic updateTeamUserParticipantInput = {
      "_id": teamUserParticipant['_id'],
      "roles": newRoles
    };

    http.Response response = await http.post(
      Uri.parse('https://graphql.fauna.com/graphql'),
      headers: <String, String>{
        'Authorization': 'Bearer ${dotenv.env['FAUNADBSECRET']}',
        'Content-Type': 'application/json'
      },
      body: jsonEncode(<String, String>{
        'query': TeamMutations()
            .updateTeamUserParticipant(updateTeamUserParticipantInput),
      }),
    );

    print("response body: ");
    print(jsonDecode(response.body));

    updateTeamUserParticipantResponse["success"] = true;
    updateTeamUserParticipantResponse["message"] =
        "Team User Participant Updated";
    updateTeamUserParticipantResponse["data"] =
        jsonDecode(response.body)['data']['updateTeamUserParticipant'];

    return updateTeamUserParticipantResponse;
  }

  Future<Map<String, dynamic>> addUsersRolesInTeam(
      dynamic team, List<dynamic> users, List<dynamic> roles) async {
    print("removePlayersFromTeam");
    print("users: $users");
    print("roles: $roles");

    Map<String, dynamic> addUsersRolesInTeamResponse = {
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

    addUsersRolesInTeamResponse["success"] = true;
    addUsersRolesInTeamResponse["message"] = "Team Removed";
    // removePlayersFromTeamResponse["data"] =
    //     jsonDecode(response.body)['data']['updateTeam'];

    return addUsersRolesInTeamResponse;
  }
}
