import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:geolocator/geolocator.dart';

import '../../commands/home_page_command.dart';
import '../../constants.dart';
import '../../strings.dart';
import '../../svg_widgets.dart';
import '../../views/game/create.dart';
import '../../views/group/create/create.dart';
import '../../views/home.dart';
import '../../views/league/create.dart';
import '../../views/location/create.dart';
import '../../views/location/map.dart';
import '../../views/team/create/create.dart';
import '../../views/tournament/create.dart';
import '../../views/training/create.dart';
import '../../views/tryout/create.dart';
import '../appModels/Location.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

class AppModel extends ChangeNotifier {
  late Timer _timer; // Declare the Timer
  double _appTimeSinceLastLoad = 0;

  double get appTimeSinceLastLoad => _appTimeSinceLastLoad;
  // Setter remains the same if you still need to set this value manually
  set appTimeSinceLastLoad(double appTimeSinceLastLoad) {
    _appTimeSinceLastLoad = appTimeSinceLastLoad;
    // print("_appTimeSinceLastLoad: $_appTimeSinceLastLoad");
    if(_appTimeSinceLastLoad == 300){
      print("in appTimeSinceLastLoad == 300");
      this.shouldReloadEvents = true;

    }
    notifyListeners();
  }

  // Function to start the timer
 void startTimer() {
  print("startTimer!!");
  _timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
    appTimeSinceLastLoad = _appTimeSinceLastLoad + 1.0; // Using the setter to update _appTimeSinceLastLoad
  });
}

  // Function to stop the timer
  void stopTimer() {
    _timer.cancel();
  }
  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  bool _shouldReloadEvents = false;
  bool get shouldReloadEvents => _shouldReloadEvents;
  set shouldReloadEvents(bool shouldReloadEvents) {
    _shouldReloadEvents = shouldReloadEvents;
    notifyListeners();
  }

  void nukeModelData() {}

  onTapBottomNav(context, key, item){
    selectedPages.forEach((otherKey, otherItem) {
            if (otherKey == key) {
              otherItem['enabled'] = true;
            } else {
              otherItem['enabled'] = false;
            }
          });
          item['selectAction'](context);
          item['enabled'] = true;
      print("selectedPages on Tap: $selectedPages");
  }

  Map<String, Widget Function(BuildContext)> createPages = {
    "Pickup Game": (context) => const GameCreate(),
    "Group": (context) => const GroupCreate(),
    // "Team": (context) => const TeamCreate(),
    // "Tournament": (context) => const TournamentCreate(),
    // "League": (context) => const LeagueCreate(),
    // "Training": (context) => const TrainingCreate(),
    // "Tryout": (context) => const TryoutCreate(),
    "Location": (context) => const LocationCreate(),
  };

  Map<dynamic, dynamic> _selectedPages = {
    Constants.HOMEPAGE: {
      "key": Constants.HOMEPAGE,
      "enabled": true,
      "name": StringConstants.HOMEPAGETITLE,
      "description": "",
      'icon': Icons.blur_circular_sharp,
      'selectAction': (BuildContext context) async {
        print("in selectAction");
        await HomePageCommand().eventTypeTapped(Constants.PICKUP);
        await HomePageCommand().setCards();
      },
    },
    Constants.MYEVENTS: {
      "key": Constants.MYEVENTS,
      "enabled": false,
      "name": "My Activity",
      "description": "",
      'icon': Icons.wheelchair_pickup,
      'selectAction': (BuildContext context) async{
        print("in selectAction");
        await HomePageCommand().eventTypeTapped(Constants.MYEVENTS);
        await HomePageCommand().setCards();
      },
    },
   
    // Constants.LOCATIONSPAGE: {
    //   "key": Constants.LOCATIONSPAGE,
    //   "enabled": false,
    //   "name": StringConstants.LOCATIONSPAGETITLE,
    //   "description": "",
    //   'icon': Icons.location_on,
    //   'selectAction': (BuildContext context) {
    //   },
    // },
    
  };
  Map<dynamic, dynamic> get selectedPages => _selectedPages;
  set selectedPages(Map<dynamic, dynamic> selectedPages) {
    _selectedPages = selectedPages;
    notifyListeners();
  }

  List<Svg> locationSvgs = [
    SVGWidgets().getSoccerBallSVGImage(),
    SVGWidgets().deleteSVGImage(),
    SVGWidgets().friendsSVGImage(),
  ];

  List<Svg> priceSvgs = [
    SVGWidgets().getSoccerBallSVGImage(),
    SVGWidgets().deleteSVGImage(),
    SVGWidgets().deleteSVGImage(),
  ];

  ValueNotifier<GraphQLClient>? _faunaClient = null;
  ValueNotifier<GraphQLClient> get faunaClient => _faunaClient!;
  set faunaClient(ValueNotifier<GraphQLClient> faunaClient) {
    _faunaClient = faunaClient;
    notifyListeners();
  }

  String _appColorMode = Constants.DEFAULTMODE;
  String get appColorMode => _appColorMode;
  set appColorMode(String appColorMode) {
    _appColorMode = appColorMode;
    notifyListeners();
  }

  bool _onesignalUserDetailsSetup = false;
  bool get onesignalUserDetailsSetup => _onesignalUserDetailsSetup;
  set onesignalUserDetailsSetup(bool onesignalUserDetailsSetup) {
    _onesignalUserDetailsSetup = onesignalUserDetailsSetup;
    notifyListeners();
  }

  int _distanceFilter = 200;
  int get distanceFilter => _distanceFilter;
  set distanceFilter(int distanceFilter) {
    _distanceFilter = distanceFilter;
    notifyListeners();
  }

  Map<String, dynamic> _currentUser = {};
  Map<String, dynamic> get currentUser => _currentUser;
  set currentUser(Map<String, dynamic> currentUser) {
    _currentUser = currentUser;
    notifyListeners();
  }

  Position _currentPosition = const Position(
    longitude: 0,
    latitude: 0,
    timestamp: null,
    accuracy: 0,
    altitude: 0,
    heading: 0,
    speed: 0,
    speedAccuracy: 0,
  );
  Position get currentPosition => _currentPosition;
  set currentPosition(Position currentPosition) {
    _currentPosition = currentPosition;
    notifyListeners();
  }

  bool _userConditionsMet = false;
  bool get userConditionsMet => _userConditionsMet;
  set userConditionsMet(bool userConditionsMet) {
    _userConditionsMet = userConditionsMet;
    notifyListeners();
  }
 
 

  bool _onboarded = false;
  bool get onboarded => _onboarded;
  set onboarded(bool onboarded) {
    _onboarded = onboarded;
    notifyListeners();
  }

  bool _initialConditionsMet = false;
  bool get initialConditionsMet => _initialConditionsMet;
  set initialConditionsMet(bool initialConditionsMet) {
    _initialConditionsMet = initialConditionsMet;
    notifyListeners();
  }

  bool _amplifyConfigured = false;
  bool get amplifyConfigured => _amplifyConfigured;
  set amplifyConfigured(bool amplifyConfigured) {
    _amplifyConfigured = amplifyConfigured;
    notifyListeners();
  }

  bool _isGuest = false;
  bool get isGuest => _isGuest;
  set isGuest(bool isGuest) {
    _isGuest = isGuest;
    notifyListeners();
  }
  
  bool _isRatingDialogueShowing = false;
  bool get isRatingDialogueShowing => _isRatingDialogueShowing;
  set isRatingDialogueShowing(bool isRatingDialogueShowing) {
    _isRatingDialogueShowing = isRatingDialogueShowing;
    notifyListeners();
  }

  bool _isSignedIn = false;
  bool get isSignedIn => _isSignedIn;
  set isSignedIn(bool isSignedIn) {
    _isSignedIn = isSignedIn;
    notifyListeners();
  }

  List _players = [];
  List get players => _players;
  set players(List players) {
    _players = players;
    notifyListeners();
  }

  List _playersNearMe = [];
  List get playersNearMe => _playersNearMe;
  set playersNearMe(List playersNearMe) {
    _playersNearMe = playersNearMe;
    notifyListeners();
  }

  List _teams = [];
  List get teams => _teams;
  set teams(List teams) {
    _teams = teams;
    notifyListeners();
  }

  List _groups = [];
  List get groups => _groups;
  set groups(List groups) {
    _groups = groups;
    notifyListeners();
  }

  List _myTeams = [];
  List get myTeams => _myTeams;
  set myTeams(List myTeams) {
    _myTeams = myTeams;
    notifyListeners();
  }

  List _myGroups = [];
  List get myGroups => _myGroups;
  set myGroups(List myGroups) {
    _myGroups = myGroups;
    notifyListeners();
  }

  List _friends = [];
  List get friends => _friends;
  set friends(List friends) {
    _friends = friends;
    notifyListeners();
  }

  List<Location> _facilityLocations = [];
  List<Location> get facilityLocations => _facilityLocations;
  set facilityLocations(List<Location> facilityLocations) {
    _facilityLocations = facilityLocations;
    notifyListeners();
  }

  List<Location> _locations = [];
  List<Location> get locations => _locations;
  set locations(List<Location> locations) {
    _locations = locations;
    notifyListeners();
  }

  List _myEvents = [];
  List get myEvents => _myEvents;
  set myEvents(List myEvents) {
    _myEvents = myEvents;
    notifyListeners();
  }

  List _myArchivedEvents = [];
  List get myArchivedEvents => _myArchivedEvents;
  set myArchivedEvents(List myArchivedEvents) {
    _myArchivedEvents = myArchivedEvents;
    notifyListeners();
  }

  dynamic _userEventDetails = [];
  dynamic get userEventDetails => _userEventDetails;
  set userEventDetails(dynamic userEventDetails) {
    print("in AppModel() set userEventDetails");
    _userEventDetails = userEventDetails;
    notifyListeners();
  }
}
