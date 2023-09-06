class Game {
  Team? hometeam;
  Team? awayteam;
  String? teamA;
  String? teamB;
  int? round;
  int? gameNumber;
  int? homegoals;
  int? awaygoals;
  bool? pickup;
  Event? event;

  Game({
    this.hometeam,
    this.awayteam,
    this.teamA,
    this.teamB,
    this.round,
    this.gameNumber,
    this.homegoals,
    this.awaygoals,
    this.pickup,
    this.event,
  });
}
