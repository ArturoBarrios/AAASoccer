
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
  int _capacity = 0;
  dynamic mainEvent = null;

  int get capacity => _capacity;

  set capacity(int newCapacity) {
    if (_capacity != newCapacity) {
      _capacity = newCapacity;
      notifyListeners();
    }
  }

  // ... other properties and methods ...
}

