import 'dart:ffi';

import 'package:flutter/foundation.dart';
import '../commands/home_page_command.dart';
import '../strings.dart';
import 'package:soccermadeeasy/svg_widgets.dart';
import '../constants.dart';

import '../views/game/create.dart';
import '../views/league/create.dart';
import '../views/tournament/create.dart';
import '../views/training/create.dart';
import '../views/tryout/create.dart';
import '../views/team/create/create.dart';
import '../views/locations/create.dart';


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
  
  bool _cardsLoading = true;
  bool get cardsLoading => _cardsLoading;
  set cardsLoading(bool cardsLoading){
    _cardsLoading = cardsLoading;
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
  
  bool _updatedCards = false;
  bool get updatedCards => _updatedCards;
  set updatedCards(bool updatedCards){
    _updatedCards = updatedCards;
    notifyListeners();
  }

  dynamic _selectedKey = Constants.MYEVENTS;
  dynamic get selectedKey => _selectedKey;
  set selectedKey(dynamic selectedKey){
    _selectedKey = selectedKey;
    notifyListeners();
  }  

  


  Map<dynamic, dynamic> _enabledSelections2 = {
    Constants.MYEVENTS: {
      "key": Constants.MYEVENTS,
      "enabled": true,
      "name": StringConstants.MYEVENTSTITLE,
      "description": "",
      "image": SVGWidgets().getSoccerBallSVGImage(),
    },
    Constants.MYTEAMS: {
      "key": Constants.MYTEAMS,
      "enabled": false,
      "name": StringConstants.MYTEAMSTITLE,
      "description": "",
      "image": SVGWidgets().getSoccerBallSVGImage(),
    },
    Constants.PICKUP: {
      "key": Constants.PICKUP,
      "enabled": false,
      "name": StringConstants.PICKUPGAMESTITLE,
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
    Constants.LOCATION:{
      "key": Constants.LOCATION,
      "enabled": false,
      "name": StringConstants.LOCATIONSTITLE,
      "description": "",
      "image": SVGWidgets().getSoccerBallSVGImage(),
    },    
  };

  
  Map<dynamic, dynamic> get enabledSelections2 => _enabledSelections2;
  set enabledSelections2(Map<dynamic, dynamic> enabledSelections2){
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

  List _cards = [];
  List get cards => _cards;
  set cards(List cards){
    print("set homePageModel cards!");
    _cards = cards;
    notifyListeners();
  }
  
  List _userObjectSelections = [];
  List get userObjectSelections => _userObjectSelections;
  set userObjectSelections(List userObjectSelections){
    print("set selected objects!");
    _userObjectSelections = userObjectSelections;
    notifyListeners();
  }

}