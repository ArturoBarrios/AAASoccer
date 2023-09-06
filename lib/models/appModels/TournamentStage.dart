class TournamentStage {
  int? numberOfTeams;
  int? numberOfRoundsPerTeam;
  Tournament? tournament;
  List<EventOrder>? eventOrders;

  TournamentStage({
    this.numberOfTeams,
    this.numberOfRoundsPerTeam,
    this.tournament,
    this.eventOrders,
  });
}