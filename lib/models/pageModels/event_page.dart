
import 'package:flutter/foundation.dart';
import 'package:soccermadeeasy/extensions/parse_roles.dart';
import '../../commands/base_command.dart';
import '../../components/join_condition.dart';
import '../../strings.dart';
import 'package:soccermadeeasy/svg_widgets.dart';
import '../../constants.dart';
import '../appModels/Price.dart';
import '../enums/AmenityType.dart';

class EventPage extends ChangeNotifier {
  dynamic mainEvent = null;
  int _capacity = 0;
  int _fieldRating = 0;  
  int _hostRating = 0;  

  int get capacity => _capacity;
  set capacity(int newCapacity) {    
      _capacity = newCapacity;
      notifyListeners();
    
  }
  
  int get fieldRating => _fieldRating;
  set fieldRating(int newFieldRating) {    
      _fieldRating = newFieldRating;
      notifyListeners();
    
  }
  
  int get hostRating => _hostRating;
  set hostRating(int newHostRating) {
      _hostRating = newHostRating;
      notifyListeners();    
  }

    String _startTime = "";
  String get startTime => _startTime;
  set startTime(String startTime) {
    _startTime = startTime;        
    notifyListeners();
  }
  
  String _formattedEventTime = "";
  String get formattedEventTime => _formattedEventTime;
  set formattedEventTime(String formattedEventTime) {
    _formattedEventTime = formattedEventTime;        
    notifyListeners();
  }
  
  String _endTime = "";
  String get endTime => _endTime;
  set endTime(String endTime) {
    _endTime = endTime;        
    notifyListeners();
  }

  dynamic _objectImageInput = null;
  dynamic get objectImageInput => _objectImageInput;
  set objectImageInput(dynamic objectImageInput) {
    _objectImageInput = objectImageInput;        
    notifyListeners();
  }
  
  dynamic _league = null;
  dynamic get league => _league;
  set league(dynamic league) {
    _league = league;    
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

  String _location = "";
  String get location => _location;
  set location(String location) {
    _location = location;
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

  dynamic _groupStage = [];
  dynamic get groupStage => _groupStage;
  set groupStage(dynamic groupStage) {
    _groupStage = groupStage;
    notifyListeners();
  }

  dynamic _tournamentStage = [];
  dynamic get tournamentStage => _tournamentStage;
  set tournamentStage(dynamic tournamentStage) {
    _tournamentStage = tournamentStage;
    notifyListeners();
  }
  
  dynamic _tournament = {};
  dynamic get tournament => _tournament;
  set tournament(dynamic tournament) {
    _tournament = tournament;
    notifyListeners();
  }

  List _userParticipants = [];
  List get userParticipants => _userParticipants;
  set userParticipants(List userParticipants) {
    _userParticipants = userParticipants;
    notifyListeners();
  }

  List _payments = [];
  List get payments => _payments;
  set payments(List payments) {
    _payments = payments;
    notifyListeners();
  }

  List _fieldLocations = [];
  List get fieldLocations => _fieldLocations;
  set fieldLocations(List fieldLocations) {
    _fieldLocations = fieldLocations;
    notifyListeners();
  }  
  
  JoinCondition _eventRequestJoin =  JoinCondition(label: "");
  JoinCondition get eventRequestJoin => _eventRequestJoin;
  set eventRequestJoin(JoinCondition eventRequestJoin) {
    _eventRequestJoin = eventRequestJoin;
    notifyListeners();
  }
  JoinCondition _eventPaymentJoin =  JoinCondition(label: "");
  JoinCondition get eventPaymentJoin => _eventPaymentJoin;
  set eventPaymentJoin(JoinCondition eventPaymentJoin) {
    _eventPaymentJoin = eventPaymentJoin;
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

  int _eventRating = 0;
  int get eventRating => _eventRating;
  set eventRating(int eventRating) {
    _eventRating = eventRating;
    notifyListeners();
  }

  
  int _fieldLocationRating = 0;
  int get fieldLocationRating => _fieldLocationRating;
  set fieldLocationRating(int fieldLocationRating) {
    _fieldLocationRating = fieldLocationRating;
    notifyListeners();
  }
  
  int _numberOfFieldLocationRatings = 0;
  int get numberOfFieldLocationRatings => _numberOfFieldLocationRatings;
  set numberOfFieldLocationRatings(int numberOfFieldLocationRatings) {
    _numberOfFieldLocationRatings = numberOfFieldLocationRatings;
    notifyListeners();
  }
  
  int _numberOfRatings = 0;
  int get numberOfRatings => _numberOfRatings;
  set numberOfRatings(int numberOfRatings) {
    _numberOfRatings = numberOfRatings;
    notifyListeners();
  }
  
  int _numberOfParticipants = 0;
  int get numberOfParticipants => _numberOfParticipants;
  set numberOfParticipants(int numberOfParticipants) {
    _numberOfParticipants = numberOfParticipants;
    notifyListeners();
  }
  
  //everything to do with field
  List<String> _fieldAmenities = [];
  List<String> get fieldAmenities => _fieldAmenities;
  set fieldAmenities(List<String> fieldAmenities) {
    _fieldAmenities = fieldAmenities;
    notifyListeners();
  }  
  
  //things like pips, cones, water, food, etc
  List<String> _hostAmenities = [];
  List<String> get hostAmenities => _hostAmenities;
  set hostAmenities(List<String> hostAmenities) {
    _hostAmenities = hostAmenities;
    notifyListeners();
  }  
  
}

