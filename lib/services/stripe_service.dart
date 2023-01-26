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
// import 'package:flutter_stripe/flutter_stripe.dart'; 
import 'package:flutter_dotenv/flutter_dotenv.dart';
// Pay Plugin support
// flutter_stripe fully supports the Pay 
//plugin from the Google Pay team. By including 
//a few lines you can integrate Stripe as a payment 
//processor for Google / Apple Pay:
// Future<void> onGooglePayResult(paymentResult) async {
//     final response = await fetchPaymentIntentClientSecret();
//     final clientSecret = response['clientSecret'];
//     final token = paymentResult['paymentMethodData']['tokenizationData']['token'];
//     final tokenJson = Map.castFrom(json.decode(token));

//     final params = PaymentMethodParams.cardFromToken(
//       token: tokenJson['id'],
//     );
//     // Confirm Google pay payment method
//     await Stripe.instance.confirmPayment(
//       clientSecret,
//       params,
//     );
// }

class StripeServices extends BaseCommand {

//   Future<void> initPaymentSheet() async {
//     try {
//       // 1. create payment intent on the server
//       final data = await _createTestPaymentSheet();

//       // 2. initialize the payment sheet
//      await Stripe.instance.initPaymentSheet(
//         paymentSheetParameters: SetupPaymentSheetParameters(
//           // Enable custom flow
//           customFlow: true,
//           // Main params
//           merchantDisplayName: 'Flutter Stripe Store Demo',
//           paymentIntentClientSecret: data['paymentIntent'],
//           // Customer keys
//           customerEphemeralKeySecret: data['ephemeralKey'],
//           customerId: data['customer'],
//           // Extra options
//           testEnv: true,
//           applePay: true,
//           googlePay: true,
//           style: ThemeMode.dark,
//           merchantCountryCode: 'DE',
//         ),
//       );
//       setState(() {
//         _ready = true;
//       });
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error: $e')),
//       );
//       rethrow;
//     }
// }



  void createPaymentMethod() async {
    // final paymentMethod =
    //               await Stripe.instance.createPaymentMethod(PaymentMethodParams.card());
  }


  Future<Map<String, dynamic>> configureStripe() async {
    print("configureStripe");
    Map<String, dynamic> configureStripeResp = {"success": false, "message": "Default Error"};
    
    try {
      // Add the following line to add Auth plugin to your app.
      
    
        configureStripeResp["success"] =  true;
        configureStripeResp["message"] = "Stripe Configured";   
        
        
      
        

      
      
    } on Exception catch (e) {
      print('An error occurred configuring Amplify: $e');
    }

    return configureStripeResp;
  }

  

  


}
