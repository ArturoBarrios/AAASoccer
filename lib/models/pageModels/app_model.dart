import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:geolocator/geolocator.dart';

import '../../constants.dart';
import '../../strings.dart';
import '../../svg_widgets.dart';
import '../../views/home.dart';
import '../../views/location/map.dart';
import '../appModels/Location.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

class AppModel extends ChangeNotifier {
  void nukeModelData() {}

    
    Map<dynamic, dynamic> _selectedPages = {
      Constants.HOMEPAGE: {
        "key": Constants.HOMEPAGE,
        "enabled": true,
        "name": StringConstants.HOMEPAGETITLE,
        "description": "",      
        'icon': Icons.home,   
        'selectAction': (BuildContext context) {
          print("in selectAction");
          Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) {
                return const Home();
              },
            ),
          );
        },     
      },
      Constants.LOCATIONSPAGE: {
        "key": Constants.LOCATIONSPAGE,
        "enabled": false,
        "name": StringConstants.LOCATIONSPAGETITLE,
        "description": "",
        'icon': Icons.location_on,
        'selectAction': (BuildContext context) {
          print("in selectAction");
          Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) {
                return const LocationsMap();
              },
            ),
          );
        }, 
      },
      Constants.CHATSPAGE: {
        "key": Constants.CHATSPAGE,
        "enabled": false,
        "name": StringConstants.CHATSPAGETITLE,
        "description": "",
        'icon': Icons.chat,
        'selectAction': (BuildContext context) {
          print("in selectAction");
          Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) {
                return const Home();
              },
            ),
          );
        }, 
      },
      Constants.SCHEDULEPAGE: {
        "key": Constants.SCHEDULEPAGE,
        "enabled": false,
        "name": StringConstants.SCHEDULEPAGETITLE,
        "description": "",
        "icon": Icons.calendar_month_outlined,
        'selectAction': (BuildContext context) {
          print("in selectAction");
          Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) {
                return const Home();
              },
            ),
          );
        }, 
      },
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

  List _myTeams = [];
  List get myTeams => _myTeams;
  set myTeams(List myTeams) {
    _myTeams = myTeams;
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
