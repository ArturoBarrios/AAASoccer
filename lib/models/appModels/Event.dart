// Event.dart
class Event {
  String? name;
  List<JoinConditions>? joinConditions;  // You will define this JoinConditions class similarly
  bool? isMainEvent;
  List<EventUserParticipant>? userParticipants;  // You will define this EventUserParticipant class similarly
  Price? price;  // You can use the Price class defined above
  List<Request>? requests;  // You will define this Request class similarly
  List<Organization>? coorganizations;  // You will define this Organization class similarly
  List<Sponsor>? sponsors;  // You will define this Sponsor class similarly
  List<Rating>? ratings;  // You will define this Rating class similarly
  List<Image>? images;  // You will define this Image class similarly
  List<Location>? location;  // You will define this Location class similarly
  EventType? type;  // You will define this EventType class similarly
  List<Payment>? payments;  // You will define this Payment class similarly
  List<Chat>? chats;  // You will define this Chat class similarly
  List<Team>? teams;  // You will define this Team class similarly
  List<Game>? games;  // You will define this Game class similarly
  List<User>? users;  // You will define this User class similarly
  List<Tryout>? tryouts;  // You will define this Tryout class similarly
  List<League>? leagues;  // You will define this League class similarly
  List<Tournament>? tournaments;  // You will define this Tournament class similarly
  List<Training>? trainings;  // You will define this Training class similarly
  List<Wager>? wager;  // You will define this Wager class similarly
  List<Rsvp>? rsvp;  // You will define this Rsvp class similarly
  bool? archived;
  bool? deleted;
  String? startTime;
  String? endTime;
  String? createdAt;
  int? capacity;
  String? mainImageKey;
  List<SocialMediaApp>? socialMediaApps;  // You will define this SocialMediaApp class similarly

  Event({
    this.name,
    this.joinConditions,
    this.isMainEvent,
    this.userParticipants,
    this.price,
    this.requests,
    this.coorganizations,
    this.sponsors,
    this.ratings,
    this.images,
    this.location,
    this.type,
    this.payments,
    this.chats,
    this.teams,
    this.games,
    this.users,
    this.tryouts,
    this.leagues,
    this.tournaments,
    this.trainings,
    this.wager,
    this.rsvp,
    this.archived,
    this.deleted,
    this.startTime,
    this.endTime,
    this.createdAt,
    this.capacity,
    this.mainImageKey,
    this.socialMediaApps,
  });
}