import 'Event.dart';
import 'TournamentStage.dart';

class EventOrder {
  Event? event;
  int? order;
  TournamentStage? tournamentStage;

  EventOrder({
    this.event,
    this.order,
    this.tournamentStage,
  });
}
