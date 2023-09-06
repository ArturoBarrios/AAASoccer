class Location {
  String? name;
  String? secondaryName;
  String? address;
  SurfaceType? surface;
  List<Image>? images;
  FieldPlayerOccupancySize? fieldSize;
  bool? private;
  String? schedule;
  double? latitude;
  double? longitude;
  List<Event>? events;
  User? user;
  Team? team;
  Organization? organization;
  List<Price>? prices;

  Location({
    this.name,
    this.secondaryName,
    this.address,
    this.surface,
    this.images,
    this.fieldSize,
    this.private,
    this.schedule,
    this.latitude,
    this.longitude,
    this.events,
    this.user,
    this.team,
    this.organization,
    this.prices,
  });
}
