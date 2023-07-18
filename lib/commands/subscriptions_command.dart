import 'dart:convert';
import '../graphql/queries/subscriptios.dart';
import 'base_command.dart';
//foundation library
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';


class SubscriptionsCommand extends BaseCommand {
  Future<Map<String, dynamic>> createSubscriptions() async {
    print("createSubscriptions()");
    Map<String, dynamic> createSubscriptionsResp = {
      "success": false,
      "message": "Default",
      "data": null
    };

    try {
      String data = await rootBundle.loadString('lib/assets/json/subscriptions.json');
      List<dynamic> jsonResult = jsonDecode(data)["subscriptions"];
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
  
  Future<Map<String, dynamic>> getSubscriptions() async {
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
          'query': SubscriptionQueries().getSubscriptions(),
        }),
      );


      return getSubscriptionsResp;
    } catch(e){
      print(e);
      getSubscriptionsResp["message"] = "Error loading data";
      return getSubscriptionsResp;
    }

  }
}