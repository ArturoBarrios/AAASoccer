import 'package:flutter/foundation.dart';

import '../../components/join_condition.dart';

class TeamPageModel extends ChangeNotifier {
  dynamic _team = null;
  dynamic get team => _team;
  set team(dynamic team) {
    _team = team;
    notifyListeners();
  }

  /////////////////
  dynamic _payments = null;
  dynamic get payments => _payments;
  set payments(dynamic payments) {
    _payments = payments;
    notifyListeners();
  }

  /////////////////
  bool _isMine = false;
  bool get isMine => _isMine;
  set isMine(bool isMine) {
    _isMine = isMine;
    notifyListeners();
  }

  /////////////////
  bool _isMember = false;
  bool get isMember => _isMember;
  set isMember(bool isMember) {
    _isMember = isMember;
    notifyListeners();
  }

  /////////////////
  String _amountPaid = "0.00";
  String get amountPaid => _amountPaid;
  set amountPaid(String amountPaid) {
    _amountPaid = amountPaid;
    notifyListeners();
  }

  /////////////////
  String _amountRemaining = "0.00";
  String get amountRemaining => _amountRemaining;
  set amountRemaining(String amountRemaining) {
    _amountPaid = amountRemaining;
    notifyListeners();
  }

  /////////////////
  dynamic _price = {};
  dynamic get price => _price;
  set price(dynamic price) {
    _price = price;
    notifyListeners();
  }

  /////////////////
  List _players = [];
  List get players => _players;
  set players(List players) {
    _players = players;
    notifyListeners();
  }

  /////////////////
  List _organizers = [];
  List get organizers => _organizers;
  set organizers(List organizers) {
    _organizers = organizers;
    notifyListeners();
  }

  /////////////////
  List _roles = [];
  List get roles => _roles;
  set roles(List roles) {
    _roles = roles;
    notifyListeners();
  }

  /////////////////
  List _chats = [];
  List get chats => _chats;
  set chats(List chats) {
    _chats = chats;
    notifyListeners();
  }

  /////////////////
  List _userParticipants = [];
  List get userParticipants => _userParticipants;
  set userParticipants(List userParticipants) {
    _userParticipants = userParticipants;
    notifyListeners();
  }
  
  List _teamLocations = [];
  List get teamLocations => _teamLocations;
  set teamLocations(List teamLocations) {
    _teamLocations = teamLocations;
    notifyListeners();
  }

  JoinCondition _teamRequestJoin =  JoinCondition(label: "");
  JoinCondition get teamRequestJoin => _teamRequestJoin;
  set teamRequestJoin(JoinCondition teamRequestJoin) {
    _teamRequestJoin = teamRequestJoin;
    notifyListeners();
  }
  JoinCondition _teamPaymentJoin =  JoinCondition(label: "");
  JoinCondition get teamPaymentJoin => _teamPaymentJoin;
  set teamPaymentJoin(JoinCondition teamPaymentJoin) {
    _teamPaymentJoin = teamPaymentJoin;
    notifyListeners();
  }


}
