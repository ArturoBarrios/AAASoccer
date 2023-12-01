import 'models/enums/AmenityType.dart';
import 'models/enums/EventType.dart';

class Constants {
  static const EventType PICKUP = EventType.GAME;
  static const String TEAM = "TEAM";
  static const String GROUP = "GROUP";
  static const EventType LEAGUE = EventType.LEAGUE;
  static const EventType TOURNAMENT = EventType.TOURNAMENT;
  static const EventType TRYOUT = EventType.TRYOUT;
  static const EventType TRAINING = EventType.TRAINING;
  static const String WAGER = "7";
  static const String FRIEND = "9";
  static const String MYEVENTS = "10";
  static const String LOCATION = "11";
  static const String MYTEAMS = "12";
  static const String MYGROUPS = "13";
  static const String EVENT = "EVENT";
  static const String VIEWEVENT = "View Event";
  static const String VIEWUSER = "View User";
  static const String VIEWTEAM = "View Team";
  static const String REQUESTSSENT = "REQUESTSSENT";
  static const String REQUESTSRECEIVED = "REQUESTSRECEIVED";
  //request type
  static const String GAMEREQUEST = "GAMEREQUEST";
  static const String TOURNAMENTREQUEST = "TOURNAMENTREQUEST";
  static const String LEAGUEREQUEST = "LEAGUEREQUEST";
  static const String TRYOUTREQUEST = "TRYOUTREQUEST";
  static const String TRAININGREQUEST = "TRAININGREQUEST";
  static const String FRIENDREQUEST = "FRIENDREQUEST";
  static const String TEAMREQUEST = "TEAMREQUEST";
  //user type
  static const String USER = "USER";
  static const String CHAT = "CHAT";
  static const String PLAYER = "PLAYER";
  static const String ORGANIZER = "ORGANIZER";
  static const String MANAGER = "MANAGER";
  static const String MAINCOACH = "MAINCOACH";
  static const String ASSISTANTCOACH = "ASSISTANTCOACH";
  static const String REF = "REF";

  //sort by
  static const String DISTANCE = "DISTANCE";
  static const String DATE = "DATE";
  static const String CREATEDATE = "CREATEDATE";
  static const String NAME = "STARTTIME";

  //choose image
  static const String CAMERA = "CAMERA";
  static const String PHONEGALLERY = "PHONEGALLERY";
  static const String APPGALLERY = "APPGALLERY";
  static const String DELETEIMAGE = "DELETEIMAGE";

  //image container types
  static const String PROFILEIMAGECIRCLE = "PROFILEIMAGECIRCLE";
  static const String CHATIMAGECIRCLE = "CHATIMAGECIRCLE";
  static const String IMAGEBANNER = "IMAGEBANNER";
  //image select options
  static const String IMAGEDELETE = "Delete";
  static const String IMAGEREPLACE = "Replace Image";

  static const String SUBSCRIPTION = "SUBSCRIPTION";

  //social media types
  static const String FACEBOOK = "FACEBOOK";
  static const String INSTAGRAM = "INSTAGRAM";
  static const String X = "X";
  static const String YOUTUBE = "YOUTUBE";
  static const String LINKEDIN = "LINKEDIN";

  //region user types
  static const String REGIONADMIN = "REGIONADMIN";
  static const String TOURNAMENTORGANIZER = "TOURNAMENTORGANIZER";
  static const String MATCHOFFICIALCOORDINATOR = "MATCHOFFICIALCOORDINATOR"; // Manages referees and other match officials for tournaments and leagues.
  static const String FIXTURESCHEDULER = "FIXTURESCHEDULER"; // Responsible for setting the dates and venues for matches.
  static const String SCOUT = "SCOUT"; 
  static const String MEDICALSTAFF = "MEDICALSTAFF"; 
  static const String VOLUNTEERCOORDINATOR = "VOLUNTEERCOORDINATOR"; 
  static const String SPONSORLIAISON = "SPONSORLIAISON"; 

  //color modes
  static const String DEFAULTMODE = "DEFAULTMODE";
  static const String DARKMODE = "DARKMODE";

  //pages
  static const String HOMEPAGE = "HOMEPAGE";
  static const String LOCATIONSPAGE = "LOCATIONSPAGE";
  static const String CHATSPAGE = "CHATSPAGE";
  static const String SCHEDULEPAGE = "SCHEDULEPAGE";

  static  List<String> availableAmenities = [AmenityType.PINNIES.toString()];
  static  List<String> fieldSelectionDetails = [AmenityType.BATHROOMS.toString(), AmenityType.BUS.toString(), AmenityType.TRAIN.toString(), AmenityType.BIKESTATION.toString(), "TURF", "GRASS", "INDOOR", "OUTDOOR", "SMALL", "LARGE", "CLEATS ALLOWED"];

  

  


}
