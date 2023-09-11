import 'dart:developer';

import 'package:flutter/foundation.dart';

class ChatPageModel extends ChangeNotifier {
  int? _selectedChat;
  int get selectedChat => _selectedChat ?? 0;
  set selectedChat(int selectedChat) {
    _selectedChat = selectedChat;
    notifyListeners();
    log("selected chat in chat_page_model updated");
  }

  List _messages = [];
  List get messages => _messages;
  set messages(List messages) {
    _messages = messages;
    log("chat_page_model messages length after update: ${messages.length}");
    notifyListeners();
  }

  List _generalChatList = [];
  List get generalChatList => _generalChatList;
  set generalChatList(List generalChatList) {
    _generalChatList = generalChatList;
    notifyListeners();
    log("generalChatList in chat_page_model's new length: ${generalChatList.length}");
  }
}
