import 'dart:ffi';

import 'package:flutter/foundation.dart';

class HomePageModel extends ChangeNotifier {

  String _currentUser = "";
  String get currentUser => _currentUser;
  
  bool _isSignedIn = false;
  bool get isSignedIn => _isSignedIn;

  bool _amplifyConfigured = false;
  bool get amplifyConfigured => _amplifyConfigured;

  bool _isDialogueViewOpened = false;
  bool get isDialogueViewOpened => _isDialogueViewOpened;
  
  
  set isDialogueViewOpened(bool isDialogueViewOpened){
    _isDialogueViewOpened = isDialogueViewOpened;
    notifyListeners();
  }

  set amplifyConfigured(bool amplifyConfigured){
    _amplifyConfigured = amplifyConfigured;
    notifyListeners();
  }

  set currentUser(String currentUser) {
    _currentUser = currentUser;
    notifyListeners();
  }

  set isSignedIn(bool isSignedIn){
    _isSignedIn = isSignedIn;
    notifyListeners();
  }

  
  // Eventually other stuff would go here, appSettings, premiumUser flags, currentTheme, etc...
}