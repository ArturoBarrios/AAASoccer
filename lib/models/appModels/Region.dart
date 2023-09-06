class Region {
  String? name;
  Location? location;
  List<League>? leagues;
  List<Tournament>? tournaments;
  List<Team>? teams;
  List<RegionUserParticipant>? userParticipants;

  Region({
    this.name,
    this.location,
    this.leagues,
    this.tournaments,
    this.teams,
    this.userParticipants,
  });
}
