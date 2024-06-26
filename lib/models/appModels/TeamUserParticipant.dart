import '../enums/EventUserParticipantAttendingOptions.dart';
import 'Team.dart';
import 'User.dart';

class TeamUserParticipant {
  Team? team;
  User? user;
  String? roles;
  EventUserParticipantAttendingOptions? isAttending;

  TeamUserParticipant({
    this.team,
    this.user,
    this.roles,
    this.isAttending,
  });
}