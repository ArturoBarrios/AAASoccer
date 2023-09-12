import 'dart:convert';
import 'dart:developer';
import '../graphql/mutations/requests.dart';
import 'base_command.dart';
import 'package:amplify_api/amplify_api.dart';
import '../graphql/mutations/chat.dart';
import '../graphql/queries/chat.dart';
import 'package:http/http.dart' as http;
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
  Future<Map<String, dynamic>> createChat(
      dynamic chatInput, dynamic objectsToAttachInput) async {
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

  List getChatsPageModel() {
    print("getChatsPageModel");
    return chatPageModel.generalChatList;
  }

  void updateChatModel(dynamic chat) {
    print("updateChatModel");
    log("chat: ${chat.toString()}");
    int indexOfChat = getIndexOfChat(chat['_id']);
    log("indexOfChat: $indexOfChat");
    chatPageModel.generalChatList.remove(chat);
    chatPageModel.generalChatList.insert(indexOfChat, chat);
  }

  void updateGeneralChatList(dynamic chat) {
    chatPageModel.generalChatList = chat;
  }

  //seperate for now because I don't feel like refactoring
  Future<Map<String, dynamic>> setupChats(List<dynamic> chats) async {
    print("setupChats");
    Map<String, dynamic> setupChatsResp = {
      "success": false,
      "message": "Default Error",
      "data": null
    };
    try {
      for (int i = 0; i < chats.length; i++) {
        String? imageKey = chats[i]['mainImageKey'];
        dynamic imageInput = {"key": imageKey};
        print("imageKeyy: $imageKey");
        if (imageKey != null) {
          print("imageKey: $imageKey");
          Map<String, dynamic> getImageUrlResp =
              await ImagesCommand().getImageUrl(imageInput);
          print("getImageUrlResppp: " + getImageUrlResp.toString());
          if (getImageUrlResp['success']) {
            chats[i]['mainImageUrl'] = getImageUrlResp['data'];
          }
        }
      }

      setupChatsResp['success'] = true;
      setupChatsResp['data'] = chats;

      print("finished setupChats");

      return setupChatsResp;
    } on ApiException catch (e) {
      print('Mutation failed: $e');
      return setupChatsResp;
    }
  }

  Future<Map<String, dynamic>> setupChatModels() async {
    print("setupChatModels");
    Map<String, dynamic> setupChatModelsResp = {
      "success": false,
      "message": "Default Error",
      "data": null
    };
    try {
      chatPageModel.generalChatList = [];
      for (int i = 0; i < appModel.currentUser['chats']['data'].length; i++) {
        String? imageKey =
            appModel.currentUser['chats']['data'][i]['mainImageKey'];
        print("imageKey: $imageKey");

        if (imageKey != null) {
          dynamic imageInput = {"key": imageKey};
          Map<String, dynamic> getImageUrlResp =
              await ImagesCommand().getImageUrl(imageInput);
          if (getImageUrlResp['success']) {
            appModel.currentUser['chats']['data'][i]['mainImageUrl'] =
                getImageUrlResp['data'];
          }
        }

        chatPageModel.generalChatList
            .add(appModel.currentUser['chats']['data'][i]);
      }

      setupChatModelsResp['success'] = true;

      print("finished setupChatModels");

      return setupChatModelsResp;
    } on ApiException catch (e) {
      print('Mutation failed: $e');
      return setupChatModelsResp;
    }
  }

  void updateSelectedChatIndex(int value) {
    chatPageModel.selectedChat = value;
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

      chatPageModel.generalChatList[indexOfChat] = chat;

      chatPageModel.messages = chat['messages']['data'];

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
      if (!chatInput['isMainChat']) {
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
      } else {
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

  /// Disconnect user from chat.
  Future<Map<String, dynamic>> disconnectUser(
      Map<String, dynamic> chatInput) async {
    print("archiveChat");
    Map<String, dynamic> disconnectUserResponse = {
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
          'query': ChatMutations().disconnectUser(chatInput),
        }),
      );

      print("response body: ");
      print(jsonDecode(response.body));

      return disconnectUserResponse;
    } on ApiException catch (e) {
      print('Mutation failed: $e');
      return disconnectUserResponse;
    }
  }

  //send chat request to receiver
  Future<Map<String, dynamic>> sendChatRequest(dynamic requestInput) async {
    print("sendTeamEventRequest");
    Map<String, dynamic> sendChatRequestResponse = {
      "success": false,
      "message": "Default Error",
      "data": null
    };
    try {
      dynamic sendRequestInput = {
        "type": requestInput['type'],
        "typeId": requestInput['typeId'],
        "senderId": appModel.currentUser['_id'],
        "receiverId": requestInput['receiverId'],
      };

      http.Response response = await http.post(
        Uri.parse('https://graphql.fauna.com/graphql'),
        headers: <String, String>{
          'Authorization': 'Bearer ${dotenv.env['FAUNADBSECRET']}',
          'Content-Type': 'application/json'
        },
        body: jsonEncode(<String, String>{
          'query': RequestMutations().sendChatRequest(sendRequestInput)
        }),
      );

      print("response: ${response.body}");
      print("sendTeamEventRequest");

      sendChatRequestResponse["success"] = true;
      sendChatRequestResponse["message"] = "Event Request to Team Created";

      return sendChatRequestResponse;
    } catch (e) {
      print("error in sendTeamEventRequest: $e");
      return sendChatRequestResponse;
    }
  }

  Future<Map<String, dynamic>> addUserToChat(
      Map<String, dynamic> chatInput) async {
    print("add user to chat request start");
    Map<String, dynamic> addUserToChatResponse = {
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
          'query': ChatMutations().addUserToChat(chatInput),
        }),
      );

      print("response body: ");
      print(jsonDecode(response.body));

      dynamic adduserToCharData =
          jsonDecode(response.body)['data']['updateChat']['users']['data'];
      print("adduserToCharData: $adduserToCharData");

      addUserToChatResponse['success'] = true;
      addUserToChatResponse['message'] = "User added";
      addUserToChatResponse['data'] = adduserToCharData;

      return addUserToChatResponse;
    } on ApiException catch (e) {
      print('Mutation failed: $e');
      return addUserToChatResponse;
    }
  }
}
