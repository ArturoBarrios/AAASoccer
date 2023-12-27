import 'models/enums/AmenityType.dart';
import 'models/enums/EventType.dart';

class Constants {
 static const List<Map<String, String>> interests = [
  {'title': "Just for Fun", 'description': "Players who are mainly interested in casual play and relaxation, without any competitive edge."},
   {'title': "Recreational Competitor", 'description': "Players who enjoy regular games with friends, maybe in local leagues, but mainly for social engagement."},  
    {'title': "Aspiring Athlete", 'description': "Players who have competitive goals, engaging in regular training, and aiming for higher-level competition."},    
  
 ];
 
 static const List<Map<String, String>> skillLevels = [
  {'title': "Beginner", 'description': "Players who are mainly interested in casual play and relaxation, without any competitive edge."},
   {'title': "Advanced Beginner", 'description': "Players who enjoy regular games with friends, maybe in local leagues, but mainly for social engagement."},  
    {'title': "Intermediatte", 'description': "Players who have competitive goals, engaging in regular training, and aiming for higher-level competition."},
    {'title': "Amateur", 'description': "Players who are engaged in more structured competitions, with a focus on advancement and potential earnings from the sport."},
    {'title': "Semi Professional", 'description': "Players who are engaged in more structured competitions, with a focus on advancement and potential earnings from the sport."},
    {'title': "Professional", 'description': "You've played in a professional league for at least one season."},
    {'title': "Messi", 'description': "🐐"},
    {'title': "Ronaldo", 'description': "🐐"},
  
 ];

  static const List privateBetaProfileImages = [
    "Profile1.png",
    "Profile2.png",
    "Profile3.png",
    "Profile4.png",
    "Profile5.png",
    "Profile6.png",
    "Profile7.png",
    "Profile8.png",
    "Profile9.png"

  ];

   static const Map<int, List<dynamic>> playerCoordinates = {
    1: [0.46, 0.02, "GK"], // GK
    2: [0.1, 0.2, "LB"], // LB
    3: [0.3, 0.15, "LCB"], // LCB
    4: [0.6, 0.15, "RCB"], // RCB
    5: [0.8, 0.2, "RB"], // RB
    6: [0.1, 0.6, "LW"], // LW
    7: [0.30, 0.5, "LCM"], // LCM
    8: [0.6, 0.5, "RCM"], // RCM
    9: [0.8, 0.6, "RW"], // RW
    10: [0.3, 0.8, "LS"], // LS
    11: [0.7, 0.8, "RS"], // RS
  };
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

  static  List<String> hostAmenities = [AmenityType.PINNIES.toString()];
  static  List<String> fieldAmenities = [AmenityType.BATHROOMS.toString(), AmenityType.BUS.toString(), AmenityType.TRAIN.toString(), AmenityType.BIKESTATION.toString(), "TURF", "GRASS", "HARD SURFACE" ,"INDOOR", "OUTDOOR", "SMALL", "LARGE", "CLEATS ALLOWED"];

  static const String PRIVACYPOLICYURL = "https://www.freeprivacypolicy.com/live/daf992d8-a9d9-4d4c-9cfc-84735466e479";
  

  


}
