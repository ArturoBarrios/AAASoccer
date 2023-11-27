import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:soccermadeeasy/extensions/parse_roles.dart';
import 'package:soccermadeeasy/graphql/fragments/user_fragments.dart';

import '../components/Dialogues/rating_dialogue.dart';
import '../graphql/mutations/ratings.dart';
import '../graphql/queries/users.dart';
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
  Future<Map<String, dynamic>> createRatingCategory() async {
    Map<String, dynamic> createRatingCategoryResp = {
      "success": false,
      "message": "Failed to create rating category"
    };

    try {
      return createRatingCategoryResp;
    } catch (e) {
      print("Error creating rating category: $e");
      return createRatingCategoryResp;
    }
  }

  Future<void> showRating(BuildContext context) async {
    print("showRating");
    bool showRatingRes = false;
    Map<String, dynamic> showRatingForEventResp = await showRatingForEvents();
    print("showRatingForEventResp: " + showRatingForEventResp.toString());
    if (showRatingForEventResp['success']) {
      showRatingRes = showRatingForEventResp['data']['showRating'];
      if (showRatingRes) {
        dynamic ratingInput = {
          "eventId": showRatingForEventResp['data']['eventId'],
          "userId": showRatingForEventResp['data']['userId'],
          "fieldLocationId": showRatingForEventResp['data']['fieldLocationId']
        };
        showRatingDialog(context, ratingInput);
        BaseCommand().updateIsRatingDialogueShowing(true);
      }
    }
  }

  Future<void> showRatingDialog(
      BuildContext context, dynamic ratingInput ) async {
    print("ensure single callback");
    return showDialog<void>(
      context: context,
      barrierDismissible:
          true, // set to false if you do not want to dismiss the dialog by tapping outside it
      builder: (BuildContext context) {
        return RatingDialogue(ratingInput: ratingInput); // Replace with your actual RatingWidget
      },
    );
  }

  Future<Map<String, dynamic>> createRatingForEvent(
      dynamic eventRatingInput) async {
    print("createRatingForEvent");
    Map<String, dynamic> createRatingForEventResp = {
      "success": false,
      "message": "Failed to create rating category",
      "data": 5
    };
    try {
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

      dynamic result = jsonDecode(response.body)['data']['createEventRating'];      

      createRatingForEventResp["success"] = true;
      createRatingForEventResp["message"] = "Rating for Event Created";
      createRatingForEventResp["data"] = result;

      return createRatingForEventResp;
    } catch (e) {
      print("Error creating rating category: $e");
      return createRatingForEventResp;
    }
  }

  // get user events, see if any are in the past [2-24] hours
  // if any have not been rated
  Future<Map<String, dynamic>> showRatingForEvents() async {
    print("showRatingForEvents");
    Map<String, dynamic> showRatingForEventResp = {
      "success": true,
      "message": "Failed to determine if should show rating",
      "data": {"showRating": false, 
        "eventId": "", 
        "fieldLocationId": "",
        "userId": ""
        }
    };
    try {
      
      

      for (int i = 0; i < appModel.myArchivedEvents.length; i++) {
        dynamic event = appModel.myArchivedEvents[i]['event'];
        print("eventUserParticipant id: " + appModel.myArchivedEvents[i]['_id'].toString());
        print("eventttttttt: "+event.toString());
        print("eventttttttt endtime: "+event['endTime'].toString());
        bool userRatingFound = false;
        int j = 0;
        //check if rating already exists
        while (j < event['eventRatings'].length &&
            !userRatingFound) {
          if (event['eventRatings'][j]['user']['_id'] ==
              appModel.currentUser['_id']) {
            userRatingFound = true;
          }
            }
          //check if user participation is PLAYER
          //&& event has happened in past [2-24 hours]
          if (!userRatingFound) {
            print("user rating not found");
            if (appModel.myArchivedEvents[i]['roles']
                .toString()
                .parseRoles()
                .contains('PLAYER')) {
              String millisecondsEndtime =
                  appModel.myArchivedEvents[i]['event']['endTime'].toString();
              DateTime endDateTime =
                  BaseCommand().dateTimeFromMilliseconds(millisecondsEndtime);
              if (endDateTime
                      .isBefore(DateTime.now().subtract(Duration(hours: 2))) &&
                  endDateTime
                      .isAfter(DateTime.now().subtract(Duration(hours: 24)))) {
                        print("fieldLocations test: "+ event['fieldLocations'].toString());
                showRatingForEventResp['data']['showRating'] = true;
                showRatingForEventResp['data']['eventId'] = event['_id'];
                showRatingForEventResp['data']['userId'] = appModel.currentUser['_id'];
                showRatingForEventResp['data']['fieldLocationId'] = event['fieldLocations']['data'][0]['_id'];
              }
            }
          }
        
      }

      return showRatingForEventResp;
    } catch (e) {
      print("Error creating rating category: $e");
      return showRatingForEventResp;
    }
  }

  Future<Map<String, dynamic>> calculateRatingForEvent() async {
    Map<String, dynamic> showRatingForEventResp = {
      "success": false,
      "message": "Failed to create rating category",
      "data": 5
    };
    try {
      return showRatingForEventResp;
    } catch (e) {
      print("Error creating rating category: $e");
      return showRatingForEventResp;
    }
  }

  Future<Map<String, dynamic>> calculateRatingForGroup() async {
    Map<String, dynamic> showRatingForEventResp = {
      "success": false,
      "message": "Failed to create rating category",
      "data": 5
    };
    try {
      return showRatingForEventResp;
    } catch (e) {
      print("Error creating rating category: $e");
      return showRatingForEventResp;
    }
  }

  Future<Map<String, dynamic>> calculateRatingForHost() async {
    Map<String, dynamic> showRatingForEventResp = {
      "success": false,
      "message": "Failed to create rating category"
    };
    try {
      return showRatingForEventResp;
    } catch (e) {
      print("Error creating rating category: $e");
      return showRatingForEventResp;
    }
  }
}
