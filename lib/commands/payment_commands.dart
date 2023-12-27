import 'dart:convert';
import 'dart:developer';

import '../constants.dart';
import '../graphql/mutations/prices.dart';
import '../graphql/mutations/users.dart';
import 'base_command.dart';
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import '../commands/event_command.dart';


import '../models/pageModels/app_model.dart';
import '../graphql/mutations/training.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:geolocator/geolocator.dart';
import '../commands/geolocation_command.dart';
import '../commands/user_command.dart';
import '../models/enums/payment_status_type.dart';
import '../graphql/queries/trainings.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import '../blocs/payment/payment_bloc.dart';

class PaymentCommand extends BaseCommand {

  Future<Map<String, dynamic>> getCustomerPaymentMethods() async {
    print("getCustomerPaymentMethods");
    print(
        "appModel.currentUser['stripeCustomers']: ${appModel.currentUser['stripeCustomers']}");
    Map<String, dynamic> getCustomerPaymentMethodsResultResp = {
      "success": false,
      "message": "Default Error",
      "data": null
    };
    if (appModel.currentUser['stripeCustomers'].length == 0) {
      return getCustomerPaymentMethodsResultResp;
    }
    try {
      Map<String, String> queryParams = {
        'customerId': appModel.currentUser['stripeCustomers'][0]
                ['customerId']
            .toString(),
      };
      final uri = Uri.https("us-central1-soccer-app-a9060.cloudfunctions.net",
          '/listPaymentMethods', queryParams);

      dynamic listPaymentMethodsResp = await http.get(uri);
      listPaymentMethodsResp = json.decode(listPaymentMethodsResp.body);
      print("response: $listPaymentMethodsResp");
      if (listPaymentMethodsResp['success']) {
        print(
            "listPaymentMethodsResp['paymentMethods']: ${listPaymentMethodsResp['paymentMethods']}");
        dynamic listPaymentMethods =
            listPaymentMethodsResp['paymentMethods'];
        if (listPaymentMethods.length > 0) {
          getCustomerPaymentMethodsResultResp['success'] = true;
          getCustomerPaymentMethodsResultResp['message'] = "Success";
          getCustomerPaymentMethodsResultResp['data'] = listPaymentMethods['data'];
        }
      } else {
        getCustomerPaymentMethodsResultResp['success'] = true;
        getCustomerPaymentMethodsResultResp['message'] =
            "Something wrong happened";
        getCustomerPaymentMethodsResultResp['data'] = [];
      }

      return getCustomerPaymentMethodsResultResp;
    } catch (e) {
      print("getCustomerPaymentMethods error: $e");
      getCustomerPaymentMethodsResultResp['message'] = e.toString();
      return getCustomerPaymentMethodsResultResp;
    }
  }

  Future<Map<String, dynamic>> getCustomerDetails() async {
    print("getCustomerDetailssss");
    print(
        "appModel.currentUser['stripeCustomers'][0]['customerId']: ${appModel.currentUser['stripeCustomers'][0]['customerId']}");
    Map<String, dynamic> getCustomersResp = {
      "success": false,
      "message": "Default Error",
      "data": null
    };

    try {
      Map<String, String> queryParams = {
        'customerId': appModel.currentUser['stripeCustomers'][0]
                ['customerId']
            .toString(),
      };
      final uri = Uri.https('us-central1-soccer-app-a9060.cloudfunctions.net',
          '/getCustomerDetails', queryParams);
      final getCustomerResult = await http.get(uri);
      print("response: ${json.decode(getCustomerResult.body)}");
      return json.decode(getCustomerResult.body);
    } catch (e) {
      print("getCustomers error: $e");
      getCustomersResp['message'] = e.toString();
      return getCustomersResp;
    }
  }

  Future<Map<String, dynamic>> createPaymentMethod(
      dynamic createPaymentMethodInput) async {
    print("createPaymentMethod");
    print("createPaymentMethodInput: $createPaymentMethodInput");
    Map<String, dynamic> createPaymentMethodResp = {
      "success": false,
      "message": "Default Error",
      "data": null
    };

    try{
      Map<String, dynamic> createPaymentMethodResult = await _callStripeCreatePaymentMethod(createPaymentMethodInput);
      print("createPaymentMethodResult: $createPaymentMethodResult");
      if(createPaymentMethodResult['success']){
        createPaymentMethodResp['success'] = true;
        createPaymentMethodResp['message'] = "Customer Created";
        createPaymentMethodResp['data'] = createPaymentMethodResult['data'];
      }
      return createPaymentMethodResp;
    } on Exception catch (e) {
      print('Mutation failed: $e');
      return createPaymentMethodResp;
    }
  }

  Future<Map<String, dynamic>> createCustomer(
      dynamic createCustomerInput) async {
    print("createCustomer");
    print("createCustomerInput: $createCustomerInput");
    Map<String, dynamic> createCustomerResp = {
      "success": false,
      "message": "Default Error",
      "data": null
    };

    try{
      Map<String, dynamic> createCustomerResult = await _callStripeCreateCustomer(createCustomerInput);
      print("createCustomerResult: $createCustomerResult");
      if(createCustomerResult['success']){
        createCustomerResp['success'] = true;
        createCustomerResp['message'] = "Customer Created";
        createCustomerResp['data'] = createCustomerResult['data'];
      }
      return createCustomerResp;
    } on Exception catch (e) {
      print('Mutation failed: $e');
      return createCustomerResp;
    }
  }

  Future<Map<String, dynamic>> detachPaymentIntent(
      dynamic detachPaymentIntentInput) async {
      
      print("detachPaymentIntent");
      print("detachPaymentIntentInput: $detachPaymentIntentInput");
      Map<String, dynamic> detachPaymentIntentResp = {
        "success": false,
        "message": "Default Error",
        "data": null
      };

      try{
        Map<String, dynamic> detachPaymentIntentResult = await _callStripeDetachPaymentMethod(detachPaymentIntentInput);
        print("detachPaymentIntentResult: $detachPaymentIntentResult");
        if(detachPaymentIntentResult['success']){
          detachPaymentIntentResp['success'] = true;
          detachPaymentIntentResp['message'] = "Payment Intent Detached";
          detachPaymentIntentResp['data'] = detachPaymentIntentResult['data'];
        }
        return detachPaymentIntentResp;
     
      } on Exception catch (e) {
        print('Mutation failed: $e');
        return detachPaymentIntentResp;
      }
  }
  Future<Map<String, dynamic>> createPaymentIntent(
      dynamic createPaymentIntentInput) async {
    print("createPaymentIntent");
    print("createPaymentIntentInput: $createPaymentIntentInput");
    Map<String, dynamic> createPaymentIntentResp = {
      "success": false,
      "message": "Default Error",
      "data": null
    };

    try {
      String paymentMethodId = "";
      PaymentCreateIntent paymentEvent =
          createPaymentIntentInput['paymentCreateIntent'];

      if (createPaymentIntentInput['paymentMethodId'] != null) {
        print("createPaymentIntentInput['paymentMethod']: " +
            createPaymentIntentInput['paymentMethodId']);
        paymentMethodId = createPaymentIntentInput['paymentMethodId'];
      } else {
        paymentModel.status = PaymentStatusType.loading;
        final paymentMethod = await Stripe.instance.createPaymentMethod(
          params: PaymentMethodParams.card(
            paymentMethodData:
                PaymentMethodData(billingDetails: paymentEvent.billingDetails),
          ),
        );
        print("paymentMethod: $paymentMethod");

        paymentMethodId = paymentMethod.id;
      }
      dynamic price = createPaymentIntentInput['price'];

      final paymentIntentResults = await _callPayEndpointMethodId(
          useStripeSdk: true,
          paymentMethodId: paymentMethodId,
          currency: 'usd',
          items: paymentEvent.items,
          priceInput: price['amount']);
      print("paymentIntentResults: $paymentIntentResults");
      print(
          "paymentIntentResults['customer']: ${paymentIntentResults['customer']}");
      print(
          "paymentIntentResults['intent']: ${paymentIntentResults['intent']}");

      //attach payment method to customer
      if (paymentIntentResults['success'] &&
          paymentIntentResults['customer'] != null) {
        print("attach payment method to customer");
        createPaymentIntentResp['data'] = {"intent": paymentIntentResults['intent']};
        Map<String, dynamic> attachPaymentMethodToCustomerResp =
            await _callStripeAttachPaymentMethod(
                paymentMethodId: paymentMethodId,
                customerId: paymentIntentResults['customer']);
        print(
            "attachPaymentMethodToCustomerResp: $attachPaymentMethodToCustomerResp");
      }

      if (paymentIntentResults['error'] != null) {
        paymentModel.status = PaymentStatusType.failure;
      }
      print(
          "paymentIntentResults['requiresAction']: ${paymentIntentResults['requiresAction']}");
      print(
          "paymentIntentResults['clientSecret']: ${paymentIntentResults['clientSecret']}");
      if (paymentIntentResults['clientSecret'] != null &&
          paymentIntentResults['requiresAction'] == null) {
        print("doesn't requires action!");
        paymentModel.status = PaymentStatusType.success;
      }

      if (paymentIntentResults['clientSecret'] != null &&
          paymentIntentResults['requiresAction'] == true) {
        print("requires action!");
        final String clientSecret = paymentIntentResults['clientSecret'];
        _onPaymentConfirmIntentId(clientSecret);
      }

      //create Payment and StripeCustomer objects
      if (paymentIntentResults['success'] &&
          paymentIntentResults['customer'] != null) {
        //

        // _onPaymentConfirmIntent(event)
        Map<String, dynamic> userInput = {
          '_id': appModel.currentUser['_id'],
        };

        Map<String, dynamic> stripeCustomerInput = {
          'customerId': paymentIntentResults['customer'],
          'ephemeralKey': paymentIntentResults['ephemeralKey'],
        };
        print("check if customer exists: ${paymentIntentResults['customer']}");
        if (!doesCustomerExist(paymentIntentResults['customer'])) {
          print("customer does not exist, creating customer");
          Map<String, dynamic> createUserCustomerResp = await UserCommand()
              .createUserCustomer(userInput, stripeCustomerInput);
          print("createUserCustomerResp: $createUserCustomerResp");
        }
      }

      createPaymentIntentResp["success"] = true;
      createPaymentIntentResp["message"] = "Payment Intent Created";
      // createPaymentIntentResp["data"] = result;
    } on Exception catch (e) {
      print('Mutation failed: $e');
    }

    return createPaymentIntentResp;
  }

  Future<Map<String, dynamic>> createUserObjectPayment(
      dynamic createUserObjectPaymentInput) async {
    Map<String, dynamic> createUserObjectPaymentResp = {
      "success": false,
      "message": "Default Error",
      "data": null
    };
    print("createUserObjectPaymentInput: $createUserObjectPaymentInput");

    try {
      http.Response response = await http.post(
        Uri.parse(dotenv.env['APOLLO_SERVER'].toString()),
        headers: <String, String>{          
          'Content-Type': 'application/json'
        },
        body: jsonEncode(<String, String>{
          'query': UserMutations()
              .createUserEventPayment(createUserObjectPaymentInput),
        }),
      );

      print("createUserEventPayment response: ${response.body}");

      if(response.statusCode == 200){
        final result = jsonDecode(response.body)['data']['createPayment'];
        if(result['success']){
          createUserObjectPaymentResp['success'] = true;
          createUserObjectPaymentResp['message'] = "Payment Created";
          createUserObjectPaymentResp['data'] = result['payment'];
        }
      }

      return createUserObjectPaymentResp;
    } catch (e) {
      print('Mutation failed: $e');
      return createUserObjectPaymentResp;
    }
  }

  bool doesCustomerExist(String customerId) {
    print("checkIfCustomerExists");
    print(
        "stripeCustomers length: ${appModel.currentUser['stripeCustomers'].length}");
    bool customerExists = false;
    dynamic customers = appModel.currentUser['stripeCustomers'];
    for (var i = 0; i < customers.length && !customerExists; i++) {
      if (customers[i]['customerId'] == customerId) {
        customerExists = true;
      }
    }

    return customerExists;
  }

  void _onPaymentConfirmIntentId(String clientSecret) async {
    try {
      final paymentIntent =
          await Stripe.instance.handleNextAction(clientSecret);

      if (paymentIntent.status == PaymentIntentsStatus.RequiresConfirmation) {
        Map<String, dynamic> results = await _callPayEndpointIntentId(
          paymentIntentId: paymentIntent.id,
        );
        if (results['error'] != null) {
        } else {}
      }
    } on Exception catch (e) {
      print('Mutation failed: $e');
    }
  }

  Future<Map<String, dynamic>> _callPayEndpointIntentId(
      {required String paymentIntentId}) async {
    final url = Uri.parse(
        "https://us-central1-soccer-app-a9060.cloudfunctions.net/StripePayEndpointIntentId");
    final response = await http.post(url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'paymentIntentId': paymentIntentId,
        }));
    return json.decode(response.body);
  }

  Future<Map<String, dynamic>> _callStripeDetachPaymentMethod(
    dynamic detachPaymentInput) async {
    try {
      print("callStripeDetachPaymentMethod: $detachPaymentInput");

      final response = await http.post(
          Uri.parse(
              'https://us-central1-soccer-app-a9060.cloudfunctions.net/detachPaymentMethod'),
          body: {
            'paymentMethodId': detachPaymentInput['paymentMethodId'],      
          });

      print("return value: $response");
      
      return json.decode(response.body);
    } on FormatException catch (e) {
      print("error: $e");
      return {};
    }
  }

  Future<Map<String, dynamic>> _callStripeCreatePaymentMethod(
    dynamic createPaymentInput) async {
    try {
      print("createPaymentInput: $createPaymentInput");

      final response = await http.post(
          Uri.parse(
              'https://us-central1-soccer-app-a9060.cloudfunctions.net/createPaymentMethod'),
          body: {
            'card_number': createPaymentInput['card_number'],
            'exp_month': createPaymentInput['exp_month'],
            'exp_year': createPaymentInput['exp_year'],
            'cvc': createPaymentInput['cvc'],            
          });

      print("return value: $response");
      
      return json.decode(response.body);
    } on FormatException catch (e) {
      print("error: $e");
      return {};
    }
  }
  
  Future<Map<String, dynamic>> _callStripeCreateCustomer(
      String email) async {
    try {
      print("createCustomerInput: $email");

      final response = await http.post(
          Uri.parse(
              'https://us-central1-soccer-app-a9060.cloudfunctions.net/createCustomer'),
          body: {
            'email': email,            
          });

      print("return value: $response");

      return json.decode(response.body);
    } on FormatException catch (e) {
      print("error: $e");
      return {};
    }
  }

  Future<Map<String, dynamic>> _callStripeAttachPaymentMethod(
      {required String paymentMethodId, required String customerId}) async {
    try {
      print("paymentMethodId: $paymentMethodId");

      final response = await http.post(
          Uri.parse(
              'https://us-central1-soccer-app-a9060.cloudfunctions.net/stripeAttachPaymentMethod'),
          body: {
            'paymentMethodId': paymentMethodId,
            'customerId': customerId,
          });

      print("return value: $response");

      return json.decode(response.body);
    } on FormatException catch (e) {
      print("error: $e");
      return {};
    }
  }

  Future<Map<String, dynamic>> createRefund(String charge) async {
    Map<String, dynamic> createRefundResp = {
      "success": false,
      "message": "Default Error",
      "data": null      
    };
    try {
      final response = await http.post(
          Uri.parse(
              'https://us-central1-soccer-app-a9060.cloudfunctions.net/StripeCreateRefund'),
          body: {'charge': charge});
      print("Response Status Code: ${response}");
      if(response.statusCode == 200){
        createRefundResp['success'] = true;
        
      }


      
      return createRefundResp;
    } catch (e) {      
      return createRefundResp;
    }
  }

  Future<Map<String, dynamic>> _callPayEndpointMethodId(
      {required bool useStripeSdk,
      required String paymentMethodId,
      required String currency,
      List<Map<String, dynamic>>? items,
      required dynamic priceInput}) async {
    try {
      print("callPayEndpointMethodId");
      print("usesStripeSdk: $useStripeSdk");
      print("paymentMethodId: $paymentMethodId");
      print("currency: $currency");
      print("items: $items");
      print("priceInput: $priceInput");

      final response = await http.post(
          Uri.parse(
              'https://us-central1-soccer-app-a9060.cloudfunctions.net/stripePaymentIntentRequest'),
          body: {
            'email': appModel.currentUser['email'],
            'amount': priceInput.toString(),
            'paymentMethodId': paymentMethodId,
          });

      print("return value: $response");

      return json.decode(response.body);
    } on FormatException catch (e) {
      print("error: $e");
      return {};
    }
  }

  Future<Map<String, dynamic>> createPrice(dynamic eventInput) async {
    Map<String, dynamic> createPriceResp = {
      "success": false,
      "message": "",
      "data": null
    };

    try {
      Map<String, dynamic> paymentInput = {
        'price': eventInput['price'].toString()
      };
      print("create price event input: $eventInput");
      print("create price input: ${paymentInput['price']}");
      Map<String, dynamic> createPrice =
          await EventCommand().createPrice(paymentInput, eventInput);
      print("createPrice resp: $createPrice");
      createPriceResp['data'] = createPrice['data'];

      return createPriceResp;
    } on Exception catch (e) {
      print('Mutation failed: $e');
      return createPriceResp;
    }
  }



  Future<Map<String, dynamic>> updatePrice(dynamic priceObject) async {
    print("updatePrice");
    print("priceObject: $priceObject");
    Map<String, dynamic> updatePriceResp = {
      "success": false,
      "message": "",
      "data": null
    };
    try {
      http.Response response = await http.post(
        Uri.parse(dotenv.env['APOLLO_SERVER'].toString()),
        headers: <String, String>{          
          'Content-Type': 'application/json'
        },
        body: jsonEncode(<String, String>{
          'query': PriceMutations().updatePrice(priceObject),
        }),
      );
      print("response body: ");
      print(jsonDecode(response.body));
      if(response.statusCode == 200){
        final result = jsonDecode(response.body)['data']['updatePrice'];
        if(result['success']){
          updatePriceResp['success'] = true;
          updatePriceResp['message'] = "Price Successfully Updated";                    
          updatePriceResp['data'] = result['price'];

        }
      }
      return updatePriceResp;
    } on Exception catch (e) {
      print('Mutation failed: $e');
      return updatePriceResp;
    }
  }
}
