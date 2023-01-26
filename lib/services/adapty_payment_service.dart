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
import 'package:adapty_flutter/adapty_flutter.dart';


class AdaptyPaymentService extends BaseCommand {

  Future<Map<String, dynamic>> configureAdapty() async {
    print("configureAdapty");
    Map<String, dynamic> configureAdaptyResp = {"success": false, "message": "Default Error"};
   
    try {
      Adapty().activate();
      Adapty().setLogLevel(AdaptyLogLevel.verbose);
      print("adapty set!!!!");
      
      configureAdaptyResp["success"] =  true;
      configureAdaptyResp["message"] = "Adapty Configured";   
                                        
    } on Exception catch (e) {
      print('An error occurred configuring Amplify: $e');
    }

    return configureAdaptyResp;
  }

  Future<Map<String, dynamic>> makePurchase() async {
    Map<String, dynamic> makePurchaseResponse = {"success": false, "message": "Default Error"};
    try {
      print("get paywall");
      final paywall = await Adapty().getPaywall(id: "0714");
      print("paywall: " + paywall.toString());
      print("get products");
      final products = await Adapty().getPaywallProducts(paywall: paywall);
      print("products: " + products.toString());
      print("makePurchase");
      final profile = await Adapty().makePurchase(product: products[0]);
      print("profile: " + profile.toString());
        
      } on AdaptyError catch (adaptyError) {
          // handle the error
      } catch (e) {
        print("catch error: " + e.toString());
      }


    return makePurchaseResponse;

  }



  

  

  


}
