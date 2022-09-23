import 'dart:ffi';

import 'package:flutter/foundation.dart';
import '../strings.dart';
import 'package:soccermadeeasy/svg_widgets.dart';


class EventsModel extends ChangeNotifier {
  List _games = [];

  List get games => _games;
  set games(List games) {
    _games = games;
    notifyListeners();
  }
  
}