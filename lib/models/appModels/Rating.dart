class Rating {
  int? rating;
  List<Organization>? organizations;
  List<Team>? teams;
  List<Event>? events;
  List<User>? users;
  List<Player>? players;
  List<Organizer>? organizers;
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
    this.organizers,
    this.coaches,
    this.referees,
    this.ratingCategories,
  });
}
