import 'dart:ffi';

import 'package:flutter/foundation.dart';
import '../strings.dart';
import 'package:soccermadeeasy/svg_widgets.dart';


class EventsModel extends ChangeNotifier {

  

  List _events = [];
  List get events => _events;
  set events(List events) {
    _events = events;
    notifyListeners();
  }


  List _eventsNearMe = [];
  List get eventsNearMe => _eventsNearMe;
  set eventsNearMe(List eventsNearMe) {
    _eventsNearMe = eventsNearMe;
    notifyListeners();
  }

  List<dynamic> _games = [];
  List<dynamic> get games => _games;
  set games(List<dynamic> games) {
    _games = games;
    notifyListeners();
  }

  List<dynamic> _archivedGames = [];
  List<dynamic> get archivedGames => _archivedGames;
  set archivedGames(List<dynamic> archivedGames) {
    _archivedGames = archivedGames;
    notifyListeners();
  }
  
  List<dynamic> _gamesNearMe = [];
  List<dynamic> get gamesNearMe => _gamesNearMe;
  set gamesNearMe(List<dynamic> gamesNearMe) {
    _gamesNearMe = gamesNearMe;
    notifyListeners();
  }

  List _trainings = [];
  List get trainings => _trainings;
  set trainings(List trainings) {
    _trainings = trainings;
    notifyListeners();
  }
  
  List _trainingsNearMe = [];
  List get trainingsNearMe => _trainingsNearMe;
  set trainingsNearMe(List trainingsNearMe) {
    _trainingsNearMe = trainingsNearMe;
    notifyListeners();
  }

  List _tryouts = [];
  List get tryouts => _tryouts;
  set tryouts(List tryouts) {
    _tryouts = tryouts;
    notifyListeners();
  }
  
  List _tryoutsNearMe = [];
  List get tryoutsNearMe => _tryoutsNearMe;
  set tryoutsNearMe(List tryoutsNearMe) {
    _tryoutsNearMe = tryoutsNearMe;
    notifyListeners();
  }
  
  List _tournaments = [];
  List get tournaments => _tournaments;
  set tournaments(List tournaments) {
    _tournaments = tournaments;
    notifyListeners();
  }
  
  List _tournamentsNearMe = [];
  List get tournamentsNearMe => _tournamentsNearMe;
  set tournamentsNearMe(List tournamentsNearMe) {
    _tournamentsNearMe = tournamentsNearMe;
    notifyListeners();
  }
  
  List _leagues = [];
  List get leagues => _leagues;
  set leagues(List leagues) {
    _leagues = leagues;
    notifyListeners();
  }
  
  List _leaguesNearMe = [];
  List get leaguesNearMe => _leaguesNearMe;
  set leaguesNearMe(List leaguesNearMe) {
    _leaguesNearMe = leaguesNearMe;
    notifyListeners();
  }

  Map<String, List> _mappedEvents = {};
  Map<String, List> get mappedEvents => _mappedEvents;
  set mappedEvents(Map<String, List> mappedEvents) {
    _mappedEvents = mappedEvents;
    notifyListeners();
  }

  
  
}