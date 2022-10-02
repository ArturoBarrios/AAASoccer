import 'dart:ffi';

import 'package:flutter/foundation.dart';
import '../strings.dart';
import 'package:soccermadeeasy/svg_widgets.dart';

class GamesModel extends ChangeNotifier {
  List _games = [];

  List get games => _games;
  set games(List games) {
    _games = games;
    notifyListeners();
  }


}