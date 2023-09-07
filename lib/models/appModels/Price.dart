import 'Event.dart';
import 'Team.dart';
import 'Location.dart';

class Price {
  String? amount;
  Event? event;  // You will define this Event class similarly
  Team? team;    // You will define this Team class similarly
  Location? location;  // You will define this Location class similarly  
  String? teamAmount;
  int? time;  // In minutes

  Price({
    this.amount,
    this.event,
    this.team,
    this.location,    
    this.teamAmount,
    this.time,
  });
}