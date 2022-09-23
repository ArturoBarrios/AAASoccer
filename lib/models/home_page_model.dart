import 'dart:ffi';

import 'package:flutter/foundation.dart';
import '../strings.dart';
import 'package:soccermadeeasy/svg_widgets.dart';
import 'event_types_model.dart';

class HomePageModel extends ChangeNotifier {

  String _testText = "";
  String get testText => _testText;
  set testText(String text) {
    _testText = text;
    notifyListeners();
  }

  String _currentUser = "";
  String get currentUser => _currentUser;
  set currentUser(String currentUser) {
    _currentUser = currentUser;
    notifyListeners();
  }
  
  bool _isSignedIn = false;
  bool get isSignedIn => _isSignedIn;
  set isSignedIn(bool isSignedIn){
    _isSignedIn = isSignedIn;
    notifyListeners();
  }

  bool _amplifyConfigured = false;
  bool get amplifyConfigured => _amplifyConfigured;
  set amplifyConfigured(bool amplifyConfigured){
    _amplifyConfigured = amplifyConfigured;
    notifyListeners();
  }

  bool _isDialogueViewOpened = false;
  bool get isDialogueViewOpened => _isDialogueViewOpened;
  set isDialogueViewOpened(bool isDialogueViewOpened){
    _isDialogueViewOpened = isDialogueViewOpened;
    notifyListeners();
  }


  

  List _enabledEvents = [
    {
      "key": 0,
      "enabled": true,
      "name": StringConstants.PICKUPGAMESTITLE,
      "description": "",
      "image": SVGWidgets().getSoccerBallSVGImage(),
    },
     {
      "key": 1,
      "enabled": false,
      "name": StringConstants.PLAYERSTITLE,
      "description": "",
      "image": SVGWidgets().getSoccerBallSVGImage(),
    },
     {
      "key": 2,
      "enabled": false,
      "name": StringConstants.TEAMSTITLE,
      "description": "",
      "image": SVGWidgets().getSoccerBallSVGImage(),
    },
    {
      "key": 3,
      "enabled": false,
      "name": StringConstants.TRYOUTSTITLE,
      "description": "",
      "image": SVGWidgets().getSoccerBallSVGImage(),
    },
    {
      "key": 4,
      "enabled": false,
      "name": StringConstants.TOURNAMENTSTITLE,
      "description": "",
      "image": SVGWidgets().getSoccerBallSVGImage(),
    },
    {
      "key": 5,
      "enabled": false,
      "name": StringConstants.LEAGUESTITLE,
      "description": "",
      "image": SVGWidgets().getSoccerBallSVGImage(),
    },
  ];
  //traverse enabledEvents
  List get enabledEvents => _enabledEvents;

  void toggleEvent(int index){
    _enabledEvents.forEach((element) { 
        element['enabled'] = false;
    });
    _enabledEvents[index]['enabled'] = !_enabledEvents[index]['enabled'];
    notifyListeners();
  }

  set enabledEvents(List enabledEvents){
    _enabledEvents = enabledEvents;    
    notifyListeners();
  }

}