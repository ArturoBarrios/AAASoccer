import 'dart:convert';
import 'base_command.dart';
import 'package:amplify_api/amplify_api.dart';
import '../models/Location.dart';
import '../services/twilio_services.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:faunadb_http/faunadb_http.dart';
import 'package:faunadb_http/query.dart';
import '../models/app_model.dart';
import 'package:http/http.dart' as http;
import '../graphql/mutations/locations.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class NotificationsCommand extends BaseCommand {

 Future<Map<String, dynamic>> sendOrganizerRequestNotification(Map<String, dynamic> sendOrganizerRequestNotificationInput ) async{
     print("sendOrganizerRequestNotification");
    Map<String, dynamic> receiveRequestNotificationResponse = {"success": false, "message": "Default Error", "data": null};
    try {

      TwilioServices().SendSMS(sendOrganizerRequestNotificationInput['phone'], sendOrganizerRequestNotificationInput['message']);


      receiveRequestNotificationResponse["success"] = true;
      receiveRequestNotificationResponse["message"] = "Notification Sent!";      
 
  
      return receiveRequestNotificationResponse;    
    } on ApiException catch (e) {
      print('Mutation failed: $e');
      return receiveRequestNotificationResponse;
    }
  }

  

 

}