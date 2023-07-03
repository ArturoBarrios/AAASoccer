import 'dart:convert';
import 'base_command.dart';
import 'package:amplify_api/amplify_api.dart';
import '../models/Location.dart';
import '../services/twilio_services.dart';
import '../services/onesignal_service.dart';
import '../graphql/mutations/chat.dart';
import '../graphql/queries/chat.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:faunadb_http/faunadb_http.dart';
import 'package:faunadb_http/query.dart';
import '../models/chat_page_model.dart';
import 'package:http/http.dart' as http;
import '../graphql/mutations/locations.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../commands/user_command.dart';
import 'images_command.dart';

class ChatCommand extends BaseCommand {
  int getIndexOfChat(String chatId) {
    int indexOfChat = 0;
    for (int i = 0; i < appModel.currentUser['chats']['data'].length; i++) {
      if (appModel.currentUser['chats']['data'][i]['_id'] == chatId) {
        indexOfChat = i;
      }
    }
    return indexOfChat;
  }

  void updateMessagesLengthTest() {
    print("updateMessagesLengthTest");
    chatPageModel.messagesLength += 1;
  }

  Future<void> setChatMessages(dynamic chat) async {
    print("setChatMessages");
    //get updated chat first?????
    dynamic findMyUser = await UserCommand().findMyUserById();
    dynamic user = findMyUser['data'];
    int index = getIndexOfChat(chat['_id']);
    for (int i = 0; i < appModel.currentUser['chats']['data'].length; i++) {
      if (appModel.currentUser['chats']['data'][i]['_id'] == chat['_id']) {
        chatPageModel.messages = user['chats']['data'][i]['messages']['data'];
       
      }
    }
  }


  //generalize this method and attach to 
  //teams, players, leagues, tournaments, 
  // and other events
  Future<Map<String, dynamic>> createChat(dynamic chatInput, dynamic objectsToAttachInput) async {
    print("createChat");
    print("chatInput: $chatInput");
    Map<String, dynamic> createChatResponse = {
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
          'query': ChatMutations().createChat(chatInput, objectsToAttachInput),
        }),
      );

      print("response body: ");
      print(jsonDecode(response.body));
      dynamic createdChat = jsonDecode(response.body)['data']['createChat'];
      BaseCommand().updateChatViewModels(createdChat, objectsToAttachInput);
      // userModel.chats.insert(0, createdChat);

      createChatResponse['success'] = true;
      createChatResponse['data'] = createdChat;

      

      return createChatResponse;
    } on ApiException catch (e) {
      print('Mutation failed: $e');
      return createChatResponse;
    }
  }

  List getChatsPageModel(){
    print("getChatsPageModel");
    return chatPageModel.chats;
  }

  void updateChatModel(dynamic chat){
    print("updateChatModel");
    print("chat: $chat");
    int indexOfChat = getIndexOfChat(chat['_id']);
    print("indexOfChat: $indexOfChat");
    chatPageModel.chats.remove(chat);
    chatPageModel.chats.insert(indexOfChat, chat);
  }

  Future<Map<String,dynamic>> setupChatModels() async{
    print("setupChatModels");    
    Map<String,dynamic> setupChatModelsResp = {
      "success": false,
      "message": "Default Error",
      "data": null
    };
    try{
      chatPageModel.chats = [];
      for(int i = 0;i<appModel.currentUser['chats']['data'].length;i++){
        String imageKey = appModel.currentUser['chats']['data'][i]['mainImageKey'];
        dynamic imageInput = {
          "key": imageKey      
        };
        if(imageKey != null){
          print("imageKey: $imageKey");
          Map<String,dynamic> getImageUrlResp = await ImagesCommand().getImageUrl(imageInput);
          if(getImageUrlResp['success']){
            appModel.currentUser['chats']['data'][i]['mainImageUrl'] = getImageUrlResp['data'];
          }
        }
        chatPageModel.chats.add(appModel.currentUser['chats']['data'][i]);

      }
      
      

      setupChatModelsResp['success'] = true;      

      print("finished setupChatModels");

      return setupChatModelsResp;
    } on ApiException catch (e) {
      print('Mutation failed: $e');
      return setupChatModelsResp;
    }


  }

  Future<Map<String, dynamic>> createText(
      Map<String, dynamic> chatInput) async {
    print("createText");
    print("chatInput: $chatInput");
    Map<String, dynamic> createTextResponse = {
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

      //refetch messages in user
      //(maybe don't get full user)
      int indexOfChat = getIndexOfChat(chatInput['chat_id']);
      print("indexOfChat: $indexOfChat");
      Map<String, dynamic> getchatInput = {
        "_id": appModel.currentUser['chats']['data'][indexOfChat]['_id']
      };
      print("getchatInput: $getchatInput");
      Map<String, dynamic> findChatByIdResponse =
          await findChatById(getchatInput);
      print("findChatByIdResponse: $findChatByIdResponse");
      dynamic chat = findChatByIdResponse['data'];
      print("chat: $chat");
      appModel.currentUser['chats']['data'][indexOfChat] = chat;

      userModel.chats[indexOfChat] = chat;



      print("chat test length before: " +
          chatPageModel.messages.length.toString());

      chatPageModel.messages = chat['messages']['data'];

      chatPageModel.messagesLength = chat['messages']['data'].length;
      print("chat test length after: " +
          chatPageModel.messages.length.toString());

      createTextResponse['success'] = true;
      createTextResponse['message'] = "Text Created";
      createTextResponse['data'] = chat;

      return createTextResponse;
    } on ApiException catch (e) {
      print('Mutation failed: $e');
      return createTextResponse;
    }
  }



  Future<Map<String, dynamic>> removeChat(
      Map<String, dynamic> chatInput) async {
    print("removeChat for real");
    Map<String, dynamic> removeChatResponse = {
      "success": false,
      "message": "Default Error",
      "data": null
    };
    try {
      if(!chatInput['isMainChat']){
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

        dynamic deletedChat = jsonDecode(response.body)['data']['deleteChat'];
        print("deletedChat: $deletedChat");

        removeChatResponse['success'] = true;
        removeChatResponse['message'] = "Chat Removed";
        removeChatResponse['data'] = deletedChat;

      }
      else{
        removeChatResponse['success'] = false;
        removeChatResponse['message'] = "Cannot remove main chat";
        removeChatResponse['data'] = null;
      }

      return removeChatResponse;
    } on ApiException catch (e) {
      print('Mutation failed: $e');      
      return removeChatResponse;
    }
  }

  String getProcessedChatInput(dynamic chatInput) {
    print("getProcessedChatInput");
    print("chatInput: " + chatInput.toString());
    String processedChatInput = """
    """;
    //iterate over chatInput
    for (int i = 0; i < chatInput.length; i++) {
      switch (chatInput[i]['dataType']) {
        case 'normal':
          processedChatInput += """
            archived: true   
          """;
          processedChatInput += "\n";
          break;
        case 'iterableDisconnect':
          String formDisconnectUserIdsString =
              this.formDisconnectUserIdsString(chatInput['users']);
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

  Future<Map<String, dynamic>> findChatById(
      Map<String, dynamic> chatInput) async {
    print("getChat");
    Map<String, dynamic> getChatResp = {
      "success": false,
      "message": "no chat found",
      "data": null
    };
    try {
      print("chatInput: ");
      print(chatInput);
      http.Response response = await http.post(
        Uri.parse('https://graphql.fauna.com/graphql'),
        headers: <String, String>{
          'Authorization': 'Bearer ' + dotenv.env['FAUNADBSECRET'].toString(),
          'Content-Type': 'application/json'
        },
        body: jsonEncode(<String, String>{
          'query': ChatQueries().findChatByID(chatInput),
        }),
      );

      print("response: ");
      print(jsonDecode(response.body));
      final result = jsonDecode(response.body)['data']['findChatByID'];
      // if (result != null) {
      getChatResp["success"] = true;
      getChatResp["message"] = "chat found";
      getChatResp["data"] = result;
      // }
    } catch (e) {
      print('Query failed: $e');
    }
    return getChatResp;
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
