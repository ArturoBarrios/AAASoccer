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

  String _profileImageUrl = "";
  String get profileImageUrl => _profileImageUrl;
  set profileImageUrl(String profileImageUrl) {
    _profileImageUrl = profileImageUrl;
    notifyListeners();
  }

  bool _userSetup = false;
  bool get userSetup => _userSetup;
  set userSetup(bool userSetup) {
    _userSetup = userSetup;
    notifyListeners();
  }
}
