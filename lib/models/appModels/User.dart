import 'package:soccermadeeasy/models/appModels/Organizer.dart';
import '../enums/GenderType.dart';
import '../enums/UserAccountStatus.dart';
import '../enums/UserType.dart';
import 'SocialMediaApp.dart';
import 'Rating.dart';
import 'Chat.dart';
import 'Message.dart';
import 'Request.dart';
import 'RegionUserParticipant.dart';
import 'TeamUserParticipant.dart';
import 'EventUserParticipant.dart';
import 'Event.dart';
import 'Image.dart';
import 'Referee.dart';
import 'Coach.dart';
import 'Player.dart';
import 'Location.dart';
import 'FollowRelation.dart';
import 'Team.dart';
import 'Payment.dart';
import 'StripeCustomer.dart';

class User {
  List<StripeCustomer>? stripeCustomers;
  List<Payment>? payments;
  UserType? userType;
  String? OSPID;
  String? name;
  String? phone;
  String? email;
  String? bio;
  String? username;
  String? birthdate;  
  int? age;
  List<Team>? teams;
  GenderType? gender;
  List<FollowRelation>? followers;
  List<FollowRelation>? following;
  Location? location;
  Player? player;  
  Coach? coach;
  Referee? referee;
  UserAccountStatus? status;
  int? createdAt;
  String? updatedAt;
  List<Image>? images;
  List<Event>? events;
  List<EventUserParticipant>? eventUserParticipants;
  List<TeamUserParticipant>? teamUserParticipants;
  List<RegionUserParticipant>? regionUserParticipants;
  List<Request>? requestsSent;
  List<Request>? requestsReceived;
  List<Request>? requestsAccepted;
  List<Chat>? chats;
  List<Message>? sentMessages;
  List<Message>? messagesDirectedForMe;
  bool? onboarded;
  List<Rating>? ratings;
  String? mainImageKey;
  bool? isProfilePrivate;
  List<SocialMediaApp>? socialMediaApps;
  Organizer? organizer;

  User({
    this.stripeCustomers,
    this.payments,
    this.userType,
    this.OSPID,
    this.name,
    this.phone,
    this.email,
    this.bio,
    this.username,
    this.birthdate,
    this.age,
    this.teams,
    this.gender,
    this.followers,
    this.following,
    this.location,
    this.player,    
    this.coach,
    this.referee,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.images,
    this.events,
    this.eventUserParticipants,
    this.teamUserParticipants,
    this.regionUserParticipants,
    this.requestsSent,
    this.requestsReceived,
    this.requestsAccepted,
    this.chats,
    this.sentMessages,
    this.messagesDirectedForMe,
    this.onboarded,
    this.ratings,
    this.mainImageKey,    
    this.isProfilePrivate,
    this.socialMediaApps,
    this.organizer,    
  });
}
