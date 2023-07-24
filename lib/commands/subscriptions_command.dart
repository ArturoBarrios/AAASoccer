import 'dart:convert';
import '../graphql/mutations/subscriptions.dart';
import '../graphql/queries/subscriptions.dart';
import 'base_command.dart';
//foundation library
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';


class SubscriptionsCommand extends BaseCommand {  
  Future<Map<String, dynamic>> createSubscriptionTypes() async {
    print("createSubscriptions()");
    Map<String, dynamic> createSubscriptionsResp = {
      "success": false,
      "message": "Default",
      "data": null
    };

    try {
      String data = await rootBundle.loadString('lib/assets/json/subscriptions.json');
      List<dynamic> jsonResult = jsonDecode(data)["subscriptions"];
      for(int i = 0; i < jsonResult.length; i++){
        Map<String, dynamic> subscription = jsonResult[i];
        String lengths = subscription["lengths"];
        print("lengths: " + lengths.toString());
        

        http.Response createSubscriptionResp = await http.post(
          Uri.parse('https://graphql.fauna.com/graphql'),
          headers: <String, String>{
            'Authorization': 'Bearer ' + dotenv.env['FAUNADBSECRET'].toString(),
            'Content-Type': 'application/json'
          },

          body: jsonEncode(<String, String>{
            'query':
                SubscriptionMutations().createSubscriptionType(subscription),
          }),
        );        
        print("createSubscriptionResp: " + jsonDecode(createSubscriptionResp.body).toString());

        

        
      }
      print("jsonResult: $jsonResult");

      createSubscriptionsResp["data"] = jsonResult;
      createSubscriptionsResp["message"] = "Data loaded successfully";
      createSubscriptionsResp["success"] = true;
      
      return createSubscriptionsResp;
    } catch (e) {
      print(e);
      createSubscriptionsResp["message"] = "Error loading data";
      return createSubscriptionsResp;
    }
  }
  
  Future<Map<String, dynamic>> createSubscriptionTypeUser(dynamic subscriptionInput) async {
    print("createSubscriptionTypeUser()");
    Map<String, dynamic> createSubscriptionTypeUserResp = {
      "success": false,
      "message": "Default",
      "data": null
    };

    try {              
      http.Response createSubscriptionTypeUserQuery = await http.post(
        Uri.parse('https://graphql.fauna.com/graphql'),
        headers: <String, String>{
          'Authorization': 'Bearer ' + dotenv.env['FAUNADBSECRET'].toString(),
          'Content-Type': 'application/json'
        },

        body: jsonEncode(<String, String>{
          'query':
              SubscriptionMutations().createSubscriptionTypeUser(subscriptionInput),
        }),
      );        
      print("createSubscriptionResp: " + jsonDecode(createSubscriptionTypeUserQuery.body).toString());
      if(createSubscriptionTypeUserQuery.statusCode == 200){        
        dynamic createSubscriptionTypeUser = jsonDecode(createSubscriptionTypeUserQuery.body)["data"]["createSubscriptionTypeUser"];
        createSubscriptionTypeUserResp["data"] = createSubscriptionTypeUser;
        createSubscriptionTypeUserResp["message"] = "Data loaded successfully";
        createSubscriptionTypeUserResp["success"] = true;
       
      }
        
      
      
      return createSubscriptionTypeUserResp;
    } catch (e) {
      print(e);
      createSubscriptionTypeUserResp["message"] = "Error creating data";
      return createSubscriptionTypeUserResp;
    }
  }
  
  Future<Map<String, dynamic>> getSubscriptionTypes() async {
    print("getSubscriptions()");

    Map<String, dynamic> getSubscriptionsResp = {
      "success": false,
      "message": "Default",
      "data": null
    };
    
    try{
      http.Response response = await http.post(
        Uri.parse('https://graphql.fauna.com/graphql'),
        headers: <String, String>{
          'Authorization': 'Bearer ' + dotenv.env['FAUNADBSECRET'].toString(),
          'Content-Type': 'application/json'
        },
        body: jsonEncode(<String, String>{
          'query': SubscriptionQueries().getSubscriptionTypes(),
        }),
      );

      print("getSubscriptions response: " + jsonDecode(response.body).toString());
      print("getSubscriptions statusCode: " + response.statusCode.toString());
      if(response.statusCode == 200){
        getSubscriptionsResp['success'] = true;
        getSubscriptionsResp['message'] = "Subscriptions loaded successfully";
        getSubscriptionsResp['data'] = jsonDecode(response.body)['data']['allSubscriptionTypes']['data'];

      }


      return getSubscriptionsResp;
    } catch(e){
      print(e);
      getSubscriptionsResp["message"] = "Error loading data";
      return getSubscriptionsResp;
    }

  }
}