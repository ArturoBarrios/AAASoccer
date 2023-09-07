import '../enums/SocialMediaType.dart';
import 'User.dart';
import 'Team.dart';
import 'Event.dart';

class SocialMediaApp {
  SocialMediaType? type;
  String? url;
  User? user;
  Team? team;
  Event? event;

  SocialMediaApp({
    this.type,
    this.url,
    this.user,
    this.team,
    this.event,
  });
}