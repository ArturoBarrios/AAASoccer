import 'package:flutter/foundation.dart';
import 'package:soccermadeeasy/extensions/parse_roles.dart';
import '../../commands/base_command.dart';
import '../../components/join_condition.dart';
import '../../strings.dart';
import 'package:soccermadeeasy/svg_widgets.dart';
import '../../constants.dart';
import '../appModels/Price.dart';
import 'event_page.dart';
import 'event_page_model.dart';
class EventsPageModel extends ChangeNotifier {
  List<EventPage> _eventsPages = [];

  List<EventPage> get eventsPages => _eventsPages;

  // ... existing methods ...

  void addEventPage(EventPage eventPageInstance) {
    // Listen to each EventPage
    eventPageInstance.addListener(_onEventPageChanged);
    _eventsPages.add(eventPageInstance);
    notifyListeners();
  }

  void _onEventPageChanged() {
    // You can perform actions here when any EventPage changes
    // For instance, you might want to notify listeners of EventsPageModel
    notifyListeners();
  }

  @override
  void dispose() {
    // Remove the listener when EventsPageModel is disposed
    for (var eventPage in _eventsPages) {
      eventPage.removeListener(_onEventPageChanged);
    }
    super.dispose();
  }

  // ... other methods ...
}
