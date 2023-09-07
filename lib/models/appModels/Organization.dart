import 'Image.dart';
import 'Rating.dart';
import 'Event.dart';
import 'Team.dart';
import 'Sponsor.dart';
import 'EventUserParticipant.dart';
import 'Location.dart';

class Organization {
  String? name;
  List<Image>? images;
  List<Rating>? rating;
  List<Event>? events;
  List<Team>? teams;
  List<Sponsor>? sponsors;
  String? description;
  int? minAge;
  int? maxAge;
  bool? inviteOnly;
  bool? private;
  bool? isMainOrg;
  List<EventUserParticipant>? userParticipants;
  List<Location>? location;

  Organization({
    this.name,
    this.images,
    this.rating,
    this.events,
    this.teams,
    this.sponsors,
    this.description,
    this.minAge,
    this.maxAge,
    this.inviteOnly,
    this.private,
    this.isMainOrg,
    this.userParticipants,
    this.location,
  });
}
