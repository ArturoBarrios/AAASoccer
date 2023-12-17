import 'Player.dart';
import 'Event.dart';

class Wager {
  String? name;
  String? amount;
  List<Player>? players;
  bool? private;
  List<Event>? events;

  Wager({
    this.name,
    this.amount,
    this.players,
    this.private,
    this.events,
  });
}