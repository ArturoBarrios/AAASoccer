import 'dart:ffi';

import 'package:flutter/foundation.dart';
import 'package:faunadb_http/faunadb_http.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:twilio_flutter/twilio_flutter.dart';
import 'package:geolocator/geolocator.dart';

class ChatPageModel extends ChangeNotifier {
  List _messages = [];
  List get messages => _messages;
  set messages(List messages) {
    _messages = messages;
    messagesLength = messages.length;
    notifyListeners();
    print("messages updated in chat_page_model");
    print("chat_page_model messages length after update: " + messages.length.toString());

  }  
  
  int _messagesLength = 0;
  int get messagesLength => _messagesLength;
  set messagesLength(int messagesLength) {
    _messagesLength = messagesLength;
    notifyListeners();
    print("messagesLength updated in chat_page_model");
    print("chat_page_model messagesLength after update: " + messages.length.toString());

  }  
  
}