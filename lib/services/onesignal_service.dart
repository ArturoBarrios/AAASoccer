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

class OneSignalService  {
  Future<void> configureOneSignal() async{
    print("configureOneSignal");
    //Remove this method to stop OneSignal Debugging
    OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

    OneSignal.shared.setAppId("aeb22176-60a9-4077-b161-69381a79fa94");

    // The promptForPushNotificationsWithUserResponse function will show the iOS or Android push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
    OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
      print("Accepted permission: $accepted");
    });
  }
  

  Future<void> sendPN(Map<String, dynamic> pNInput) async {
    print("sendPNN");
    var deviceState = await OneSignal.shared.getDeviceState();
    print("OSPIDs: " + pNInput.toString());

    if (deviceState == null || deviceState.userId == null) {
      print("if (deviceState == null || deviceState.userId == null)");
      return;
    } else {
      print("go onnnn!");
    }

    var imgUrlString =
        "http://cdn1-www.dogtime.com/assets/uploads/gallery/30-impossibly-cute-puppies/impossibly-cute-puppy-2.jpg";

    var notification = OSCreateNotification(
        playerIds:
            pNInput['OSPIDs'], //["3a4086ef-4354-40d1-9573-41a3cc51ed83"],
        content: pNInput['message'],
        heading: "Hello World!",
        iosAttachments: {"id1": imgUrlString},
        bigPicture: imgUrlString,
        buttons: [
          OSActionButton(text: "test1", id: "id1"),
          OSActionButton(text: "test2", id: "id2")
        ]);

    // var response = await OneSignal.shared.postNotification(notification);
    // print("sendPN response: "+response.toString());
  }
}
