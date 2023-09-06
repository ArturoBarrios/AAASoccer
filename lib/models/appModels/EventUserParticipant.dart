import 'EVent.dart';
import 'User.dart';
import 'Organization.dart';

class EventUserParticipant {
  Event? event;
  User? user;
  String? roles;
  Organization? organization;
  EventUserParticipantAttendingOptions? isAttending;

  EventUserParticipant({
    this.event,
    this.user,
    this.roles,
    this.organization,
    this.isAttending,
  });
}
