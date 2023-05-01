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
import 'package:flutter_stripe/flutter_stripe.dart'; 
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

class StripeServices {

  Future<void> configureStripeService() async{
    print("configureStripeService");
    print("set publishable key: "+dotenv.env['STRIPE_PUBLISHABLE_KEY']!);
    Stripe.publishableKey = dotenv.env['STRIPE_PUBLISHABLE_KEY']!;
    Stripe.merchantIdentifier = 'merchant.flutter.stripe.test';
    Stripe.urlScheme = 'flutterstripe';
    await Stripe.instance.applySettings();
    print("configureStripeService done");
  }


 




  

  


}
