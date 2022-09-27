import 'package:flutter/material.dart';
import '/models/app_model.dart';
import '/models/user_model.dart';
import '/models/home_page_model.dart';
import '/models/events_model.dart';
import '/models/games_model.dart';
import '/services/user_service.dart';
import 'package:provider/provider.dart';
import 'package:amplify_api/amplify_api.dart';
import '../models/User.dart';
import '../commands/user_command.dart';
import '../commands/game_command.dart';
import '../services/geolocation_services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';



late BuildContext _mainContext;
// The commands will use this to access the Provided models and services.
void init(BuildContext c) => _mainContext = c;

// Provide quick lookup methods for all the top-level models and services. Keeps the Command code slightly cleaner.
class BaseCommand {
  // Models
  UserModel userModel = _mainContext.read();
  AppModel appModel = _mainContext.read();
  HomePageModel homePageModel = _mainContext.read();
  EventsModel eventsModel = _mainContext.read();  
  GamesModel gamesModel = _mainContext.read();  
  // Services
  UserService userService = _mainContext.read();
  GeoLocationServices geoLocationServices = _mainContext.read();
  



  void testUpdateText() {
    homePageModel.testText = "testingggggg";
  }
  Future <Map<String, dynamic>> setupInitialAppConfigs() async{
    print("setupInitialAppConfigs");
    Map<String, dynamic> setupInitialAppConfigsResponse = {"success": false, "message": "Something went wrong with setting up initial app configs", "data": Map<String, dynamic>()};
    try{
      Position userPosition = await geoLocationServices.determinePosition();
      userModel.position = userPosition;
      try {
        
      List<Placemark> placemarks = await placemarkFromCoordinates(
        userPosition.latitude,
        userPosition.longitude,
        localeIdentifier: 'en_US',
      );

      Placemark place = placemarks[0];
      print("place: ");
      print(place);
      
    } catch (e) {
      print(e);
    }
      
      setupInitialAppConfigsResponse["success"] = true;
      setupInitialAppConfigsResponse["message"] = "Setup initial app configs";
      setupInitialAppConfigsResponse["data"]["position"] = userPosition;
      print("position: ");
      print(userPosition);
    }catch(e){
      print(e.toString());
    }
    return setupInitialAppConfigsResponse;
  }

  Future <Map<String, dynamic>> setupInitialAppModels(String email) async{
    print("setupInitialAppModels");
    Map<String, dynamic> resp = {"success": false, "message": "setup unsuccessfull", "data": null};
    try{      
      Map<String, dynamic> getUserResp = await UserCommand().getUser(email);     
      if(getUserResp["success"] == true){
        print("getUserResp: ");
        print(getUserResp);
        if(getUserResp["success"]){
          Map<String, dynamic> user = getUserResp["data"];
          AppModel().currentUser = user;
          // setUserId(user.id);
          // setUser(user);
          Map<String, dynamic> getGamesNearLocationResp = await GameCommand().getGamesNearLocation();
          if(getGamesNearLocationResp["success"]){
            List<dynamic> games = getGamesNearLocationResp["data"];          
            print("games to set");
            print(games);
          }
          if(getGamesNearLocationResp["success"]){
            resp["success"] = true;
            resp["message"] = "setup successfull";
            
          }        

          print("user stuff: ");
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
