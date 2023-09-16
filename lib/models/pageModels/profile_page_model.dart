import 'package:flutter/foundation.dart';

class ProfilePageModel extends ChangeNotifier {
  /////////////////
  dynamic _user = null;
  dynamic get user => _user;
  set user(dynamic user) {
    _user = user;
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
}
