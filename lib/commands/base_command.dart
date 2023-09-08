import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:soccermadeeasy/commands/geolocation_command.dart';
import '../components/Dialogues/animated_dialogu.dart';
import '../constants.dart';
import '../graphql/fragments/team_fragments.dart';
import '../graphql/mutations/users.dart';
import '../graphql/queries/users.dart';
import '../models/pageModels/event_page_model.dart';
import '../models/pageModels/profile_page_model.dart';
import '../models/pageModels/team_page_model.dart';
import '../models/pageModels/app_model.dart';
import 'package:flutter/material.dart';
import '/models/user_model.dart';
import '../models/pageModels/home_page_model.dart';
import '/models/events_model.dart';
import '../models/pageModels/chat_page_model.dart';
import '/models/requests_model.dart';
import '../models/pageModels/requests_page_model.dart';
import '/services/user_service.dart';
import 'package:provider/provider.dart';
import 'package:amplify_api/amplify_api.dart';
import '../commands/user_command.dart';
import '../commands/player_command.dart';
import '../commands/team_command.dart';
import '../commands/event_command.dart';
import '../commands/images_command.dart';
import '../models/componentModels/payment_model.dart';
import '../services/geolocation_services.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:geolocator/geolocator.dart';
import '../services/amplify_auth_service.dart';
// import 'package:geocoding/geocoding.dart';
import 'dart:convert';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;

import 'chat_command.dart';
import 'home_page_command.dart';

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
  HomePageModel homePageModel = _mainContext.read();
  EventPageModel eventPageModel = _mainContext.read();
  TeamPageModel teamPageModel = _mainContext.read();
  ProfilePageModel profilePageModel = _mainContext.read();
  RequestsModel requestsModel = _mainContext.read();
  RequestsPageModel requestsPageModel = _mainContext.read();  
  ChatPageModel chatPageModel = _mainContext.read();
  // Services
  GeoLocationServices geoLocationServices = _mainContext.read();

  void initializeData() {}

  String xHoursAgoString(int x) {
    DateTime xHoursAgo = DateTime.now().subtract(Duration(hours: x));
    String xHoursAgoTimestamp = xHoursAgo.millisecondsSinceEpoch.toString();
    print("xHoursAgoTimestamp before getEventsNearLocation: " +
        xHoursAgoTimestamp);

    return xHoursAgoTimestamp;
  }

  bool isWithinXHoursAgo(int hoursAgo, String timestampToCompareTo) {
    DateTime xHoursAgo = DateTime.now().subtract(Duration(hours: hoursAgo));
    String xHoursAgoTimestamp = xHoursAgo.millisecondsSinceEpoch.toString();
    print("xHoursAgoTimestamp before getEventsNearLocation: " +
        xHoursAgoTimestamp);
    if (int.parse(xHoursAgoTimestamp) < int.parse(timestampToCompareTo)) {
      return true;
    } else {
      return false;
    }
  }

  bool isEventType(dynamic type) {
    if (type == Constants.PICKUP ||
        type == Constants.TRYOUT ||
        type == Constants.TRAINING ||
        type == Constants.TOURNAMENT ||
        type == Constants.LEAGUE) {
      return true;
    } else {
      return false;
    }
  }

  String addRolesToExistingRoles(
      List<dynamic> exitingRoles, List<dynamic> rolesToAdd) {
    String roles = "{";
    for (int i = 0; i < exitingRoles.length; i++) {
      roles += exitingRoles[i];
      if (i != exitingRoles.length - 1) {
        roles += ", ";
      }
    }
    for (int i = 0; i < rolesToAdd.length; i++) {
      roles += rolesToAdd[i];
      if (i != rolesToAdd.length - 1) {
        roles += ", ";
      }
    }

    roles += "}";
    return roles;
  }


  dynamic getUserEventDetailsModel() {
    return appModel.userEventDetails;
  }

  void popToHome(BuildContext context) {
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);
  }

  getHomePageModel() => homePageModel;
  //calculate distance between two points
  dynamic getObjectsNearMe(Map<String, dynamic> myLocation,
      Map<String, dynamic> otherLocation, dynamic objects) {
    print("getObjectsNearMe");
    print("objects: $objects");
    print("myLocation: $myLocation");
    print("otherLocation: $otherLocation");

    //calculate
    double distanceInMeters = Geolocator.distanceBetween(
        myLocation['latitude'],
        myLocation['longitude'],
        otherLocation['latitude'],
        otherLocation['longitude']);
    List<dynamic> objectsNearMe = [];

    return objectsNearMe;
  }

  void setupFaunaClient(dynamic client) {
    print("setupFaunaClient: " + client);
    appModel.faunaClient = client;
  }

  void testUpdateText() {
    homePageModel.testText = "testingggggg";
  }

  //"{"test1", "test2", "test3"} => ["test1", "test2", "test3"]
  List<String> parseRoles(String inputString) {
    // Remove curly braces and split string into individual words
    List<String> words =
        inputString.replaceAll('{', '').replaceAll('}', '').split(', ');
    print("words: $words");
    return words;
  }

  //["test1", "test2", "test3"] => {"test1", "test2", "test3"}
  String stringifyRoles(List<dynamic> inputList) {
    String rolesString = inputList.toSet().toString();

    return rolesString;
  }

  //remove all data
  void nukeData() {
    WidgetsFlutterBinding.ensureInitialized();
    //nuke data
    userModel = _mainContext.read();
    paymentModel = _mainContext.read();
    appModel = _mainContext.read();
    eventsModel = _mainContext.read();    
    homePageModel = _mainContext.read();
    eventPageModel = _mainContext.read();
    teamPageModel = _mainContext.read();
    profilePageModel = _mainContext.read();
    requestsModel = _mainContext.read();
    requestsPageModel = _mainContext.read();    
    chatPageModel = _mainContext.read();

    // homePageModel.nukeData();

    //services
    geoLocationServices = _mainContext.read();

    appModel.initialConditionsMet = false;
  }

  Future<bool> uniquenessUserAttributesCheck(
      Map<String, dynamic> userAttributes) async {
    print("createUserAttributesCheck()");
    print("userAttributes: $userAttributes");
    bool createUserAttributesCheckResponse = true;
    try {
      String email = userAttributes['email'];
      String username = userAttributes['username'];
      String phone = userAttributes['phone'];
      dynamic userInput = {
        "email": email,
        "username": username,
        "phone": phone
      };
      print("userInput: $userInput");
      http.Response response = await http.post(
        Uri.parse('https://graphql.fauna.com/graphql'),
        headers: <String, String>{
          'Authorization': 'Bearer ${dotenv.env['FAUNADBSECRET']}',
          'Content-Type': 'application/json'
        },
        body: jsonEncode(<String, String>{
          'query': UserQueries().checkUserUniqueness(userInput),
        }),
      );

      print("response body: ");
      print(jsonDecode(response.body));
      dynamic data = jsonDecode(response.body)['data'];
      dynamic getUserByEmailResponse = data['getUserByEmail'];
      dynamic getUserByUsernameResponse = data['getUserByUsername'];
      dynamic getUserByPhoneResponse = data['getUserByPhone'];

      if (getUserByEmailResponse != null) {
        print("email already exists");
        createUserAttributesCheckResponse = false;
      }
      if (getUserByUsernameResponse != null) {
        print("username already exists");
        createUserAttributesCheckResponse = false;
      }
      if (getUserByPhoneResponse != null) {
        print("phone already exists");
        if (dotenv.env['ENVIRONMENT'] == "PRODUCTION") {
          //if in production, don't allow user to create account with phone number that already exists
          createUserAttributesCheckResponse = false;
        }
      }
    } catch (e) {
      print("createUserAttributesCheck error: ");
      print(e);
      createUserAttributesCheckResponse = false;
    }

    return createUserAttributesCheckResponse;
  }

  void updateChatViewModels(dynamic chat, eventOrTeamObject) {
    print("updateChatViewModels()");
    print("chat: $chat");
    print("eventOrTeamObject: $eventOrTeamObject");
    //update chat view models
    appModel.currentUser['chats']['data'].insert(0, chat);
  }

  //will load profile, team, and other user images
  Future<Map<String, dynamic>> loadUserImagesFromAWS() async {
    print("loadUserImagesFromAWS()");
    Map<String, dynamic> loadUserImagesResponse = {
      "success": false,
      "message": "Something went wrong with loading user images",
      "data": null
    };

    try {
      // await ImagesCommand().getAndSetUserProfileImage();

      return loadUserImagesResponse;
    } catch (e) {
      print("loadUserImages error: ");
      print(e);
      return loadUserImagesResponse;
    }
  }

  String getProfileUrl() {
    return userModel.profileImageUrl;
  }

  // Future<String> getProfileImage() async{
  //   String profileImageURL = "";
  //   String signedUrl = await ImagesCommand().getUserProfileImage();

  //   return profileImageURL;
  // }

  Future<Map<String, dynamic>> reloadUser() async {
    print("reloadUser");
    Map<String, dynamic> reloadUserResponse = {
      "success": false,
      "message": "Something went wrong with reloading user data",
      "data": null
    };

    return reloadUserResponse;
  }

  void setIsGuest(bool isGuest) {
    appModel.isGuest = isGuest;
  }

  Future<void> signOut() async {
    BaseCommand().nukeData();
    await AmplifyAuthService().signOut();
  }

  Future<Map<String, dynamic>> setupInitialAppConfigs() async {
    print("setupInitialAppConfigs");
    Map<String, dynamic> setupInitialAppConfigsResponse = {
      "success": false,
      "message": "Something went wrong with setting up initial app configs",
      "data": <String, dynamic>{}
    };
    try {
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
    } catch (e) {
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
    if (deviceState == null || deviceState.userId == null) {
      print("no deviceState found");
      return updateUserOSPIDResponse;
    } else {
      //coming out to null
      print("deviceState found for userID: " + appModel.currentUser['_id']);
      var playerId = deviceState.userId!;
      Map<String, dynamic> userInput = {
        '_id': appModel.currentUser['_id'],
        "OSPID": playerId
      };
      await UserCommand().updateUser(userInput);

      updateUserOSPIDResponse["success"] = true;

      return updateUserOSPIDResponse;
    }
  }

  Future<void> setupUser(String email) async {
    Map<String, dynamic> getUserInput = {"email": email};
    if (!appModel.isGuest) {
      Map<String, dynamic> getUserResp =
          await UserCommand().getUserByEmail(getUserInput);
      print("getUserResp: ");
      print(getUserResp);
      if (getUserResp["success"]) {
        dynamic user = getUserResp["data"];
        if (user == null) {
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
          Map<String, dynamic> createPlayerResp = await PlayerCommand()
              .createPlayer(userInput, {}, locationInput, false);
          user = createPlayerResp['data'];
        }
        appModel.currentUser = user;
        print("app model user: ");
        print(appModel.currentUser);
        print("user['chats']['data']: ${user['chats']['data']}");
        userModel.chats = user['chats']['data'];
        //setup onesignal
        await UserCommand().configureOneSignalUserDetails();
        print("testing some shit out!");
        //not being used so commented out
        // await loadUserImagesFromAWS();
        print(
            "get friends and myEvents from currentUser object: ${appModel.currentUser}");

        ImagesCommand().setUserProfileImage();
      } else {
        print("something went wrong in fetching user");
      }
    } else {
      print("is guest");
    }
  }

  Future<Map<String, dynamic>> setupInitialAppModels() async {
    print("setupInitialAppModels");
    Map<String, dynamic> resp = {
      "success": false,
      "message": "setup unsuccessfull",
      "data": null
    };
    try {
      DateTime oneHourAgo = DateTime.now().subtract(Duration(hours: 1));
      String oneHourAgoTimestamp = oneHourAgo.millisecondsSinceEpoch.toString();
      print("oneHourAgoTimestamp before getEventsNearLocation: " +
          oneHourAgoTimestamp);
      //setup events
      print("Setup Events");
      if (!appModel.isGuest) {
        await HomePageCommand().eventTypeTapped(Constants.MYEVENTS);
      } else {
        await HomePageCommand().eventTypeTapped(Constants.PICKUP);
      }
      // if(appModel.isGuest){
      //   await EventCommand().setupEvents(Constants.PICKUP, oneHourAgoTimestamp);
      // }
      // else{
      //   await EventCommand().setupEvents(Constants.MYEVENTS, oneHourAgoTimestamp);

      // }
      print("setup Events done");

      //setup players
      //todo

      //,teams, players near me data.
      //get location and update user location
      Position userPosition = await GeoLocationCommand().determinePosition();
      appModel.currentPosition = userPosition;
      print("userPosition: $userPosition");
      appModel.currentUser['currentPosition'] = userPosition;
      await GeoLocationCommand()
          .setUserAddress(userPosition.latitude, userPosition.longitude);
      print(
          "check appModel after setting userPosition: ${appModel.currentUser['currentPosition']}");
      //assume you have the latest events
      Map<String, dynamic> findEventsNearPointResp =
          await EventCommand().findEventsNearPoint(eventsModel.events, 50);
      print("findEventsNearPointResp: $findEventsNearPointResp");
      if (findEventsNearPointResp["success"]) {
        dynamic eventsNearPoint = findEventsNearPointResp["data"];
        eventsModel.eventsNearMe = eventsNearPoint;
        print("eventsNearPoint: $eventsNearPoint");
      }

      resp["success"] = true;
      resp["message"] = "setup successfull";
    } catch (e) {
      print("errorrrrrrrr: ");
      print(e);
      // userModel.userSetup.value = false;
    }

    return resp;
  }

  bool isGuest() {
    return appModel.isGuest;
  }

  DateTime dateTimeFromMilliseconds(String millisecondsString) {
    int millisecondsSinceEpoch = int.parse(millisecondsString);
    DateTime dateTime =
        DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch);

    return dateTime;
  }


  void initialConditionsMet() {
    appModel.initialConditionsMet = true;
  }

  void initialUserConditionsMet() {
    appModel.userConditionsMet = true;
  }

  void setUserId(String userId) {
    userModel.userID = userId;
  }


  void setIsSigned(bool signedIn) {
    appModel.isSignedIn = signedIn;
  }

  //expects list of user objects with ids
  String formDisconnectUserIdsString(List<dynamic> users) {
    print("formDisconnectUserIdsString");

    String disconnectUserIdsString = "";
    for (int i = 0; i < users.length; i++) {
      disconnectUserIdsString += """
          "${users[i]['id']}\n"        
      """;
      if (i < users.length - 1) {
        disconnectUserIdsString += ",";
      }
    }
    print("disconnectUserIdsString: $disconnectUserIdsString");
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
