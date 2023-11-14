
import 'package:flutter/foundation.dart';
import 'package:soccermadeeasy/extensions/parse_roles.dart';
import '../../commands/base_command.dart';
import '../../components/join_condition.dart';
import '../../strings.dart';
import 'package:soccermadeeasy/svg_widgets.dart';
import '../../constants.dart';
import '../appModels/Price.dart';
import 'event_page_model.dart';

class EventsPageModel extends ChangeNotifier {  

  List<EventPageModel> _eventsPageModel = [];
  List<EventPageModel> get eventsPageModel => _eventsPageModel;
  set eventsPageModel(List<EventPageModel> eventsPageModel) {
    _eventsPageModel = eventsPageModel;
    notifyListeners();
  }

}
