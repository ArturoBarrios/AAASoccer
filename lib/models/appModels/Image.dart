import 'User.dart';
import 'Event.dart';
import 'Chat.dart';
import 'Team.dart';
import 'Location.dart';
import 'Organization.dart';
import 'Sponsor.dart';


class Image {
  bool? isMainImage;
  bool? public;
  String? url;
  String? key;
  User? user;
  Event? event;
  Chat? chat;
  Team? team;
  Location? location;
  Organization? organization;
  ModelType? attachedModelType;
  Sponsor? sponsor;
  String? s3bucket;

  Image({
    this.isMainImage,
    this.public,
    this.url,
    this.key,
    this.user,
    this.event,
    this.chat,
    this.team,
    this.location,
    this.organization,
    this.attachedModelType,
    this.sponsor,
    this.s3bucket,
  });
}
