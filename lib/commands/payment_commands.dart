import 'dart:convert';
import 'base_command.dart';
import 'package:amplify_api/amplify_api.dart';
import '../models/Training.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import '../commands/event_command.dart';
import 'package:faunadb_http/faunadb_http.dart';
import 'package:faunadb_http/query.dart';
import '../models/app_model.dart';
import '../graphql/mutations/training.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:geolocator/geolocator.dart';
import '../commands/geolocation_command.dart';
import '../enums/PaymentType.dart';
import '../graphql/queries/trainings.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import '../blocs/payment/payment_bloc.dart';

class PaymentCommand extends BaseCommand {
  
  Future<Map<String, dynamic>> createPaymentIntent(
    PaymentCreateIntent event,

  ) async{
      print("createPaymentIntent");
      print("event: " + event.toString());
    Map<String, dynamic> createPaymentIntentResp = {"success": false, "message": "Default Error", "data": null};
    try{
      paymentModel.status = PaymentType.loading;
      final paymentMethod = await Stripe.instance.createPaymentMethod(
        params: PaymentMethodParams.card(
            paymentMethodData: 
              PaymentMethodData(billingDetails: event.billingDetails),
        ),
      );

      final paymentIntentResults = await _callPayEndpointMethodId(
        useStripeSdk: true,
        paymentMethodId: paymentMethod.id,
        currency: 'usd', 
        items: event.items,
      );
      print("paymentIntentResults: " + paymentIntentResults.toString());


      if(paymentIntentResults['error'] != null) {
        paymentModel.status = PaymentType.failure;        
      }

      if(paymentIntentResults['clientSecret'] != null &&
        paymentIntentResults['requiresAction'] == null){
        paymentModel.status = PaymentType.success;                
      }

      if(paymentIntentResults['clientSecret'] != null &&
      paymentIntentResults['requiresAction'] == true){
        final String clientSecret = paymentIntentResults['clientSecret'];
        PaymentConfirmIntent(clientSecret: clientSecret);        
      }

      createPaymentIntentResp["success"] = true;
      createPaymentIntentResp["message"] = "Payment Intent Created";
      // createPaymentIntentResp["data"] = result;
      
    } on Exception catch (e) {
      print('Mutation failed: $e');  
    }

    return createPaymentIntentResp;

  }
 

  Future<Map<String, dynamic>> _callPayEndpointMethodId({
    required bool useStripeSdk,
    required String paymentMethodId,
    required String currency,
    List<Map<String, dynamic>>? items,
  }) async {
    try{
      print("callPayEndpointMethodId");
      print("usesStripeSdk: " + useStripeSdk.toString());
      print("paymentMethodId: " + paymentMethodId);
      print("currency: " + currency);
      print("items: " + items.toString());
      final url = Uri.parse("https://us-central1-soccer-app-a9060.cloudfunctions.net/stripePaymentIntentRequest");
      // final response = await http.post(
      //   url,
      //   headers: {'Content-Type': 'application/json'},
      //   body: 
      //     {
      //       'useStripeSdk': useStripeSdk,
      //       'paymentMethodId': paymentMethodId,
      //       'currency': currency,
      //       'items': items,
      //     }
        
      // );
      final response = await http.post(
        Uri.parse(
            'https://us-central1-soccer-app-a9060.cloudfunctions.net/stripePaymentIntentRequest'),
        body: {
         'email': "a@a.com",
          'amount': "1000",
        });
      print("return value: "+ response.toString());
      return json.decode(response.body);

    } on FormatException catch(e) {
      print("error: " + e.toString());
      return {};
    }
  }


}
