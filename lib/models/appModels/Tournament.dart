import 'Event.dart';
import 'GroupStage.dart';
import 'League.dart';
import 'Region.dart';
import 'Season.dart';
import 'TournamentStage.dart';

class Tournament {
  bool? groupPlay;
  List<Event>? events;
  int? numberOfTeams;
  GroupStage? groupStage;
  TournamentStage? tournamentStage;
  Region? region;
  Season? season;
  List<League>? leagues;

  Tournament({
    this.groupPlay,
    this.events,
    this.numberOfTeams,
    this.groupStage,
    this.tournamentStage,
    this.region,
    this.season,
    this.leagues,
  });
}