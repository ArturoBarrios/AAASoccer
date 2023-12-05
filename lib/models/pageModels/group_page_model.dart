import 'package:flutter/foundation.dart';

import '../../components/join_condition.dart';

class GroupPageModel extends ChangeNotifier {
  dynamic _group = null;
  dynamic get group => _group;
  set group(dynamic group) {
    _group = group;
    notifyListeners();
  }

  /////////////////
  List _payments = [];
  List get payments => _payments;
  set payments(List payments) {
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
  
  List _groupLocations = [];
  List get groupLocations => _groupLocations;
  set groupLocations(List groupLocations) {
    _groupLocations = groupLocations;
    notifyListeners();
  }

  JoinCondition _groupRequestJoin =  JoinCondition(label: "");
  JoinCondition get groupRequestJoin => _groupRequestJoin;
  set groupRequestJoin(JoinCondition groupRequestJoin) {
    _groupRequestJoin = groupRequestJoin;
    notifyListeners();
  }
  JoinCondition _groupPaymentJoin =  JoinCondition(label: "");
  JoinCondition get groupPaymentJoin => _groupPaymentJoin;
  set groupPaymentJoin(JoinCondition groupPaymentJoin) {
    _groupPaymentJoin = groupPaymentJoin;
    notifyListeners();
  }


}
