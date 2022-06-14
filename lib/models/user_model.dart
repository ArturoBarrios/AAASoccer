import 'dart:ffi';

import 'package:flutter/foundation.dart';
import 'package:amplify_api/amplify_api.dart';
import './User.dart';
import 'package:amplify_flutter/amplify_flutter.dart';

class UserModel extends ChangeNotifier {
  List<String> _userPosts = [];
  List<String> get userPosts => _userPosts;
  String userID = "";
  String userEmail = "";
  User user = User();
  
  ValueNotifier<bool> userSetup = ValueNotifier<bool>(false);

void setUserID(String userId){
  userID = userId;
}
  

 

}
