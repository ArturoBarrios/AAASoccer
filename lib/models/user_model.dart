import 'dart:ffi';

import 'package:flutter/foundation.dart';
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
// import 'package:geolocator/geolocator.dart';

class UserModel extends ChangeNotifier {
  List<String> _userPosts = [];
  List<String> get userPosts => _userPosts;
  String userID = "";
  String userEmail = "";
  String profileImageUrl = "";

  bool _userSetup = false;
  bool get userSetup => _userSetup;
  set userSetup(bool userSetup) {
    _userSetup = userSetup;
    notifyListeners();
  }

  List _chats = [];
  List get chats => _chats;
  set chats(List chats) {
    _chats = chats;
    notifyListeners();
    print("chats updated in user_model");
    print("chats new length: " + chats.length.toString());
  }






  

 

}
