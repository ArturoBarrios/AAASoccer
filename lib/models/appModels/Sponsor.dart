import 'Image.dart';
import 'Event.dart';
import 'Organization.dart';
import 'Player.dart';
import 'Team.dart';

class Sponsor {
  String? id;
  String? name;
  List<Image>? images;
  String? description;
  String? url;
  List<Event>? events;
  List<Organization>? sponsoredOrgs;
  List<Player>? sponsoredPlayers;
  List<Team>? sponsoredTeams;

  Sponsor({
    this.id,
    this.name,
    this.images,
    this.description,
    this.url,
    this.events,
    this.sponsoredOrgs,
    this.sponsoredPlayers,
    this.sponsoredTeams,
  });
}