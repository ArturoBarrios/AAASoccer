import 'dart:convert';
import 'dart:ffi';
import 'base_command.dart';
import 'package:faunadb_http/faunadb_http.dart';
import 'package:faunadb_http/query.dart';
import '../models/app_model.dart';
import '../commands/event_command.dart';
import '../models/events_model.dart';
import '../models/requests_page_model.dart';
import '../models/requests_model.dart';
import '../commands/geolocation_command.dart';
import 'package:geolocator/geolocator.dart';
import '../graphql/mutations/games.dart';
import '../graphql/mutations/users.dart';
import '../graphql/mutations/teams.dart';
import '../graphql/mutations/events.dart';
import '../graphql/queries/requests.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../../commands/tournament_command.dart';

class RequestsCommand extends BaseCommand {

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

  Future<Map<String, dynamic>> updateEventRequests(Map<String, dynamic> eventRequestInput  ) async{
    print("updateEventRequest");
    Map<String, dynamic> updateEventRequestResponse = {"success": false, "message": "Default Error", "data": null};
    try {         
      print("user id before updateEventRequest: ");
      print(appModel.currentUser['_id']);          
      eventRequestInput['acceptedBy_id'] = appModel.currentUser['_id'];          
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
          'query': EventMutations().updateEventRequest(eventRequestInput),//(fromInput, toInputs, gameInput),
        }),
      );
    
      print("response body: ");
      print(jsonDecode(response.body));
            
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
            
      updateTeamRequestsResponse["success"] = true;
      updateTeamRequestsResponse["message"] = "Event Request Created";      
      updateTeamRequestsResponse["data"] = jsonDecode(response.body)['data']['updateEventRequest'];          
    } catch (e) {}

    return updateTeamRequestsResponse;

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
    requestsPageModel.selectedObjects = eventRequests;
    print("updateEventRequestsModel after set eventRequests");
    print(requestsModel.eventRequests);

    updateEventRequestsModelResp["success"] = true;

    return updateEventRequestsModelResp;

  }

  Map<String, dynamic> updateTeamRequestsModel(List eventRequests){
    print("updateTeamRequestsModel");
    print(eventRequests);
    Map<String, dynamic> updateTeamRequestsModelResp = {
      "success": false,
      "message": "Default Error",
      "data": null
    };

    print("updateTeamRequestsModel eventRequests to set: ");
    print(eventRequests);
    print("updateTeamRequestsModel before set eventRequests");
    print(requestsModel.eventRequests);
    requestsModel.eventRequests = eventRequests;
    requestsPageModel.selectedObjects = eventRequests;
    print("updateTeamRequestsModel after set eventRequests");
    print(requestsModel.eventRequests);

    updateTeamRequestsModelResp["success"] = true;



    return updateTeamRequestsModelResp;

  }

  void initialConditionsMet(){
    requestsPageModel.initialConditionsMet = true;
  }
  
}
