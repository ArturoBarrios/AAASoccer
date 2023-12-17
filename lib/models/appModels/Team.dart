import 'Event.dart';
import 'Image.dart';
import 'User.dart';
import 'Sponsor.dart';
import 'Location.dart';
import 'TeamUserParticipant.dart';
import 'Region.dart';
import 'Request.dart';
import 'Chat.dart';
import 'Price.dart';
import 'Payment.dart';
import 'JoinConditions.dart';
import 'TeamOrder.dart';
import 'Organization.dart';
import 'Rating.dart';
import 'SocialMediaApp.dart';


class Team {
  String? name;
  String? color;
  List<Event>? events;
  List<Image>? images;
  List<User>? users;
  List<Sponsor>? sponsors;
  List<Location>? locations;
  List<TeamUserParticipant>? userParticipants;
  List<Region>? regions;
  String? status;
  bool? deleted;
  String? createdAt;
  String? updatedAt;
  List<Request>? requests;
  List<Chat>? chats;
  Price? price;
  List<Payment>? payments;
  List<JoinConditions>? joinConditions;
  List<TeamOrder>? teamOrders;
  Organization? organization;
  List<Rating>? ratings;
  List<SocialMediaApp>? socialMediaApps;
  int? capacity;

  Team({
    this.name,
    this.color,
    this.events,
    this.images,
    this.users,
    this.sponsors,
    this.locations,
    this.userParticipants,
    this.regions,
    this.status,
    this.deleted,
    this.createdAt,
    this.updatedAt,
    this.requests,
    this.chats,
    this.price,
    this.payments,
    this.joinConditions,
    this.teamOrders,
    this.organization,
    this.ratings,
    this.socialMediaApps,
    this.capacity,
  });
}