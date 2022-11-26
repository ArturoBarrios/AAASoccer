import 'base_command.dart';
import 'package:amplify_api/amplify_api.dart';
import '../graphql/mutations/tryouts.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class TryoutCommand extends BaseCommand {


 Future<Map<String, dynamic>> createTryout(
      Map<String, dynamic> tryoutInput,
      Map<String, dynamic> eventInput, Map<String, dynamic> locationInput) async {
    print("createTryout");
    Map<String, dynamic> createTryoutResponse = {
      "success": false,
      "message": "Default Error",
      "data": null
    };
    try {
     
      http.Response response = await http.post(
        Uri.parse('https://graphql.fauna.com/graphql'),
        headers: <String, String>{
          'Authorization': 'Bearer '+ dotenv.env['FAUNADBSECRET'].toString(),
          'Content-Type': 'application/json'
        },
        body: jsonEncode(<String, String>{
          'query': TryoutMutations().createTryout(tryoutInput, eventInput, locationInput),
        }),
      );

      print("response body: ");
      print(jsonDecode(response.body));
        
        createTryoutResponse["success"] = true;
        createTryoutResponse["message"] = "Game Created";
        createTryoutResponse["data"] = jsonDecode(response.body)['data']['createTryout'];
        
      
      

      
    } on ApiException catch (e) {
      print('Mutation failed: $e');
      
    }
      return createTryoutResponse;  
  }

  

 

}