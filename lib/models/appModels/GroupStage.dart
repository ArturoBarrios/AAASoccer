import 'Group.dart';
import 'Tournament.dart';
import 'League.dart';
import '../enums/EventType.dart';

class GroupStage {
  List<Group>? groups;
  int? numberOfTeams;
  int? numberOfRoundsPerTeam;
  Tournament? tournament;
  League? league;
  EventType? type;

  GroupStage({
    this.groups,
    this.numberOfTeams,
    this.numberOfRoundsPerTeam,
    this.tournament,
    this.league,
    this.type,
  });
}
