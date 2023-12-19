import 'package:flutter/foundation.dart';

class ProfilePageModel extends ChangeNotifier {
  
  dynamic _user = null;
  dynamic get user => _user;
  set user(dynamic user) {
    _user = user;
    notifyListeners();
  }

  bool _isMine = false;
  bool get isMine => _isMine;
  set isMine(bool isMine) {
    _isMine = isMine;
    notifyListeners();
  }

  bool _isProfilePrivate = false;
  bool get isProfilePrivate => _isProfilePrivate;
  set isProfilePrivate(bool isProfilePrivate) {
    _isProfilePrivate = isProfilePrivate;
    notifyListeners();
  }

  dynamic _objectImageInput = null;
  dynamic get objectImageInput => _objectImageInput;
  set objectImageInput(dynamic objectImageInput) {
    _objectImageInput = objectImageInput;
    notifyListeners();
  }

  List _followers = [];
  List get followers => _followers;
  set followers(List followers) {
    _followers = followers;
    notifyListeners();
  }

  List _following = [];
  List get following => _following;
  set following(List following) {
    _following = following;
    notifyListeners();
  }

  List _eventUserParticipants = [];
  List get eventUserParticipants => _eventUserParticipants;
  set eventUserParticipants(List eventUserParticipants) {
    _eventUserParticipants = eventUserParticipants;
    notifyListeners();
  }

  List _teamUserParticipants = [];
  List get teamUserParticipants => _teamUserParticipants;
  set teamUserParticipants(List teamUserParticipants) {
    _teamUserParticipants = teamUserParticipants;
    notifyListeners();
  }
  
  List _teams = [];
  List get teams => _teams;
  set teams(List teams) {
    _teams = teams;
    notifyListeners();
  }
  
  List _events = [];
  List get events => _events;
  set events(List events) {
    _events = events;
    notifyListeners();
  }

  List _teamCards = [];
  List get teamCards => _teamCards;
  set teamCards(List teamCards) {
    print("set profilePageModel teamCards!");
    _teamCards = teamCards;
    notifyListeners();
  }
   
  List _eventCards = [];
  List get eventCards => _eventCards;
  set eventCards(List eventCards) {
    print("set profilePageModel eventCards!");
    _eventCards = eventCards;
    notifyListeners();
  }

  bool _teamCardsLoading = true;
  bool get teamCardsLoading => _teamCardsLoading;
  set teamCardsLoading(bool teamCardsLoading) {
    _teamCardsLoading = teamCardsLoading;
    notifyListeners();
  }
  
  bool _eventCardsLoading = true;
  bool get eventCardsLoading => _eventCardsLoading;
  set eventCardsLoading(bool eventCardsLoading) {
    _eventCardsLoading = eventCardsLoading;
    notifyListeners();
  }
  
  int _age = 0;
  int get age => _age;
  set age(int age) {
    _age = age;
    notifyListeners();
  }
  
  String _formattedLocation = "";
  String get formattedLocation => _formattedLocation;
  set formattedLocation(String formattedLocation) {
    _formattedLocation = formattedLocation;
    notifyListeners();
  }


}
