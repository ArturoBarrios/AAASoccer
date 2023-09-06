import 'Team.dart';
import 'Group.dart';

class TeamOrder {
  Team? team;
  int? points;
  Group? group;
  int? order;

  TeamOrder({
    this.team,
    this.points,
    this.group,
    this.order,
  });
}