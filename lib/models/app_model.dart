import 'dart:ffi';

import 'package:flutter/foundation.dart';
import 'package:faunadb_http/faunadb_http.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:twilio_flutter/twilio_flutter.dart';

class AppModel extends ChangeNotifier {

  
  // FaunaClient _faunaClient = FaunaClient(FaunaConfig.build(
  //     secret: 'fnAEvcFslGACTyx_6wrw7CVbXYEYrgGj34EfXpFN',
  //     domain: 'db.fauna.com'
  //   ));

  // FaunaClient get faunaClient => _faunaClient;

  ValueNotifier<GraphQLClient>? _faunaClient = null;
  ValueNotifier<GraphQLClient> get faunaClient => _faunaClient!;
  set faunaClient(ValueNotifier<GraphQLClient> faunaClient) {
    _faunaClient = faunaClient;
    notifyListeners();
  }
  
  TwilioFlutter? _twilioClient = null;
  TwilioFlutter get twilioClient => _twilioClient!;
  set twilioClient(TwilioFlutter twilioClient) {
    _twilioClient = twilioClient;
    notifyListeners();
  }

  bool _onesignalUserDetailsSetup = false;
  bool get onesignalUserDetailsSetup => _onesignalUserDetailsSetup;
  set onesignalUserDetailsSetup(bool onesignalUserDetailsSetup){
    _onesignalUserDetailsSetup = onesignalUserDetailsSetup;
    notifyListeners();
  } 
  
  
  

  Map<String, dynamic> _currentUser = {};
  Map<String, dynamic> get currentUser => _currentUser;
  set currentUser(Map<String, dynamic> currentUser) {
    _currentUser = currentUser;
    notifyListeners();
  }

  

  

  bool _initialConditionsMet = false;
  bool get initialConditionsMet => _initialConditionsMet;
  set initialConditionsMet(bool initialConditionsMet){
    _initialConditionsMet = initialConditionsMet;
    notifyListeners();
  }  



  bool _amplifyConfigured = false;
  bool get amplifyConfigured => _amplifyConfigured;
  set amplifyConfigured(bool amplifyConfigured){
    _amplifyConfigured = amplifyConfigured;
    notifyListeners();
  }


  bool _isSignedIn = false;
  bool get isSignedIn => _isSignedIn;
  set isSignedIn(bool isSignedIn){
    _isSignedIn = isSignedIn;
    notifyListeners();
  }

  List _players = [];
  List get players => _players;
  set players(List players) {
    _players = players;
    notifyListeners();
  }

  List _teams = [];
  List get teams => _teams;
  set teams(List teams) {
    _teams = teams;
    notifyListeners();
  }
  
  List _friends = [];
  List get friends => _friends;
  set friends(List friends) {
    _friends = friends;
    notifyListeners();
  }
  
  List _myEvents = [];
  List get myEvents => _myEvents;
  set myEvents(List myEvents) {
    _myEvents = myEvents;
    notifyListeners();
  }
}