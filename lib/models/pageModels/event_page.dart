
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
    if (_capacity != newCapacity) {
      _capacity = newCapacity;
      notifyListeners();
    }
  }
  
  int get fieldRating => _fieldRating;
  set fieldRating(int newFieldRating) {
    if (_fieldRating != newFieldRating) {
      _fieldRating = newFieldRating;
      notifyListeners();
    }
  }
  
  int get hostRating => _hostRating;
  set hostRating(int newHostRating) {
    if (_hostRating != newHostRating) {
      _hostRating = newHostRating;
      notifyListeners();
    }
  }

  
}

