import 'Tournament.dart';
import 'Event.dart';
import 'Season.dart';
import 'Region.dart';

class League {
  List<Tournament>? tournaments;
  List<Event>? events;
  int? numberOfTeams;
  Season? season;
  Region? region;

  League({
    this.tournaments,
    this.events,
    this.numberOfTeams,
    this.season,
    this.region,
  });
}
