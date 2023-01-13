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
import 'package:onesignal_flutter/onesignal_flutter.dart';

class OneSignalService extends BaseCommand {

  Future<Map<String, dynamic>> configureOneSignalUserDetails() async {
    print("configureOneSignalUserDetails");
    Map<String, dynamic> configureOneSignalUserDetailsResp = {"success": false, "message": "Default Error"};
    
    try {
      // Add the following line to add Auth plugin to your app.
      // Pass in email provided by customer
      OneSignal.shared.setEmail(email: appModel.currentUser['email']);
      print("phone number to set: "+appModel.currentUser['phone']);
      // Pass in phone number provided by customer
      OneSignal.shared.setSMSNumber(smsNumber: "1"+appModel.currentUser['phone']);
      OneSignal.shared.sendTag("name", appModel.currentUser['name'] );

      Map<String, dynamic> updateUserOSPIDResp = await updateUserOSPID();    
        appModel.onesignalUserDetailsSetup = true;

      
        configureOneSignalUserDetailsResp["success"] =  true;
        configureOneSignalUserDetailsResp["message"] = "Twilio Configured";   
        

      
      
    } on Exception catch (e) {
      print('An error occurred in configureOneSignalUserDetailsResp() : $e');
    }

    return configureOneSignalUserDetailsResp;
  }

  void sendPN() async {
    // var deviceState = await OneSignal.shared.getDeviceState();

    // if (deviceState == null || deviceState.userId == null){
    //   print("if (deviceState == null || deviceState.userId == null)");
    //   return;
    // }

    var playerId = appModel.currentUser['OSPID']!;

    var imgUrlString =
        "http://cdn1-www.dogtime.com/assets/uploads/gallery/30-impossibly-cute-puppies/impossibly-cute-puppy-2.jpg";

    var notification = OSCreateNotification(
        playerIds: [playerId],
        content: "Penis has sent you a request for event E",
        heading: "Test Notification",
        iosAttachments: {"id1": imgUrlString},
        bigPicture: imgUrlString,
        buttons: [
          OSActionButton(text: "test1", id: "id1"),
          OSActionButton(text: "test2", id: "id2")
        ]);

    var response = await OneSignal.shared.postNotification(notification);

    
  }


  

  


}
