import 'package:flutter/foundation.dart';
import '../strings.dart';
import 'package:soccermadeeasy/svg_widgets.dart';
import '../constants.dart';



class EventPageModel extends ChangeNotifier {
  dynamic _mainEvent = null;
  dynamic get mainEvent => _mainEvent;
  set mainEvent(dynamic mainEvent) {
    _mainEvent = mainEvent;
    notifyListeners();
  }
  
  bool _isMine = false;
  bool get isMine => _isMine;
  set isMine(bool isMine) {
    _isMine = isMine;
    notifyListeners();
  }
  
  bool _isMember = false;
  bool get isMember => _isMember;
  set isMember(bool isMember) {
    _isMember = isMember;
    notifyListeners();
  }
  
  String _amountPaid = "0.00";
  String get amountPaid => _amountPaid;
  set amountPaid(String amountPaid) {
    _amountPaid = amountPaid;
    notifyListeners();
  }
  
  String _amountRemaining = "0.00";
  String get amountRemaining => _amountRemaining;
  set amountRemaining(String amountRemaining) {
    _amountPaid = amountRemaining;
    notifyListeners();
  }
 
  String _teamAmountPaid = "0.00";
  String get teamAmountPaid => _teamAmountPaid;
  set teamAmountPaid(String teamAmountPaid) {
    _teamAmountPaid = teamAmountPaid;
    notifyListeners();
  }
  
  String _teamAmountRemaining = "0.00";
  String get teamAmountRemaining => _teamAmountRemaining;
  set teamAmountRemaining(String teamAmountRemaining) {
    _teamAmountRemaining = teamAmountRemaining;
    notifyListeners();
  }
  
  dynamic _price = {};
  dynamic get price => _price;
  set price(dynamic price) {
    _price = price;
    notifyListeners();
  }

  List _players = [];
  List get players => _players;
  set players(List players) {
    _players = players;
    notifyListeners();
  }
   
  
  List _organizers = [];
  List get organizers => _organizers;
  set organizers(List organizers) {
    _organizers = organizers;
    notifyListeners();
  }
  
  List _teams = [];
  List get teams => _teams;
  set teams(List teams) {
    _teams = teams;
    notifyListeners();
  }
  
  List _roles = [];
  List get roles => _roles;
  set roles(List roles) {
    _roles = roles;
    notifyListeners();
  }
  
  List _chats = [];
  List get chats => _chats;
  set chats(List chats) {
    _chats = chats;
    notifyListeners();
  }
  
  List _groupStage = [];
  List get groupStage => _groupStage;
  set groupStage(List groupStage) {
    _groupStage = groupStage;
    notifyListeners();
  }
  
  List _tournamentStage = [];
  List get tournamentStage => _tournamentStage;
  set tournamentStage(List tournamentStage) {
    _tournamentStage = tournamentStage;
    notifyListeners();
  }
  
  List _userParticipants = [];
  List get userParticipants => _userParticipants;
  set userParticipants(List userParticipants) {
    _userParticipants = userParticipants;
    notifyListeners();
  }

  

}
