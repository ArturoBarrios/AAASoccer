import 'dart:ffi';

import 'package:flutter/foundation.dart';
import '../strings.dart';
import 'package:soccermadeeasy/svg_widgets.dart';

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

  String _selectedKey = "0";
  String get selectedKey => _selectedKey;
  set selectedKey(String selectedKey){
    _selectedKey = selectedKey;
    notifyListeners();
  }

  Map<String, dynamic> _enabledSelections2 = {
    "0": {
      "key": "0",
      "enabled": true,
      "name": StringConstants.PICKUPGAMESTITLE,
      "description": "",
      "image": SVGWidgets().getSoccerBallSVGImage(),
      
    },
    "6": {
      "key": "6",
      "enabled": false,
      "name": StringConstants.TRAININGSTITLE,
      "description": "",
      "image": SVGWidgets().getSoccerBallSVGImage(),
    },
     "1": {
      "key": "1",
      "enabled": false,
      "name": StringConstants.PLAYERSTITLE,
      "description": "",
      "image": SVGWidgets().getSoccerBallSVGImage(),
    },
     "2": {
      "key": "2",
      "enabled": false,
      "name": StringConstants.TEAMSTITLE,
      "description": "",
      "image": SVGWidgets().getSoccerBallSVGImage(),
    },
    "3": {
      "key": "3",
      "enabled": false,
      "name": StringConstants.TRYOUTSTITLE,
      "description": "",
      "image": SVGWidgets().getSoccerBallSVGImage(),
    },
    "4":{
      "key": "4",
      "enabled": false,
      "name": StringConstants.TOURNAMENTSTITLE,
      "description": "",
      "image": SVGWidgets().getSoccerBallSVGImage(),
    },
    "5":{
      "key": "5",
      "enabled": false,
      "name": StringConstants.LEAGUESTITLE,
      "description": "",
      "image": SVGWidgets().getSoccerBallSVGImage(),
    },
  };
  Map<String, dynamic> get enabledSelections2 => _enabledSelections2;
  set enabledSelections2(Map<String, dynamic> enabledSelections2){
    _enabledSelections2 = enabledSelections2;    
    notifyListeners();
  }


  List _enabledSelections = [
    {
      "key": 0,
      "enabled": true,
      "name": StringConstants.PICKUPGAMESTITLE,
      "description": "",
      "image": SVGWidgets().getSoccerBallSVGImage(),
      
    },
    //include past events, sort by most current
    //that way past events are always last
    {
      "key": 7,
      "enabled": true,
      "name": StringConstants.MYEVENTS,
      "description": "My Events",
      "image": SVGWidgets().getSoccerBallSVGImage(),
      
    },
    {
      "key": 6,
      "enabled": false,
      "name": StringConstants.TRAININGSTITLE,
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
  List get enabledSelections => _enabledSelections;
  set enabledSelections(List enabledSelections){
    _enabledSelections = enabledSelections;    
    notifyListeners();
  }

  // void toggleEvent(int index){
  //   _enabledSelections.forEach((element) { 
  //       element['enabled'] = false;
  //       selectedKey = element['key'];
  //   });
  //   _enabledSelections[index]['enabled'] = !_enabledSelections[index]['enabled'];    
  //   notifyListeners();
  // }

  List _selectedObjects = [];
  List get selectedObjects => _selectedObjects;
  set selectedObjects(List selectedObjects){
    print("set selected objects!");
    _selectedObjects = selectedObjects;
    notifyListeners();
  }

}