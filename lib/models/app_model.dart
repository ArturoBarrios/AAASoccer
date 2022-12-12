import 'dart:ffi';

import 'package:flutter/foundation.dart';
import 'package:faunadb_http/faunadb_http.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class AppModel extends ChangeNotifier {

  
  // FaunaClient _faunaClient = FaunaClient(FaunaConfig.build(
  //     secret: 'fnAEvcFslGACTyx_6wrw7CVbXYEYrgGj34EfXpFN',
  //     domain: 'db.fauna.com'
  //   ));

  // FaunaClient get faunaClient => _faunaClient;

  ValueNotifier<GraphQLClient>? _faunaClient = null;
  ValueNotifier<GraphQLClient> get faunaClient => _faunaClient!;
  

  Map<String, dynamic> _currentUser = {};
  Map<String, dynamic> get currentUser => _currentUser;
  set currentUser(Map<String, dynamic> currentUser) {
    _currentUser = currentUser;
    notifyListeners();
  }
  
  bool _isSignedIn = false;
  bool get isSignedIn => _isSignedIn;

  bool _amplifyConfigured = false;
  bool get amplifyConfigured => _amplifyConfigured;

  bool _initialConditionsMet = false;
  bool get initialConditionsMet => _initialConditionsMet;
  

  set initialConditionsMet(bool initialConditionsMet){
    _initialConditionsMet = initialConditionsMet;
    notifyListeners();
  }  

  set faunaClient(ValueNotifier<GraphQLClient> faunaClient) {
    _faunaClient = faunaClient;
    notifyListeners();
  }

  set amplifyConfigured(bool amplifyConfigured){
    _amplifyConfigured = amplifyConfigured;
    notifyListeners();
  }


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
}