import 'package:flutter/foundation.dart';
import 'package:soccermadeeasy/extensions/parse_roles.dart';
import '../../strings.dart';
import 'package:soccermadeeasy/svg_widgets.dart';
import '../../constants.dart';
import '../appModels/Price.dart';

class EventPageModel extends ChangeNotifier {  

  
  dynamic _objectImageInput = null;
  dynamic get objectImageInput => _objectImageInput;
  set objectImageInput(dynamic objectImageInput) {
    _objectImageInput = objectImageInput;    
    print("notify listeners objectImageInput: " + objectImageInput.toString());
    notifyListeners();
  }
  
  dynamic _mainEvent = null;
  dynamic get mainEvent => _mainEvent;
  set mainEvent(dynamic mainEvent) {
    _mainEvent = mainEvent;
    _updateFieldsBasedOnMainEvent();
    notifyListeners();
  }

  dynamic _paymentData = null;
  dynamic get paymentData => _paymentData;
  set paymentData(dynamic paymentData) {
    _paymentData = paymentData;
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
    _amountRemaining = amountRemaining;
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

  List _allEvents = [];
  List get allEvents => _allEvents;
  set allEvents(List allEvents) {
    _allEvents = allEvents;
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

  String _currentUserId = "";
  String get currentUserId => _currentUserId;
  set currentUserId(String currentUserId) {
    _currentUserId = currentUserId;
    notifyListeners();
  }

  List _payments = [];
  List get payments => _payments;
  set payments(List payments) {
    _payments = payments;
    notifyListeners();
  }

  void _updateFieldsBasedOnMainEvent() {
    if (_mainEvent != null) {
      userParticipants = _mainEvent['userParticipants']['data'];
      roles = _getEventRoles();
      isMine = roles.contains("ORGANIZER");
      isMember = roles.contains("PLAYER");
      chats = _mainEvent['chats']['data'];
      teams = _mainEvent['teams']['data'];
      _getParticipants();
      payments = _mainEvent['payments']['data'];
      _getAmountPaid();
      price = _mainEvent['price'];
    }
  }

  List<dynamic> _getEventRoles() {
    List<dynamic> tempRoles = [];

    for (int i = 0; i < userParticipants.length; i++) {
      if (userParticipants[i]['user']['_id'] == currentUserId) {
        tempRoles = userParticipants[i]['roles'].toString().parseRoles();
      }
    }

    return tempRoles;
  }

  void _getParticipants() {
    List<dynamic> tempOrganizers = [];
    List<dynamic> tempPlayers = [];

    for (int i = 0; i < userParticipants.length; i++) {
      dynamic participant = userParticipants[i];
      List<String> roles = participant['roles'].toString().parseRoles();
      if (roles.contains("ORGANIZER")) {
        tempOrganizers.add(userParticipants);
      }
      if (roles.contains("PLAYER")) {
        tempPlayers.add(userParticipants);
      }
    }

    organizers = tempOrganizers;
    players = tempPlayers;
  }

  void _getAmountPaid() {
    if (price == null) return;

    double tempAmountPaid = 0.00;
    double tempTeamAmountPaid = 0.00;

    for (int i = 0; i < payments.length; i++) {
      if (payments[i]['user']['_id'] == currentUserId) {
        if (payments[i]['isPlayerPayment']) {
          tempAmountPaid += double.parse(payments[i]['amount']);
        } else if (payments[i]['isTeamPayment']) {
          tempTeamAmountPaid += double.parse(payments[i]['amount']);
        }
      }
    }
    amountPaid = (tempAmountPaid).toStringAsFixed(2);
    teamAmountPaid = (tempTeamAmountPaid).toStringAsFixed(2);
    amountRemaining =
        (double.parse(mainEvent['price']['amount']) - tempAmountPaid)
            .toStringAsFixed(2);
    teamAmountRemaining =
        (double.parse(mainEvent['price']['teamAmount']) - tempTeamAmountPaid)
            .toStringAsFixed(2);
  }
}
