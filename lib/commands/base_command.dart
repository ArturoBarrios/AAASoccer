import 'package:soccermadeeasy/commands/geolocation_command.dart';
import '/models/app_model.dart';
import 'package:flutter/material.dart';
import '/models/user_model.dart';
import '/models/home_page_model.dart';
import '/models/events_model.dart';
import '/models/games_model.dart';
import '/models/chat_page_model.dart';
import '/models/requests_model.dart';
import '/models/requests_page_model.dart';
import '/models/friends_page_model.dart';
import '/services/user_service.dart';
import 'package:provider/provider.dart';
import 'package:amplify_api/amplify_api.dart';
import '../models/User.dart';
import '../commands/user_command.dart';
import '../commands/player_command.dart';
import '../commands/team_command.dart';
import '../commands/event_command.dart';
import '../commands/images_command.dart';
import '../models/payment_model.dart';
import '../services/geolocation_services.dart';
import '../services/twilio_services.dart';
import '../services/onesignal_service.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:geolocator/geolocator.dart';
import '../services/amplify_auth_service.dart';
// import 'package:geocoding/geocoding.dart';
import 'dart:convert';
import 'package:flutter_stripe/flutter_stripe.dart';



late BuildContext _mainContext;
// The commands will use this to access the Provided models and services.
void init(BuildContext c) => _mainContext = c;

// Provide quick lookup methods for all the top-level models and services. Keeps the Command code slightly cleaner.
class BaseCommand {
  // Models
  UserModel userModel = _mainContext.read();
  PaymentModel paymentModel = _mainContext.read();  
  AppModel appModel = _mainContext.read();
  EventsModel eventsModel = _mainContext.read();  
  GamesModel gamesModel = _mainContext.read();  
  HomePageModel homePageModel = _mainContext.read();
  RequestsModel requestsModel = _mainContext.read();  
  RequestsPageModel requestsPageModel = _mainContext.read();  
  FriendsPageModel friendsPageModel = _mainContext.read();  
  ChatPageModel chatPageModel = _mainContext.read();  
  // Services  
  GeoLocationServices geoLocationServices = _mainContext.read();
  // TwilioServices twilioServices = _mainContext.read();
  

  // void configureTwilio(){
  //   TwilioFlutter twilioFlutterClient = twilioServices.configureTwilio();
  //   appModel.twilioClient = twilioFlutterClient;
  // }


  void testUpdateText() {
    homePageModel.testText = "testingggggg";
  }

  //"{"test1", "test2", "test3"}
  List<String> parseRoles(String inputString) {
  // Remove curly braces and split string into individual words
  List<String> words = inputString.replaceAll('{', '').replaceAll('}', '').split(', ');
  print("words: $words");
  return words;
}

  //remove all data
void nukeData(){
  WidgetsFlutterBinding.ensureInitialized();
  //nuke data
  userModel = _mainContext.read();
  paymentModel = _mainContext.read();
  appModel = _mainContext.read();
  eventsModel = _mainContext.read();
  gamesModel = _mainContext.read();
  homePageModel = _mainContext.read();
  requestsModel = _mainContext.read();
  requestsPageModel = _mainContext.read();
  friendsPageModel = _mainContext.read();
  chatPageModel = _mainContext.read();
  
  //services
  geoLocationServices = _mainContext.read();

  appModel.initialConditionsMet = false;

}


  void updateChatViewModels(dynamic chat, eventOrTeamObject){
    print("updateChatViewModels()");
    print("chat: $chat");
    print("eventOrTeamObject: $eventOrTeamObject");
    //update chat view models
    appModel.currentUser['chats']['data'].insert(0, chat);


  }

  //will load profile, team, and other user images
  Future<Map<String, dynamic>> loadUserImagesFromAWS() async{
    print("loadUserImagesFromAWS()");
    Map<String, dynamic> loadUserImagesResponse = {
      "success": false,
      "message": "Something went wrong with loading user images",
      "data": null
    };

    try{
      await ImagesCommand().getAndSetUserProfileImage();      

      return loadUserImagesResponse;
    } catch(e){
      print("loadUserImages error: ");
      print(e);
      return loadUserImagesResponse;
    }
  }

  String getProfileUrl(){
    return userModel.profileImageUrl;
  }

  // Future<String> getProfileImage() async{
  //   String profileImageURL = "";
  //   String signedUrl = await ImagesCommand().getUserProfileImage();
    

  //   return profileImageURL;
  // }

  Future <Map<String, dynamic>> reloadUser() async{
    print("reloadUser");
    Map<String, dynamic> reloadUserResponse = {"success": false, "message": "Something went wrong with reloading user data", "data": null};

    return reloadUserResponse;
  }

  void signOut() async{
    BaseCommand().nukeData();
    await AmplifyAuthService().signOut();
  }

  Future <Map<String, dynamic>> setupInitialAppConfigs() async{
    print("setupInitialAppConfigs");
    Map<String, dynamic> setupInitialAppConfigsResponse = {"success": false, "message": "Something went wrong with setting up initial app configs", "data": Map<String, dynamic>()};
    try{
      // Position userPosition = await geoLocationServices.determinePosition();
      // userModel.position = userPosition;
      try {
        
      // List<Placemark> placemarks = await placemarkFromCoordinates(
      //   userPosition.latitude,
      //   userPosition.longitude,
      //   localeIdentifier: 'en_US',
      // );

      // Placemark place = placemarks[0];
      // print("place: ");
      // print(place);
      
    } catch (e) {
      print(e);
    }
      
      setupInitialAppConfigsResponse["success"] = true;
      setupInitialAppConfigsResponse["message"] = "Setup initial app configs";
      // setupInitialAppConfigsResponse["data"]["position"] = userPosition;
      print("position: ");
      // print(userPosition);
    }catch(e){
      print(e.toString());
    }
    return setupInitialAppConfigsResponse;
  }

  //get and set playerID
  Future<Map<String, dynamic>> updateUserOSPID() async {
    print("updateUserOSPID");
    Map<String, dynamic> updateUserOSPIDResponse = {
      "success": false,
      "message": "Default Error",
      "data": null
    };

    var deviceState = await OneSignal.shared.getDeviceState();

        //return if no deviceState is found
        if (deviceState == null || deviceState.userId == null){
          print("no deviceState found");
          return updateUserOSPIDResponse;
        }

        else{
          //coming out to null
          print("deviceState found for userID: "+appModel.currentUser['_id']);
          var playerId = deviceState.userId!;
          Map<String,dynamic>userInput = {
            '_id': appModel.currentUser['_id'],
            "OSPID": playerId
          };
          await UserCommand().updateUser(userInput);

          updateUserOSPIDResponse["success"] = true;

          return updateUserOSPIDResponse;
        }

            


  }

  Future <Map<String, dynamic>> setupInitialAppModels(String email) async{
    print("setupInitialAppModels");
    print("email: "+email);
    Map<String, dynamic> resp = {"success": false, "message": "setup unsuccessfull", "data": null};
    try{            
      Map<String, dynamic> getUserInput = {
        "email": email
      };
      Map<String, dynamic> getUserResp = await UserCommand().getUserByEmail(getUserInput);     
        print("getUserResp: ");
        print(getUserResp);
      if(getUserResp["success"] == true){
        if(getUserResp["success"]){          
          dynamic user = getUserResp["data"];
          if(user==null){
            Map<String, dynamic> userInput = {
              "name": "no name",
              "email": email,
              "username": "username",
              "phone": "2672136006",
              "birthdate": "07/26/1997",
              "gender": "male",
              "address": "random address",
              "status": "SignedUp"
            };      
            Map<String, dynamic> locationInput = {"latitude": 0, "longitude": 0};      
            Map<String, dynamic> createPlayerResp = await PlayerCommand().createPlayer(userInput, {}, locationInput, false);
            user = createPlayerResp['data'];
          }
          appModel.currentUser = user;
          print("app model user: ");
          print(appModel.currentUser);
          print("user['chats']['data']: "+user['chats']['data'].toString());
          userModel.chats = user['chats']['data'];

          //setup onesignal
          await UserCommand().configureOneSignalUserDetails();

          print("testing some shit out!");
          
          await loadUserImagesFromAWS();
          await EventCommand().setupMappedEvents();
          print("get friends and myEvents from currentUser object: " +appModel.currentUser.toString());
          List<dynamic> friends = appModel.currentUser['friends']['data'];
          List<dynamic> myEvents = appModel.currentUser['eventUserParticipants']['data'];
          List<dynamic> myTeams = appModel.currentUser['teamUserParticipants']['data'];
          List<dynamic> myArchivedEvents = [];
          List<dynamic> myEventsCopy = jsonDecode(jsonEncode(myEvents));
          print("friendss: "+friends.toString());                              
          
          print("setting appModel.myEvents, appModel.friends, and appModel.myArchivedEvents ");
          // appModel.myEvents = myEvents;
          // appModel.friends = friends;
          // appModel.myArchivedEvents = myArchivedEvents;
          print("set");

          await EventCommand().setupEventsFromCurrentUser(appModel.currentUser);
          await TeamCommand().setupTeamsFromCurrentUser(appModel.currentUser);
            
          //setup events(league, tournament, tryout, training)
          //,teams, players near me data. 
          //get location and update user location
          Position userPosition = await GeoLocationCommand().determinePosition();
          appModel.currentPosition = userPosition;
          print("userPosition: "+userPosition.toString());                    
          appModel.currentUser['currentPosition'] = userPosition;
          await GeoLocationCommand().setUserAddress(userPosition.latitude, userPosition.longitude);
          print("check appModel after setting userPosition: "+ appModel.currentUser['currentPosition'].toString());
          //assume you have the latest events
          Map<String, dynamic> findEventsNearPointResp = await EventCommand().findEventsNearPoint(eventsModel.events, 50);
          print("findEventsNearPointResp: "+findEventsNearPointResp.toString());
          if(findEventsNearPointResp["success"]){
            dynamic eventsNearPoint = findEventsNearPointResp["data"];
            print("eventsNearPoint: "+eventsNearPoint.toString());
            eventsModel.eventsNearMe = eventsNearPoint;

          }
            
            print("Setup Events");

            
            // 
          // }
         
            resp["success"] = true;
            resp["message"] = "setup successfull";
            
         

         
        }
        else{
          print("something went wrong in fetching user");
        }

      }      
      
    }catch(e){
      print("errorrrrrrrr: ");
      print(e);
      // userModel.userSetup.value = false;
    }
    

    return resp;
  
  }

  DateTime dateTimeFromMilliseconds(String millisecondsString){
    int millisecondsSinceEpoch = int.parse(millisecondsString);
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch);

    return dateTime;
  }
  
  Future<Map<String, dynamic>> purgeProfile(Map<String, dynamic> data) async{
    print("purgeProfile");
    Map<String, dynamic> resp = {"success": false, "message": "profile not purged", "data": null};
    try{
      UserCommand().deleteUser(data['userId']);
    }on ApiException catch(e){
      print("handle exception");
    }

    return resp; 

  }

  void initialConditionsMet(){
    appModel.initialConditionsMet = true;
  }
  

  void setUserId(String userId){
    userModel.userID = userId;
}

  void setUser(User user){
    // userModel.user = user;
  }

  void setIsSigned(bool signedIn){
    appModel.isSignedIn = signedIn;
  }

  //expects list of user objects with ids
  String formDisconnectUserIdsString(List<dynamic> users){
    print("formDisconnectUserIdsString");

    String disconnectUserIdsString = "";
    for(int i = 0; i < users.length; i++){
      disconnectUserIdsString += """
          "${users[i]['id']}\n"        
      """;
      if(i < users.length - 1){
        disconnectUserIdsString += ",";
      }
    }
    print("disconnectUserIdsString: " + disconnectUserIdsString);
    return disconnectUserIdsString;
  }

  bool checkElementExists(List<dynamic> list1, List<dynamic> list2) {
    print("checkElementExists");
  for (var item1 in list1) {
    if (list2.any((item2) => item2['_id'] == item1['_id'])) {
      return true;
    }
  }
  return false;
}
  

  

  
}
