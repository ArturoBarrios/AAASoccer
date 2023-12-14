import 'package:soccermadeeasy/data/services/twilio/twilio_service.dart';
import 'package:soccermadeeasy/di/di_init.dart';

import 'base_command.dart';
import 'package:amplify_api/amplify_api.dart';
import '../services/onesignal_service.dart';

class NotificationsCommand extends BaseCommand {
  Future<Map<String, dynamic>> sendUserParticipantsNotifications(
      Map<String, dynamic> sendUserParticipantsNotificationsInput) async {
    print("sendOrganizerRequestNotification");
    Map<String, dynamic> receiveRequestNotificationResponse = {
      "success": false,
      "message": "Default Error",
      "data": null
    };
    try {
      // await getIt.get<TwilioService>().sendSMS(
      //       sendUserParticipantsNotificationsInput['phones'],
      //       sendUserParticipantsNotificationsInput['message'],
      //     );
      await OneSignalService().sendPN(sendUserParticipantsNotificationsInput);

      receiveRequestNotificationResponse["success"] = true;
      receiveRequestNotificationResponse["message"] = "Notification Sent!";

      return receiveRequestNotificationResponse;
    } on ApiException catch (e) {
      print('Mutation failed: $e');
      return receiveRequestNotificationResponse;
    }
  }

  Future<Map<String, dynamic>> sendOrganizerRequestNotification(
      Map<String, dynamic> sendOrganizerRequestNotificationInput) async {
    print("sendOrganizerRequestNotification");
    Map<String, dynamic> receiveRequestNotificationResponse = {
      "success": false,
      "message": "Default Error",
      "data": null
    };
    try {
      // await getIt.get<TwilioService>().sendSMS(
      //       sendOrganizerRequestNotificationInput['phones'],
      //       sendOrganizerRequestNotificationInput['message'],
      //     );

      await OneSignalService().sendPN(sendOrganizerRequestNotificationInput);

      receiveRequestNotificationResponse["success"] = true;
      receiveRequestNotificationResponse["message"] = "Notification Sent!";

      return receiveRequestNotificationResponse;
    } on ApiException catch (e) {
      print('Mutation failed: $e');
      return receiveRequestNotificationResponse;
    }
  }

  Future<Map<String, dynamic>> sendAcceptedRequestNotification(
      Map<String, dynamic> sendOrganizerRequestNotificationInput) async {
    print("sendAcceptedRequestNotification");
    Map<String, dynamic> sendAcceptedRequestNotificationResponse = {
      "success": false,
      "message": "Default Error",
      "data": null
    };
    try {
      print(
          "sendAcceptedRequestNotificationInput: $sendOrganizerRequestNotificationInput");
      // await getIt.get<TwilioService>().sendSMS(
      //       sendOrganizerRequestNotificationInput['phones'],
      //       sendOrganizerRequestNotificationInput['message'],
      //     );
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
