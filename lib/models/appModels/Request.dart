import '../enums/RequestStatus.dart';
import '../enums/RequestType.dart';
import 'User.dart';
import 'Event.dart';
import 'Team.dart';

class Request {
  RequestType? type;
  User? sender;
  List<User>? receivers;
  User? acceptedBy;
  RequestStatus? status;
  int? requestAttempts;
  bool? fromOrganizer;
  Event? event;
  Team? team;
  String? forRole;
  int? sentAt;
  int? acceptedAt;

  Request({
    this.type,
    this.sender,
    this.receivers,
    this.acceptedBy,
    this.status,
    this.requestAttempts,
    this.fromOrganizer,
    this.event,
    this.team,
    this.forRole,
    this.sentAt,
    this.acceptedAt,
  });
}