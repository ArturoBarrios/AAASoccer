import 'package:flutter/foundation.dart';

class ChatPageModel extends ChangeNotifier {
  List _chats = [];
  List get chats => _chats;
  set chats(List chats) {
    _chats = chats;
    notifyListeners();
    print("chat in chat_page_model updated");
  }

  List _messages = [];
  List get messages => _messages;
  set messages(List messages) {
    _messages = messages;
    messagesLength = messages.length;
    print("messages updated in chat_page_model");
    print("chat_page_model messages length after update: " +
        messages.length.toString());
    notifyListeners();
  }

  int _messagesLength = 0;
  int get messagesLength => _messagesLength;
  set messagesLength(int messagesLength) {
    _messagesLength = messagesLength;
    print("messagesLength updated in chat_page_model");
    print("chat_page_model messagesLength after update: " +
        messages.length.toString());
    notifyListeners();
  }
}
