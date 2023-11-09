import 'dart:convert';
import '../graphql/mutations/ratings.dart';
import 'base_command.dart';
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:faunadb_http/faunadb_http.dart';
import 'package:faunadb_http/query.dart';
import '../models/pageModels/app_model.dart';
import 'package:http/http.dart' as http;
import '../graphql/mutations/locations.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:url_launcher/url_launcher.dart';


class RatingCommand extends BaseCommand {

  Future<Map<String,dynamic>> createRatingCategory()async {
    Map<String,dynamic> createRatingCategoryResp = {
      "success": false,
      "message": "Failed to create rating category"    
    };

    try{
      return createRatingCategoryResp;
    } catch (e) {
      print("Error creating rating category: $e");
      return createRatingCategoryResp;
    }

    
  }    
  
  Future<Map<String,dynamic>> createRatingForEvent(dynamic eventRatingInput)async {
    Map<String,dynamic> createRatingForEventResp = {
      "success": false,
      "message": "Failed to create rating category",
      "data": 5
    };
    try{
       http.Response response = await http.post(
        Uri.parse('https://graphql.fauna.com/graphql'),
        headers: <String, String>{
          'Authorization': 'Bearer ' + dotenv.env['FAUNADBSECRET'].toString(),
          'Content-Type': 'application/json'
        },
        body: jsonEncode(<String, String>{
          'query': RatingMutations().createEventRating(eventRatingInput),
        }),
      );

      print("response body: ");
      print(jsonDecode(response.body));

      dynamic result = jsonDecode(response.body)['data']['allGames']['data'];
      print("getGamesNearLocation length: " + result.length.toString());

      createRatingForEventResp["success"] = true;
      createRatingForEventResp["message"] = "Games Retrieved";
      createRatingForEventResp["data"] = result;
      

      return createRatingForEventResp;
    } catch (e) {
      print("Error creating rating category: $e");
      return createRatingForEventResp;
    }

    
  }

  Future<Map<String,dynamic>> showRatingForEvent()async {
    Map<String,dynamic> showRatingForEventResp = {
      "success": true,
      "message": "Failed to determine if should show rating",
      "data": true
    };
    try{
      
      

      return showRatingForEventResp;
    } catch (e) {
      print("Error creating rating category: $e");
      return showRatingForEventResp;
    }

    
  }
  
  Future<Map<String,dynamic>> calculateRatingForEvent()async {
    Map<String,dynamic> showRatingForEventResp = {
      "success": false,
      "message": "Failed to create rating category",
      "data": 5
    };
    try{


      return showRatingForEventResp;
    } catch (e) {
      print("Error creating rating category: $e");
      return showRatingForEventResp;
    }

    
  }
  
  Future<Map<String,dynamic>> calculateRatingForGroup()async {
    Map<String,dynamic> showRatingForEventResp = {
      "success": false,
      "message": "Failed to create rating category",
      "data": 5    
    };
    try{


      return showRatingForEventResp;
    } catch (e) {
      print("Error creating rating category: $e");
      return showRatingForEventResp;
    }

    
  }
  
  Future<Map<String,dynamic>> calculateRatingForHost()async {
    Map<String,dynamic> showRatingForEventResp = {
      "success": false,
      "message": "Failed to create rating category"    
    };
    try{


      return showRatingForEventResp;
    } catch (e) {
      print("Error creating rating category: $e");
      return showRatingForEventResp;
    }

    
  }


  

  

 

}