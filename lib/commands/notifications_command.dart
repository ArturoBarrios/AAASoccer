import 'dart:convert';
import 'base_command.dart';
import 'package:amplify_api/amplify_api.dart';
import '../models/Location.dart';
import '../services/twilio_services.dart';
import '../services/onesignal_service.dart';
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

      await TwilioServices().SendSMS(sendOrganizerRequestNotificationInput['phones'], sendOrganizerRequestNotificationInput['message']);
      await OneSignalService().sendPN(sendOrganizerRequestNotificationInput);

      receiveRequestNotificationResponse["success"] = true;
      receiveRequestNotificationResponse["message"] = "Notification Sent!";      
 
  
      return receiveRequestNotificationResponse;    
    } on ApiException catch (e) {
      print('Mutation failed: $e');
      return receiveRequestNotificationResponse;
    }
  }

 Future<Map<String, dynamic>> sendAcceptedRequestNotification(Map<String, dynamic> sendOrganizerRequestNotificationInput ) async{
     print("sendAcceptedRequestNotification");
    Map<String, dynamic> sendAcceptedRequestNotificationResponse = {"success": false, "message": "Default Error", "data": null};
    try {
      print("sendAcceptedRequestNotificationInput: $sendOrganizerRequestNotificationInput");
      await TwilioServices().SendSMS(sendOrganizerRequestNotificationInput['phones'], sendOrganizerRequestNotificationInput['message']);
      await OneSignalService().sendPN(sendOrganizerRequestNotificationInput);

      sendAcceptedRequestNotificationResponse["success"] = true;
      sendAcceptedRequestNotificationResponse["message"] = "Notification Sent!";      
 
  
      return sendAcceptedRequestNotificationResponse;    
    } on ApiException catch (e) {
      print('Mutation failed: $e');
      return sendAcceptedRequestNotificationResponse;
    }
  }

  

 

}