import 'package:soccermadeeasy/commands/base_command.dart';
import 'package:soccermadeeasy/models/app_model.dart';

import '../amplifyconfiguration.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_authenticator/amplify_authenticator.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_api/amplify_api.dart';
import '../models/ModelProvider.dart';
import '../commands/user_command.dart';
import 'package:amplify_datastore/amplify_datastore.dart';
import '../models/user_model.dart';
import 'package:twilio_flutter/twilio_flutter.dart'; 
import 'package:flutter_dotenv/flutter_dotenv.dart';


class TwilioServices extends BaseCommand {

  Future<Map<String, dynamic>> configureTwilio() async {
    print("configureTwilio");
    Map<String, dynamic> configureTwilioResp = {"success": false, "message": "Default Error"};
    TwilioFlutter twilioFlutter; 
    twilioFlutter = TwilioFlutter(
    accountSid : dotenv.env['TWILIOSID'].toString(),
    authToken : dotenv.env['TWILIOAUTHTOKEN'].toString(),
    twilioNumber : dotenv.env['TWILIOPHONE'].toString()
    );
    try {
      // Add the following line to add Auth plugin to your app.
      
    
        configureTwilioResp["success"] =  true;
        configureTwilioResp["message"] = "Twilio Configured";   
        
        
      
        appModel.twilioClient = twilioFlutter;

        print("appModel.twilioClient value");
        print(appModel.twilioClient);

        SendSMS("12672136006", "Hello World!");
        

      
      
    } on Exception catch (e) {
      print('An error occurred configuring Amplify: $e');
    }

    return configureTwilioResp;
  }

  void SendSMS(String phoneNumber, String message){
    appModel.twilioClient.sendSMS(
      toNumber : phoneNumber, 
      messageBody : message); 
  }


}
