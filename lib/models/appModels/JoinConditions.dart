import 'Event.dart';
import 'Team.dart';

class JoinConditions {
  bool? withRequest;
  bool? withPayment;
  bool? forTeam;
  bool? forEvent;
  Event? event;
  Team? team;

  JoinConditions({
    this.withRequest,
    this.withPayment,
    this.forTeam,
    this.forEvent,
    this.event,
    this.team,
  });
}
