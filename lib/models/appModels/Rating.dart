import 'Organization.dart';
import 'Team.dart';
import 'Event.dart';
import 'User.dart';
import 'Player.dart';
import 'Organization.dart';
import 'Coach.dart';
import 'Referee.dart';
import 'RatingCategory.dart';

class Rating {
  int? rating;
  List<Organization>? organizations;
  List<Team>? teams;
  List<Event>? events;
  List<User>? users;
  List<Player>? players;  
  List<Coach>? coaches;
  List<Referee>? referees;
  List<RatingCategory>? ratingCategories;

  Rating({
    this.rating,
    this.organizations,
    this.teams,
    this.events,
    this.users,
    this.players,    
    this.coaches,
    this.referees,
    this.ratingCategories,
  });
}
