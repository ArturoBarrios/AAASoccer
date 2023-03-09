import 'dart:ffi';

import 'package:flutter/foundation.dart';
import '../strings.dart';
import 'package:soccermadeeasy/svg_widgets.dart';
import '../constants.dart';

import '../views/game/create.dart';
import '../views/league/create.dart';
import '../views/tournament/create.dart';
import '../views/training/create.dart';
import '../views/tryout/create.dart';
import '../views/team/create/create.dart';


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

  String _selectedKey = Constants.PICKUP;
  String get selectedKey => _selectedKey;
  set selectedKey(String selectedKey){
    _selectedKey = selectedKey;
    notifyListeners();
  }

  
  Map<String, dynamic> createEventTypes = {
     "0": {
      "key": "0",
      "enabled": true,
      "name": StringConstants.PICKUPGAMESTITLE,
      "description": "",
      "image": SVGWidgets().getSoccerBallSVGImage(),
      "createWidget": GameCreate(),            
    },
    "6": {
      "key": "6",
      "enabled": false,
      "name": StringConstants.TRAININGSTITLE,
      "description": "",
      "image": SVGWidgets().getSoccerBallSVGImage(),
      "createWidget": TrainingCreate(),
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
      "createWidget": TeamCreate(),
    },
    "3": {
      "key": "3",
      "enabled": false,
      "name": StringConstants.TRYOUTSTITLE,
      "description": "",
      "image": SVGWidgets().getSoccerBallSVGImage(),
      "createWidget": TryoutCreate(),
    },
    "4":{
      "key": "4",
      "enabled": false,
      "name": StringConstants.TOURNAMENTSTITLE,
      "description": "",
      "image": SVGWidgets().getSoccerBallSVGImage(),
      "createWidget": TournamentCreate(),
    },
    "5":{
      "key": "5",
      "enabled": false,
      "name": StringConstants.LEAGUESTITLE,
      "description": "",
      "image": SVGWidgets().getSoccerBallSVGImage(),
      "createWidget": LeagueCreate(),
    },
  };
  


  Map<String, dynamic> _enabledSelections2 = {
    Constants.PICKUP: {
      "key": Constants.PICKUP,
      "enabled": true,
      "name": StringConstants.PICKUPGAMESTITLE,
      "description": "",
      "image": SVGWidgets().getSoccerBallSVGImage(),
      
    },    
    Constants.MYEVENTS: {
      "key": Constants.MYEVENTS,
      "enabled": false,
      "name": StringConstants.MYEVENTSTITLE,
      "description": "",
      "image": SVGWidgets().getSoccerBallSVGImage(),
    },
    Constants.FRIEND: {
      "key": Constants.FRIEND,
      "enabled": false,
      "name": StringConstants.FRIENDSTITLE,
      "description": "",
      "image": SVGWidgets().getSoccerBallSVGImage(),
    },
    Constants.PLAYER: {
      "key": Constants.PLAYER,
      "enabled": false,
      "name": StringConstants.PLAYERSTITLE,
      "description": "",
      "image": SVGWidgets().getSoccerBallSVGImage(),
    },
    Constants.TEAM: {
    "key": Constants.TEAM,
    "enabled": false,
    "name": StringConstants.TEAMSTITLE,
    "description": "",
    "image": SVGWidgets().getSoccerBallSVGImage(),
    },
    Constants.TRAINING: {
      "key": Constants.TRAINING,
      "enabled": false,
      "name": StringConstants.TRAININGSTITLE,
      "description": "",
      "image": SVGWidgets().getSoccerBallSVGImage(),
    },
    Constants.TRYOUT: {
      "key": Constants.TRYOUT,
      "enabled": false,
      "name": StringConstants.TRYOUTSTITLE,
      "description": "",
      "image": SVGWidgets().getSoccerBallSVGImage(),
    },
    Constants.TOURNAMENT:{
      "key": Constants.TOURNAMENT,
      "enabled": false,
      "name": StringConstants.TOURNAMENTSTITLE,
      "description": "",
      "image": SVGWidgets().getSoccerBallSVGImage(),
    },
    Constants.LEAGUE:{
      "key": Constants.LEAGUE,
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

  List _selectedObjects = [];
  List get selectedObjects => _selectedObjects;
  set selectedObjects(List selectedObjects){
    print("set selected objects!");
    _selectedObjects = selectedObjects;
    notifyListeners();
  }

}