import 'dart:convert';
import 'base_command.dart';
import 'package:amplify_api/amplify_api.dart';
import '../models/Location.dart';
import '../services/twilio_services.dart';
import '../services/onesignal_service.dart';
import '../graphql/mutations/chat.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:faunadb_http/faunadb_http.dart';
import 'package:faunadb_http/query.dart';
import '../models/app_model.dart';
import 'package:http/http.dart' as http;
import '../graphql/mutations/locations.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ChatCommand extends BaseCommand {

  Future<Map<String, dynamic>> createChat(
      Map<String, dynamic> chatInput) async {
    print("removeChat");
    Map<String, dynamic> removeChatResponse = {
      "success": false,
      "message": "Default Error",
      "data": null
    };
    try {
      chatInput['user_id'] = appModel.currentUser['_id'];
      http.Response response = await http.post(
        Uri.parse('https://graphql.fauna.com/graphql'),
        headers: <String, String>{
          'Authorization': 'Bearer ' + dotenv.env['FAUNADBSECRET'].toString(),
          'Content-Type': 'application/json'
        },
        body: jsonEncode(<String, String>{
          'query': ChatMutations().createChat(chatInput),
        }),
      );

      print("response body: ");
      print(jsonDecode(response.body));

      return removeChatResponse;
    } on ApiException catch (e) {
      print('Mutation failed: $e');
      return removeChatResponse;
    }
  }

  Future<Map<String, dynamic>> createText(
      Map<String, dynamic> chatInput) async {
    print("removeChat");
    Map<String, dynamic> removeChatResponse = {
      "success": false,
      "message": "Default Error",
      "data": null
    };
    try {
      chatInput['user_id'] = appModel.currentUser['_id'];
      http.Response response = await http.post(
        Uri.parse('https://graphql.fauna.com/graphql'),
        headers: <String, String>{
          'Authorization': 'Bearer ' + dotenv.env['FAUNADBSECRET'].toString(),
          'Content-Type': 'application/json'
        },
        body: jsonEncode(<String, String>{
          'query': ChatMutations().createTextMessage(chatInput),
        }),
      );

      print("response body: ");
      print(jsonDecode(response.body));

      return removeChatResponse;
    } on ApiException catch (e) {
      print('Mutation failed: $e');
      return removeChatResponse;
    }
  }

  Future<Map<String, dynamic>> removeChat(
      Map<String, dynamic> chatInput) async {
    print("removeChat");
    Map<String, dynamic> removeChatResponse = {
      "success": false,
      "message": "Default Error",
      "data": null
    };
    try {
      http.Response response = await http.post(
        Uri.parse('https://graphql.fauna.com/graphql'),
        headers: <String, String>{
          'Authorization': 'Bearer ' + dotenv.env['FAUNADBSECRET'].toString(),
          'Content-Type': 'application/json'
        },
        body: jsonEncode(<String, String>{
          'query': ChatMutations().deleteChat(chatInput),
        }),
      );

      print("response body: ");
      print(jsonDecode(response.body));

      return removeChatResponse;
    } on ApiException catch (e) {
      print('Mutation failed: $e');
      return removeChatResponse;
    }
  }

// chatInput = [
// chat data types to process: [normal, iterableDisconnect, iterableConnect]
// ]
// ignore: slash_for_doc_comments
/** Example from chat_card.dart
 *  dynamic archiveChatIterableInput = [
    {"dataType": "normal",
    "data": chatObject['archived'],
    "_id": chatObject['_id']
    }
 */
  String getProcessedChatInput(dynamic chatInput){
    print("getProcessedChatInput");
    print("chatInput: " + chatInput.toString());
    String processedChatInput = """
    """;
    //iterate over chatInput
    for(int i = 0;i<chatInput.length;i++){
      switch(chatInput[i]['dataType']){
        case 'normal':
          processedChatInput += """
            archived: true   
          """;
          processedChatInput += "\n";
          break;
        case 'iterableDisconnect':          
          String formDisconnectUserIdsString = this.formDisconnectUserIdsString(chatInput['users']);
          processedChatInput += """
            users: {
              disconnect: [
                ${formDisconnectUserIdsString}
              ]
            }                      
          """;
          processedChatInput += "\n";

          break;        
      }

    }
    processedChatInput = """
      archived: true      
    """;

    return processedChatInput;
  }
  
  

  // chatInput = [
  //  chat data types to process: [normal, iterableDisconnect, iterableConnect]
  // ]
  Future<Map<String, dynamic>> archiveChat(
      Map<String, dynamic> chatInput) async {
    print("archiveChat");
    Map<String, dynamic> archiveChatResponse = {
      "success": false,
      "message": "Default Error",
      "data": null
    };
    try {
      Map<String, dynamic> processedChatInput = {
        'chat': {
          '_id': chatInput['_id'],
          'data': getProcessedChatInput(chatInput),          
        },        
      };
      http.Response response = await http.post(
        Uri.parse('https://graphql.fauna.com/graphql'),
        headers: <String, String>{
          'Authorization': 'Bearer ' + dotenv.env['FAUNADBSECRET'].toString(),
          'Content-Type': 'application/json'
        },
        body: jsonEncode(<String, String>{
          'query': ChatMutations().updateChat(chatInput),
        }),
      );

      print("response body: ");
      print(jsonDecode(response.body));

      return archiveChatResponse;
    } on ApiException catch (e) {
      print('Mutation failed: $e');
      return archiveChatResponse;
    }
  }
}
