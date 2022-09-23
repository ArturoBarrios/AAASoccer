import 'base_command.dart';
import 'package:amplify_api/amplify_api.dart';
import '../models/Event.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:faunadb_http/faunadb_http.dart';
import 'package:faunadb_http/query.dart';
import '../models/app_model.dart';
import 'package:http/http.dart' as http;
import '../graphql/mutations/events.dart';
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import './game_command.dart';

class EventCommand extends BaseCommand {

  

 Future<Map<String, dynamic>> createEvent(Map<String, dynamic> eventInput ) async{
     print("createEvent");
    Map<String, dynamic> createEventResponse = {"success": false, "message": "Default Error", "data": null};
    try {
      final createDocument = Create(
        Collection('Event'),
        Obj({
          'data': {
            'name': eventInput['name'],
            'isMainEvent': eventInput['isMainEvent'],
            'location': eventInput['location']['resource']['ref']['@ref']['id']                          
            }
        }),
      );

      final result = null;//await AppModel().faunaClient.query(createDocument);
      print("result: ");
      print(result.toJson());
     
      createEventResponse["success"] = true;
      createEventResponse["message"] = "Event Created";
      createEventResponse["data"] = result;

      return createEventResponse;
    } on ApiException catch (e) {
      print('Mutation failed: $e');
      return createEventResponse;
    }
  }

   Future<Map<String, dynamic>> addPlayerToEvent(Map<String, dynamic> eventInput, Map<String, dynamic> playerInput ) async{
    print("addPlayerToEvent");
    Map<String, dynamic> addPlayerToEventResponse = {"success": false, "message": "Default Error", "data": null};
    
    http.Response response = await http.post(
        Uri.parse('https://graphql.fauna.com/graphql'),
        headers: <String, String>{
          'Authorization': 'Bearer '+ dotenv.env['FAUNADBSECRET'].toString(),
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
      addPlayerToEventResponse["data"] = jsonDecode(response.body)['data']['updateEvent'];

    return addPlayerToEventResponse;
  }

  Future<Map<String, dynamic>> getEvents() async{
    Map<String,dynamic> getEventsResp = {"success": false, "message": "Default Error", "data": []};
    try{
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
    }
    on Exception catch (e) {
      print('Mutation failed: $e');        
    }

    return getEventsResp;

  }

  Future<Map<String, dynamic>> getGames(bool pickup) async{
    Map<String,dynamic> getEventResp = {"success": false, "message": "Default Error", "data": []};
    try{
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
    }
    on Exception catch (e) {
      print('Mutation failed: $e');        
    }

    return getEventResp;

  }

  

 

}