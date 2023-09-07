import 'Tournament.dart';
import 'EventOrder.dart';

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