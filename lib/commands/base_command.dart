import 'package:flutter/material.dart';
import 'package:soccermadeeasy/commands/geolocation_command.dart';
import '/models/app_model.dart';
import '/models/user_model.dart';
import '/models/home_page_model.dart';
import '/models/events_model.dart';
import '/models/games_model.dart';
import '/models/requests_model.dart';
import '/models/requests_page_model.dart';
import '/models/friends_page_model.dart';
import '/services/user_service.dart';
import 'package:provider/provider.dart';
import 'package:amplify_api/amplify_api.dart';
import '../models/User.dart';
import '../commands/user_command.dart';
import '../commands/player_command.dart';
import '../commands/event_command.dart';
import '../models/payment_model.dart';
import '../services/geolocation_services.dart';
import '../services/twilio_services.dart';
import '../services/onesignal_service.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:geolocator/geolocator.dart';
// import 'package:geocoding/geocoding.dart';
import 'dart:convert';



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

  

  // Future <Map<String, dynamic>> reloadData() async{
  //   print("reloadData");
  //   Map<String, dynamic> reloadDataResponse = {"success": false, "message": "Something went wrong with reloading data", "data": Map<String, dynamic>()};

  //   return reloadDataResponse;
  // }


  Future <Map<String, dynamic>> reloadUser() async{
    print("reloadUser");
    Map<String, dynamic> reloadUserResponse = {"success": false, "message": "Something went wrong with reloading user data", "data": null};

    return reloadUserResponse;
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
            'user_id': appModel.currentUser['_id'],
            "OSPID": playerId
          };
          await UserCommand().updateUser(userInput);

          updateUserOSPIDResponse["success"] = true;

          return updateUserOSPIDResponse;
        }

            


  }

  Future <Map<String, dynamic>> setupInitialAppModels(String email) async{
    print("setupInitialAppModels");
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

          //setup onesignal
          await OneSignalService().configureOneSignalUserDetails();


          
          
          await EventCommand().setupMappedEvents();
          print("get friends and myEvents from currentUser object: ");
          List<dynamic> friends = appModel.currentUser['friends'];
          List<dynamic> myEvents = appModel.currentUser['events']['data'];
          List<dynamic> myArchivedEvents = [];
        List<dynamic> myEventsCopy = jsonDecode(jsonEncode(myEvents));
          print("friendss: "+friends.toString());          
          print("myEventss: "+myEvents.toString());
          myEventsCopy.forEach((element) async {
            print("myEvent: "+element.toString());
            if(element['archived']!=false){
              print("archived");
              myEvents.remove(element);
              print("removed");
              myArchivedEvents.add(element);
              print("added");
            }
          });
          print("setting appModel.myEvents, appModel.friends, and appModel.myArchivedEvents ");
          // appModel.myEvents = myEvents;
          // appModel.friends = friends;
          // appModel.myArchivedEvents = myArchivedEvents;
          print("set");

          await EventCommand().setupEvents(user);
            
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
  

  

  
}
