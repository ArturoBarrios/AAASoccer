import 'dart:convert';
import 'dart:ffi';
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
import '../enums/RequestStatus.dart';

class RequestsCommand extends BaseCommand {


  //gets most up to date user model and assigns
  //requests appropriately
  Future<void> updatedSelectedRequests(String requestType) async{
    print("updatedSelectedRequests");
    print("requestType: " + requestType);
    Map<String, dynamic> getRequestsResp = await UserCommand().getCurrentUserByEmail();    
    
    if (getRequestsResp['success']) {
      // UserCommand().updateUserModelWithUser(getRequestsResp['data']);
      List requestsSent = getRequestsResp['data']['requestsSent']['data'];
      List requestsReceived = getRequestsResp['data']['requestsReceived']['data'];
      print("requestsSent: " + requestsSent.toString());
      print("requestsReceived: " + requestsReceived.toString());
      requestsModel.requestsSent = requestsSent;
      requestsModel.requestsReceived = requestsReceived;      
      if(requestType=="SENT"){
        print("sent");
        requestsPageModel.selectedObjects = requestsSent;        
      }
      else{
        requestsPageModel.selectedObjects = requestsReceived;;              
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

      final result = jsonDecode(response.body)['data']['allEventRequests']['data'];
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

      final result = jsonDecode(response.body)['data']['allTeamRequests']['data'];
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
  Future<Map<String, dynamic>> updateEventRequests(Map<String, dynamic> eventRequestInput  ) async{
    print("updateEventRequest");
    Map<String, dynamic> updateEventRequestResponse = {"success": false, "message": "Default Error", "data": null};
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
          'Authorization': 'Bearer '+ dotenv.env['FAUNADBSECRET'].toString(),
          'Content-Type': 'application/json'
        },
        body: jsonEncode(<String, String>{
          'query': RequestMutations().updateRequest(eventRequestInput),//(fromInput, toInputs, gameInput),
        }),
      );
    
      print("response body: ");
      print(jsonDecode(response.body));
      dynamic updateEventRequest = jsonDecode(response.body)['data']['updateEventRequest'];
      Map<String, dynamic> userInput = {
        "_id": appModel.currentUser['_id'],
      };
      print("a");
      Map<String, dynamic> eventInput = {
        "_id": eventRequestInput['event']['_id'],
      };
      print("b");

      
      print("updateEventRequest: "+updateEventRequest.toString());
      print("updateEventRequest['status']: "+updateEventRequest['status'].toString());
      print("RequestStatus.ACCEPTED:"+ RequestStatus.ACCEPTED.toString());
      print("updateEventRequest['status'].toString() == RequestStatus.ACCEPTED.toString(): "+ (updateEventRequest['status'].toString() == RequestStatus.ACCEPTED.toString()).toString());
      // add to my events if it's your event
      if(updateEventRequest['status'].toString() == "ACCEPTED"){ 
        print("before UserCommand().addEvent()");
        Map<String, dynamic> addEventResp = await UserCommand().addEvent(userInput, eventInput);        
        print("addEventResp: " + addEventResp.toString());        
        print("before EventCommand().addEvent()");
        //get event       
        Map<String, dynamic> addEventToMyEventsResp = await EventCommand().addEventToMyEvents(eventRequestInput);        
        print("addEventToMyEventsResp: " + addEventToMyEventsResp.toString());

      }

      
      //send notification to sender)
      //get sender information for push notification
      Map<String, dynamic> findEventRequestResp = await findEventRequest(eventRequestInput);   

      print("findEventRequestResp: " + findEventRequestResp.toString());  
      if(findEventRequestResp['success'] == true){
        // prepare notification data
        print("prepare notification data");
        Map<String, dynamic> sender = findEventRequestResp['data']['sender'];
        print("sender: "+ sender.toString());
        List<String> phones = [sender['phone']];
        List<String> OSPIDs = [sender['OSPID']];
        Map<String, dynamic> sendOrganizerRequestNotificationInput = {
          "phones": phones,
          "message": appModel.currentUser['name'] + " has accepted your request to join event",
          "OSPIDs": OSPIDs
        };
        await NotificationsCommand().sendAcceptedRequestNotification(sendOrganizerRequestNotificationInput);
      } 


      //todo 
      //add check and revert entirely if adding event fails???            
      updateEventRequestResponse["success"] = true;
      updateEventRequestResponse["message"] = "Event Request Created";      
      updateEventRequestResponse["data"] = jsonDecode(response.body)['data']['updateEventRequest'];          
    } catch (e) {}

    return updateEventRequestResponse;

  }

  Future<Map<String, dynamic>> updateTeamRequests(Map<String, dynamic> teamRequestInput  ) async{
    print("updateTeamRequests");
    Map<String, dynamic> updateTeamRequestsResponse = {"success": false, "message": "Default Error", "data": null};
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
          'Authorization': 'Bearer '+ dotenv.env['FAUNADBSECRET'].toString(),
          'Content-Type': 'application/json'
        },
        body: jsonEncode(<String, String>{
          'query': TeamMutations().updateTeamRequest(teamRequestInput),//(fromInput, toInputs, gameInput),
        }),
      );      
    
      print("response body: ");
      print(jsonDecode(response.body));

      Map<String, dynamic> userInput = {
        "_id": appModel.currentUser['_id'],
      };
      Map<String, dynamic> teamInput = {
        "_id": teamRequestInput['team']['_id'],
      };
      await UserCommand().addTeam(userInput, teamInput);    

      //get sender information for push notification
      Map<String, dynamic> findTeamRequestResp = await findTeamRequest(teamRequestInput);   
      print("findTeamRequestResp: " + findTeamRequestResp.toString());  
      if(findTeamRequestResp['success'] == true){
        // prepare notification data
        print("prepare notification data");
        Map<String, dynamic> sender = findTeamRequestResp['data']['sender'];
        print("sender: "+ sender.toString());
        List<String> phones = [sender['phone']];
        List<String> OSPIDs = [sender['OSPID']];
        Map<String, dynamic> sendOrganizerRequestNotificationInput = {
          "phones": phones,
          "message": appModel.currentUser['name'] + " has accepted your request to join team",
          "OSPIDs": OSPIDs
        };
        await NotificationsCommand().sendAcceptedRequestNotification(sendOrganizerRequestNotificationInput);
      } 

      updateTeamRequestsResponse["success"] = true;
      updateTeamRequestsResponse["message"] = "Event Request Created";      
      updateTeamRequestsResponse["data"] = jsonDecode(response.body)['data']['updateEventRequest'];          
    } catch (e) {}

    return updateTeamRequestsResponse;

  }
  
  Future<Map<String, dynamic>> findFriendRequest(Map<String, dynamic> friendRequestInput  ) async{
      
    print("findFriendRequest()");
    print("friendRequestInput: " + friendRequestInput.toString());


    Map<String, dynamic> findFriendRequestResponse = {"success": false, "message": "Default Error", "data": null};
    try{

      http.Response response = await http.post(
        Uri.parse('https://graphql.fauna.com/graphql'),
        headers: <String, String>{
          'Authorization': 'Bearer '+ dotenv.env['FAUNADBSECRET'].toString(),
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
      findFriendRequestResponse["data"] = jsonDecode(response.body)['data']['findFriendRequestByID'];

      return findFriendRequestResponse;
    } catch (e) {
      print("error in findFriendRequest");
      return findFriendRequestResponse;
    }        
  }

  Future<Map<String, dynamic>> findEventRequest(Map<String, dynamic> eventRequestInput  ) async{
      
    print("findEventRequest()");
    print("eventRequestInput: " + eventRequestInput.toString());


    Map<String, dynamic> findEventRequestResponse = {"success": false, "message": "Default Error", "data": null};
    try{

      http.Response response = await http.post(
        Uri.parse('https://graphql.fauna.com/graphql'),
        headers: <String, String>{
          'Authorization': 'Bearer '+ dotenv.env['FAUNADBSECRET'].toString(),
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
      findEventRequestResponse["data"] = jsonDecode(response.body)['data']['findEventRequestByID'];

      return findEventRequestResponse;
    } catch (e) {
      print("error in findEventRequest");
      return findEventRequestResponse;
    }        
  }
  
  Future<Map<String, dynamic>> findTeamRequest(Map<String, dynamic> teamRequestInput) async{
      
    print("findTeamRequest()");
    print("teamRequestInput: " + teamRequestInput.toString());


    Map<String, dynamic> findTeamRequestResponse = {"success": false, "message": "Default Error", "data": null};
    try{

      http.Response response = await http.post(
        Uri.parse('https://graphql.fauna.com/graphql'),
        headers: <String, String>{
          'Authorization': 'Bearer '+ dotenv.env['FAUNADBSECRET'].toString(),
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
      findTeamRequestResponse["data"] = jsonDecode(response.body)['data']['findTeamRequestByID'];

      return findTeamRequestResponse;
    } catch (e) {
      print("error in findEventRequest");
      return findTeamRequestResponse;
    }        
  }

  Future<Map<String, dynamic>> updateFriendRequest(Map<String, dynamic> friendRequestInput  ) async{
    print("updateFriendRequest");
    Map<String, dynamic> updateFriendRequestResponse = {"success": false, "message": "Default Error", "data": null};
    try {         
      print("user id before updateFriendRequest: ");
      print(appModel.currentUser['_id']);          
      friendRequestInput['acceptedBy_id'] = appModel.currentUser['_id'];          
      print("friendRequestInput: ");
      print(friendRequestInput);             
      
      //create friend relationship
      http.Response response = await http.post(
        Uri.parse('https://graphql.fauna.com/graphql'),
        headers: <String, String>{
          'Authorization': 'Bearer '+ dotenv.env['FAUNADBSECRET'].toString(),
          'Content-Type': 'application/json'
        },
        body: jsonEncode(<String, String>{
          'query': UserMutations().updateFriendRequest(friendRequestInput),//(fromInput, toInputs, gameInput),
        }),
      );
      print("response body: ");
      print(jsonDecode(response.body));

      Map<String, dynamic> userInput = {
        "_id": appModel.currentUser['_id'],
      };
      Map<String, dynamic> friendInput = {
        "_id": friendRequestInput['sender']['_id'],
      };      
      Map<String, dynamic> createUserLink = await UserCommand().addFriend(userInput, friendInput);
      print("createUserLink: " + createUserLink.toString());
      if(createUserLink['success']){
        //add friend
        dynamic newFriend = createUserLink['data']['user'];
        appModel.currentUser['friends'].add(newFriend);
        //get sender information for push notification
        Map<String, dynamic> findFriendRequestResp = await findFriendRequest(friendRequestInput);   
        print("findFriendRequestResp: " + findFriendRequestResp.toString());  
        if(findFriendRequestResp['success'] == true){
          // prepare notification data
          print("prepare notification data");
          Map<String, dynamic> sender = findFriendRequestResp['data']['sender'];
          print("sender: "+ sender.toString());
          List<String> phones = [sender['phone']];
          List<String> OSPIDs = [sender['OSPID']];
          Map<String, dynamic> sendSenderRequestNotificationInput = {
            "phones": phones,
            "message": appModel.currentUser['name'] + " has accepted your friend request",
            "OSPIDs": OSPIDs
          };
          await NotificationsCommand().sendAcceptedRequestNotification(sendSenderRequestNotificationInput);
        } 

      }




    


            
      updateFriendRequestResponse["success"] = true;
      updateFriendRequestResponse["message"] = "Event Request Created";      
      updateFriendRequestResponse["data"] = jsonDecode(response.body)['data']['updateEventRequest'];          
    } catch (e) {}

    return updateFriendRequestResponse;

  }

  Map<String, dynamic> updateEventRequestsModel(List eventRequests){
    print("updateEventRequestsModel");
    print(eventRequests);
    Map<String, dynamic> updateEventRequestsModelResp = {
      "success": false,
      "message": "Default Error",
      "data": null
    };

    print("updateEventRequestsModel eventRequests to set: ");
    print(eventRequests);
    print("updateEventRequestsModel before set eventRequests");
    print(requestsModel.eventRequests);
    requestsModel.eventRequests = eventRequests;
    // requestsPageModel.selectedObjects = eventRequests;
    print("updateEventRequestsModel after set eventRequests");
    print(requestsModel.eventRequests);

    updateEventRequestsModelResp["success"] = true;

    return updateEventRequestsModelResp;

  }

  Map<String, dynamic> updateRequestsPageSelectedModel(List requests){
    print("updateRequestsPageSelectedModel()");
    print("requests: "+ requests.toString());
    Map<String, dynamic> updateRequestsPageSelectedModelResp = {
      "success": false,
      "message": "Default Error",
      "data": null
    };

    print("selectedObjects before set: "+ requestsPageModel.selectedObjects.toString());
    requestsPageModel.selectedObjects = requests;
    print("selectedObjects after set: "+ requestsPageModel.selectedObjects.toString());
    
    updateRequestsPageSelectedModelResp["success"] = true;
    updateRequestsPageSelectedModelResp["message"] = "requestsPageModel.selectedObjects updated";
    updateRequestsPageSelectedModelResp["data"] = requestsPageModel.selectedObjects;

    return updateRequestsPageSelectedModelResp;
  }
  Map<String, dynamic> updateTeamRequestsModel(List teamRequests, String requestType){
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
      if(requestType=="RECIEVED"){
        if(teamRequests['sender']['_id'] != appModel.currentUser['_id']){
          teamRequestsToShow.add(teamRequests);
        }

      }
      else{
        if(teamRequests['sender']['_id'] == appModel.currentUser['_id']){
          teamRequestsToShow.add(teamRequests);
        }
      }
    });
    requestsModel.teamRequests = teamRequestsToShow;
    // requestsPageModel.selectedObjects = eventRequests;    
    print("updated requestsModel.teamRequests: "+requestsModel.teamRequests.toString());

    updateTeamRequestsModelResp["success"] = true;
    updateTeamRequestsModelResp['data'] = requestsModel.teamRequests;



    return updateTeamRequestsModelResp;

  }
  
  Map<String, dynamic> updateFriendRequestsModel(List friendRequests){
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

  void initialConditionsMet(){
    requestsPageModel.initialConditionsMet = true;
  }
  
}
