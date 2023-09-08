import 'package:flutter/foundation.dart';

class ProfilePageModel extends ChangeNotifier {
  /////////////////
  dynamic _user = null;
  dynamic get user => _user;
  set user(dynamic user) {
    _user = user;
    notifyListeners();
  }    

}
