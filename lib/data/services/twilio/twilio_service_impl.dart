// import 'package:soccermadeeasy/data/services/twilio/twilio_service.dart';
// import 'package:twilio_flutter/twilio_flutter.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';

// class TwilioServiceImpl implements TwilioService {
//   late final TwilioFlutter twilioFlutter;
//   @override
//   Future<void> init() async {
//     // twilioFlutter = TwilioFlutter(
//     //   accountSid: dotenv.env['TWILIOSID'] ?? '',
//     //   authToken: dotenv.env['TWILIOAUTHTOKEN'] ?? '',
//     //   twilioNumber: dotenv.env['TWILIOPHONE'] ?? '',
//     // );
//   }

//   @override
//   Future<bool> sendSMS(String toNumber, String message) async {
//     final response = await twilioFlutter.sendSMS(
//       toNumber: toNumber,
//       messageBody: message,
//     );
//     return response == 201;
//   }

//   @override
//   Future<bool> sendOTPSMS(String toNumber, String otp) async {
//     final otpText = 'Your OTP is $otp';
//     final response = await twilioFlutter.sendSMS(
//       toNumber: toNumber,
//       messageBody: otpText,
//     );
//     return response == 201;
//   }
// }
