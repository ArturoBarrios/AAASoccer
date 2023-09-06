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