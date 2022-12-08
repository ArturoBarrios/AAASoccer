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
import '../graphql/queries/requests.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../../commands/tournament_command.dart';

class RequestsCommand extends BaseCommand {

  Future<Map<String, dynamic>> getEventRequests() async {

    print("getRequests");
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

  Map<String, dynamic> acceptEventRequest(dynamic eventRequest){
    print("acceptEventRequest");
    print(eventRequest);
    Map<String, dynamic> acceptEventRequestResp = {
      "success": false,
      "message": "Default Error",
      "data": null
    };
    

    return acceptEventRequestResp;

  }


  Map<String, dynamic> updateEventRequestModels(List eventRequests){
    print("UpdateEventRequestModels");
    print(eventRequests);
    Map<String, dynamic> UpdateEventRequestModelsResp = {
      "success": false,
      "message": "Default Error",
      "data": null
    };

    print("UpdateEventRequestModels eventRequests to set: ");
    print(eventRequests);
    print("UpdateEventRequestModels before set eventRequests");
    print(requestsModel.eventRequests);
    requestsModel.eventRequests = eventRequests;
    requestsPageModel.selectedObjects = eventRequests;
    print("UpdateEventRequestModels after set eventRequests");
    print(requestsModel.eventRequests);

    UpdateEventRequestModelsResp["success"] = true;



    return UpdateEventRequestModelsResp;

  }

  void initialConditionsMet(){
    requestsPageModel.initialConditionsMet = true;
  }
  
}
