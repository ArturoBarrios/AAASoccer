import 'dart:ffi';

import 'package:flutter/foundation.dart';
import '../strings.dart';
import 'package:soccermadeeasy/svg_widgets.dart';
import 'event_types_model.dart';

class GamesModel extends ChangeNotifier {
  List _games = [
    {
      "_id": "342359000856134224",
      "user": {
        "name": "Arturo Barrios"
      }
    }
  ];

  List get games => _games;
  set games(List games) {
    _games = games;
    notifyListeners();
  }


}