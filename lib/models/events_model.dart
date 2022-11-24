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

  List<dynamic> _games = [];
  List<dynamic> get games => _games;
  set games(List<dynamic> games) {
    _games = games;
    notifyListeners();
  }

  List _trainings = [];
  List get trainings => _trainings;
  set trainings(List trainings) {
    _trainings = trainings;
    notifyListeners();
  }

  List _tryouts = [];
  List get tryouts => _tryouts;
  set tryouts(List tryouts) {
    _tryouts = tryouts;
    notifyListeners();
  }
  
  List _tournaments = [];
  List get tournaments => _tournaments;
  set tournaments(List tournaments) {
    _tournaments = tournaments;
    notifyListeners();
  }
  
  List _leagues = [];
  List get leagues => _leagues;
  set leagues(List leagues) {
    _leagues = leagues;
    notifyListeners();
  }

  Map<String, List> _mappedEvents = {};
  Map<String, List> get mappedEvents => _mappedEvents;
  set mappedEvents(Map<String, List> mappedEvents) {
    _mappedEvents = mappedEvents;
    notifyListeners();
  }

  
  
}