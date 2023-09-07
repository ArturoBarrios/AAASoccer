import 'User.dart';
import 'Event.dart';
import '../enums/RsvpStatus.dart';

class Rsvp {
  String? id;
  User? user;
  Event? event;
  RsvpStatus? status;
  String? createdAt;

  Rsvp({
    this.id,
    this.user,
    this.event,
    this.status,
    this.createdAt,
  });
}
