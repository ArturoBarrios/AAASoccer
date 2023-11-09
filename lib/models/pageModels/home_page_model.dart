import 'dart:ffi';

import 'package:flutter/foundation.dart';
import '../../commands/base_command.dart';
import '../../commands/home_page_command.dart';
import '../../strings.dart';
import 'package:soccermadeeasy/svg_widgets.dart';
import '../../constants.dart';

import '../../views/game/create.dart';
import '../../views/league/create.dart';
import '../../views/tournament/create.dart';
import '../../views/training/create.dart';
import '../../views/tryout/create.dart';
import '../../views/team/create/create.dart';
import '../../views/location/create.dart';

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
  set cardsLoading(bool cardsLoading) {
    _cardsLoading = cardsLoading;
    notifyListeners();
  }

  bool _isSignedIn = false;
  bool get isSignedIn => _isSignedIn;
  set isSignedIn(bool isSignedIn) {
    _isSignedIn = isSignedIn;
    notifyListeners();
  }

  bool _amplifyConfigured = false;
  bool get amplifyConfigured => _amplifyConfigured;
  set amplifyConfigured(bool amplifyConfigured) {
    _amplifyConfigured = amplifyConfigured;
    notifyListeners();
  }

  bool _isDialogueViewOpened = false;
  bool get isDialogueViewOpened => _isDialogueViewOpened;
  set isDialogueViewOpened(bool isDialogueViewOpened) {
    _isDialogueViewOpened = isDialogueViewOpened;
    notifyListeners();
  }

  bool _updatedCards = false;
  bool get updatedCards => _updatedCards;
  set updatedCards(bool updatedCards) {
    _updatedCards = updatedCards;
    notifyListeners();
  }

  dynamic _selectedKey = Constants.MYEVENTS;
  dynamic get selectedKey => _selectedKey;
  set selectedKey(dynamic selectedKey) {
    filteredObjects = [];
    _selectedKey = selectedKey;
    notifyListeners();
  }

  List _filteredObjects = [];
  List get filteredObjects => _filteredObjects;
  set filteredObjects(List filteredObjects) {
    print("filtered objects!");
    _filteredObjects = filteredObjects;
    notifyListeners();
  }

  bool _isFilteringEnabled = false;
  bool get isFilteringEnabled => _isFilteringEnabled;
  set isFilteringEnabled(bool isFilteringEnabled) {
    print("isFilteringEnabled! --> $isFilteringEnabled");
    _isFilteringEnabled = isFilteringEnabled;
    notifyListeners();
  }

  Map<dynamic, dynamic> _enabledSelections2 = {
    Constants.MYEVENTS: {
      "key": Constants.MYEVENTS,
      "enabled": false,
      "name": StringConstants.MYEVENTSTITLE,
      "description": "",
      "image": SVGWidgets().pickup(),      
      "showExplore": false,
      "showMyActivity": true,
    },
    // Constants.MYTEAMS: {
    //   "key": Constants.MYTEAMS,
    //   "enabled": false,
    //   "name": StringConstants.MYTEAMSTITLE,
    //   "description": "",
    //   "image": SVGWidgets().pickup(),
    //   "showExplore": false,
    //   "showMyActivity": true,
    // },
    Constants.MYGROUPS: {
      "key": Constants.MYGROUPS,
      "enabled": false,
      "name": StringConstants.MYGROUPSTITLE,
      "description": "",
      "image": SVGWidgets().pickup(),
      "showExplore": false,
      "showMyActivity": true,
    },
    Constants.REQUESTSSENT: {
      "key": Constants.REQUESTSSENT,
      "enabled": false,
      "name": StringConstants.REQUESTSSENTTITLE,
      "description": "",
      "image": SVGWidgets().pickup(),
      "showExplore": false,
      "showMyActivity": true,
    },
    Constants.REQUESTSRECEIVED: {
      "key": Constants.REQUESTSRECEIVED,
      "enabled": false,
      "name": StringConstants.REQUESTSRECEIVEDTITLE,
      "description": "",
      "image": SVGWidgets().pickup(),
      "showExplore": false,
      "showMyActivity": true,
    },
    Constants.PICKUP: {
      "key": Constants.PICKUP,
      "enabled": false,
      "name": StringConstants.PICKUPGAMESTITLE,
      "description": "",
      "image": SVGWidgets().pickup(),
      "showExplore": true,
      "showMyActivity": false,
    },
    // Constants.TOURNAMENT: {
    //   "key": Constants.TOURNAMENT,
    //   "enabled": false,
    //   "name": StringConstants.TOURNAMENTSTITLE,
    //   "description": "",
    //   "image": SVGWidgets().tournament(),
    //   "showExplore": true,
    //   "showMyActivity": false,
    // },
    // Constants.LEAGUE: {
    //   "key": Constants.LEAGUE,
    //   "enabled": false,
    //   "name": StringConstants.LEAGUESTITLE,
    //   "description": "",
    //   "image": SVGWidgets().league(),
    //   "showExplore": true,
    //   "showMyActivity": false,
    // },
    // Constants.PLAYER: {
    //   "key": Constants.PLAYER,
    //   "enabled": false,
    //   "name": StringConstants.PLAYERSTITLE,
    //   "description": "",
    //   "image": SVGWidgets().pickup(),
    //   "showExplore": true,
    //   "showMyActivity": false,
    // },
    // Constants.TEAM: {
    //   "key": Constants.TEAM,
    //   "enabled": false,
    //   "name": StringConstants.TEAMSTITLE,
    //   "description": "",
    //   "image": SVGWidgets().pickup(),
    //   "showExplore": true,
    //   "showMyActivity": false,
    // },
    Constants.GROUP: {
      "key": Constants.GROUP,
      "enabled": false,
      "name": StringConstants.GROUPSTITLE,
      "description": "",
      "image": SVGWidgets().pickup(),
      "showExplore": true,
      "showMyActivity": false,
    },
    // Constants.TRAINING: {
    //   "key": Constants.TRAINING,
    //   "enabled": false,
    //   "name": StringConstants.TRAININGSTITLE,
    //   "description": "",
    //   "image": SVGWidgets().training(),
    //   "showExplore": true,
    //   "showMyActivity": false,
    // },
    // Constants.TRYOUT: {
    //   "key": Constants.TRYOUT,
    //   "enabled": false,
    //   "name": StringConstants.TRYOUTSTITLE,
    //   "description": "",
    //   "image": SVGWidgets().tryout(),
    //   "showExplore": true,
    //   "showMyActivity": false,
    // },
    // Constants.LOCATION: {
    //   "key": Constants.LOCATION,
    //   "enabled": false,
    //   "name": StringConstants.LOCATIONSTITLE,
    //   "description": "",
    //   "image": SVGWidgets().pickup(),
    // },
  };

  Map<dynamic, dynamic> get enabledSelections2 => _enabledSelections2;
  set enabledSelections2(Map<dynamic, dynamic> enabledSelections2) {
    _enabledSelections2 = enabledSelections2;
    notifyListeners();
  }

  List _selectedObjects = [];
  List get selectedObjects => _selectedObjects;
  set selectedObjects(List selectedObjects) {
    print("set selected objects!");
    _selectedObjects = selectedObjects;
    notifyListeners();
  }

  List _cards = [];
  List get cards => _cards;
  set cards(List cards) {
    print("set homePageModel cards!");
    _cards = cards;
    notifyListeners();
  }

  List _userObjectSelections = [];
  List get userObjectSelections => _userObjectSelections;
  set userObjectSelections(List userObjectSelections) {
    print("set selected objects!");
    _userObjectSelections = userObjectSelections;
    notifyListeners();
  }
}
