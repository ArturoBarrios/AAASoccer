import 'dart:convert';
import 'base_command.dart';
//foundation library
import 'package:flutter/services.dart';


class SubscriptionsCommand extends BaseCommand {
  Future<Map<String, dynamic>> createSubscriptions() async {
    print("createSubscriptions()");
    Map<String, dynamic> createSubscriptionsResp = {
      "success": false,
      "message": "Default",
      "data": null
    };

    try {
      String data = await rootBundle.loadString('assets/subscriptions.json');
      List<dynamic> jsonResult = jsonDecode(data)["subscriptions"];
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
}