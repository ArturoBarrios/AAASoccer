import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:soccermadeeasy/commands/geolocation_command.dart';
import 'package:soccermadeeasy/commands/requests_command.dart';
import '../components/Cards/event_request_card.dart';
import '../components/Cards/friend_request_card.dart';
import '../components/Cards/league_card.dart';
import '../components/Cards/team_request_card.dart';
import '../components/Cards/tournament_card.dart';
import '../components/Cards/training_card.dart';
import '../components/Cards/tryout_card.dart';
import '../components/Cards/tsn_event_request_card.dart';
import '../components/Cards/tsn_group_card.dart';
import '../components/Cards/tsn_pickup_card.dart';
import '../components/Cards/tsn_player_card.dart';
import '../components/Cards/tsn_team_card.dart';
import '../components/Cards/tsn_tournament_card.dart';
import '../components/Cards/tsn_training_card.dart';
import '../components/Cards/tsn_tryout_card.dart';
import '../components/Dialogues/alert_dialogue.dart';
import '../components/Dialogues/animated_dialogu.dart';
import '../components/agreement_form_widget.dart';
import '../constants.dart';
import '../graphql/fragments/event_fragments.dart';
import '../graphql/fragments/team_fragments.dart';
import '../graphql/mutations/users.dart';
import '../graphql/queries/users.dart';
import '../models/enums/AmenityType.dart';
import '../models/pageModels/events_page_model.dart';
import '../models/pageModels/event_page_model.dart';
import '../models/pageModels/group_page_model.dart';
import '../models/pageModels/profile_page_model.dart';
import '../models/pageModels/team_page_model.dart';
import '../models/pageModels/app_model.dart';
import 'package:flutter/material.dart';
import '../services/onesignal_service.dart';
import '../strings.dart';
import '../styles/colors.dart';
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
import 'group_command.dart';
import 'home_page_command.dart';
import 'location_command.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

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
  GroupPageModel groupPageModel = _mainContext.read();
  ProfilePageModel profilePageModel = _mainContext.read();
  RequestsModel requestsModel = _mainContext.read();
  RequestsPageModel requestsPageModel = _mainContext.read();
  ChatPageModel chatPageModel = _mainContext.read();
  EventsPageModel eventsPageModel = _mainContext.read();
  // Services
  GeoLocationServices geoLocationServices = _mainContext.read();

  void initializeData() {}

  onTapBottomNav(context, key, item) {
    appModel.onTapBottomNav(context, key, item);
  }    

   Future<void> launchLocationInBrowser(double latitude, double longitude  ) async {
    final url = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
      print("url: $url");
      if (!await launchUrl(
        Uri.parse(url.toString()),
        mode: LaunchMode.inAppWebView,
      )) {
        throw Exception('Could not launch $url');
      }
  }
  

List<String> parseAmenities(String amenitiesString) {
  // Remove the curly braces and trim the string
  var trimmedString = amenitiesString.replaceAll(RegExp(r'[{}]'), '').trim();
  print("trimmedString: $trimmedString");
  // Check if the string is empty after removing braces
  if (trimmedString.isEmpty) {
    return [];
  }

  // Split the string into a list of strings
  var amenitiesList = trimmedString.split(',').map((e) => e.trim());

  // Map the strings to their corresponding enum values
  // return amenitiesList.map((amenity) {
  //   switch (amenity.toUpperCase()) {
  //     case 'BUS':
  //       return AmenityType.BUS;
  //     case 'PINNIES':
  //       return AmenityType.PINNIES;
  //     // Add cases for other enum values
  //     default:
  //       throw FormatException('Unknown amenity type: $amenity');
  //   }
  // }).toList();
  return amenitiesList.toList();
}


  Future<String> showAgreementDialog(BuildContext context) async {
    print("showAgreementDialogggg");
    String agreementToShow = "";
    String title = "";
    if(appModel.currentUser['hasAcceptedPrivacyPolicy'] == null || !appModel.currentUser['hasAcceptedPrivacyPolicy']){
      title = "Privacy Policy";
      await showDialog(
      context: context,
      builder: (BuildContext context)  {
        return AgreementFormWidget(
          title: title,
          bodyText: 'Your agreement text goes here...',
          onAccept: () async{
            print("Accepted");
            Map<String,dynamic> userInput = {
              "userId": appModel.currentUser['_id'],
              "hasAcceptedPrivacyPolicy": true,
              "hasAcceptedTermsAndConditions": "null"
            };
            await UserCommand().updateUsertermsAndPrivacy(userInput);
            Navigator.of(context).pop(); // Close the dialog

          },
          onReject: () {
            print("Rejected");
            Navigator.of(context).pop(); // Close the dialog
          },
        );
      },
    );

    }
    //  if(appModel.currentUser["hasAcceptedTermsAndConditions"] == null || !appModel.currentUser['hasAcceptedTermsAndConditions']){
    //   title = "Terms and Conditions";
    //   await showDialog(
    //   context: context,
    //   builder: (BuildContext context) {
    //     return AgreementFormWidget(
    //       title: title,
    //       bodyText: 'Your agreement text goes here...',
    //       onAccept: () async {
    //         print("Accepted");
    //         Map<String,dynamic> userInput = {
    //           "userId": appModel.currentUser['_id'],
    //           "hasAcceptedTermsAndConditions": true,
    //           "hasAcceptedPrivacyPolicy": "null",
    //         };
    //         await UserCommand().updateUsertermsAndPrivacy(userInput);
    //         Navigator.of(context).pop(); // Close the dialog
    //       },
    //       onReject: () {
    //         print("Rejected");
    //         Navigator.of(context).pop(); // Close the dialog
    //       },
    //     );
    //   },
    // );

    // }
    // else{
    //   print("Something Went wrong big dog");
    // }

    



    return agreementToShow;
  }

  String formatAmenitiesForGraphQL(List<AmenityType> amenities) {
    // Convert each enum value to a string and format it
    var amenityStrings =
        amenities.map((amenity) => amenity.toString().split('.').last);
    // Join the strings with commas and enclose them in curly braces
    return '{${amenityStrings.join(', ')}}';
  }

  String formatEventTime(String startTime, String endTime) {
    int startTimeInt = int.parse(startTime);
    int endTimeInt = int.parse(endTime);

    DateTime startDateTime = DateTime.fromMillisecondsSinceEpoch(startTimeInt);
    DateTime endDateTime = DateTime.fromMillisecondsSinceEpoch(endTimeInt);
    DateTime now = DateTime.now();

    String formattedStart;
    String formattedEnd;

    // Check if the year is the current year
    if (startDateTime.year == now.year) {
      formattedStart = DateFormat('M/d h:mma').format(startDateTime);
    } else {
      formattedStart = DateFormat('M/d/yyyy h:mma').format(startDateTime);
    }

    // Assuming the end time is on the same day as the start time
    formattedEnd = DateFormat('h:mma').format(endDateTime);

    return '$formattedStart-$formattedEnd';
  }

  startReloadTimer() {
    print("startReloadTimer");
    appModel.startTimer();
  }

  stopReloadTimer() {
    print("stopReloadTimer");
    appModel.stopTimer();
  }

  void resetReloadTimer() {
    print("resetReloadTimer");
    appModel.appTimeSinceLastLoad = 0;
    startReloadTimer();
  }

  void goToCreatePage(
    BuildContext context,
    int indexResult,
    List<dynamic> primaryList,
  ) {
    print("goToPage: $indexResult");
    print("primaryList: $primaryList");
    if (appModel.createPages.containsKey(primaryList[indexResult])) {
      Navigator.push(
        context,
        MaterialPageRoute<void>(
          builder: appModel.createPages[primaryList[indexResult]]!,
        ),
      );
    } else {
      print("Page key not found");
    }
  }

  List<Svg> getLocationSvgs() {
    return appModel.locationSvgs;
  }

  List<Svg> getPriceSvgs() {
    return appModel.priceSvgs;
  }

  int getDistanceFilter() {
    return appModel.distanceFilter;
  }

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
    groupPageModel = _mainContext.read();
    profilePageModel = _mainContext.read();
    requestsModel = _mainContext.read();
    requestsPageModel = _mainContext.read();
    chatPageModel = _mainContext.read();
    eventsPageModel = _mainContext.read();

    // homePageModel.nukeData();

    //services
    geoLocationServices = _mainContext.read();

    appModel.initialConditionsMet = false;
  }

  // Future<bool> uniquenessUserAttributesCheck(
  //     Map<String, dynamic> userAttributes) async {
  //   print("createUserAttributesCheck()");
  //   print("userAttributes: $userAttributes");
  //   bool createUserAttributesCheckResponse = true;
  //   try {
  //     String email = userAttributes['email'];
  //     String username = userAttributes['username'];
  //     String phone = userAttributes['phone'];
  //     dynamic userInput = {
  //       "email": email,
  //       "username": username,
  //       "phone": phone
  //     };
  //     print("userInput: $userInput");
  //     http.Response response = await http.post(
  //       Uri.parse('https://graphql.fauna.com/graphql'),
  //       headers: <String, String>{
  //         'Authorization': 'Bearer ${dotenv.env['FAUNADBSECRET']}',
  //         'Content-Type': 'application/json'
  //       },
  //       body: jsonEncode(<String, String>{
  //         'query': UserQueries().checkUserUniqueness(userInput),
  //       }),
  //     );

  //     print("response body: ");
  //     print(jsonDecode(response.body));
  //     dynamic data = jsonDecode(response.body)['data'];
  //     dynamic getUserByEmailResponse = data['getUserByEmail'];
  //     dynamic getUserByUsernameResponse = data['getUserByUsername'];
  //     dynamic getUserByPhoneResponse = data['getUserByPhone'];

  //     if (getUserByEmailResponse != null) {
  //       print("email already exists");
  //       createUserAttributesCheckResponse = false;
  //     }
  //     if (getUserByUsernameResponse != null) {
  //       print("username already exists");
  //       createUserAttributesCheckResponse = false;
  //     }
  //     if (getUserByPhoneResponse != null) {
  //       print("phone already exists");
  //       if (dotenv.env['ENVIRONMENT'] == "PRODUCTION") {
  //         //if in production, don't allow user to create account with phone number that already exists
  //         createUserAttributesCheckResponse = false;
  //       }
  //     }
  //   } catch (e) {
  //     print("createUserAttributesCheck error: ");
  //     print(e);
  //     createUserAttributesCheckResponse = false;
  //   }

  //   return createUserAttributesCheckResponse;
  // }

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

  Future<void> delete(context) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialogueWidget(
            title: 'Confirmation',
            body: StringConstants.DELETEWARNING + "\n\n"
                ,
            onConfirmCallback: () async {
              // Logic for confirmation action
             BaseCommand().nukeData();
            await AmplifyAuthService().signOut();
            },
            onCancelCallback: () {
              // Logic for cancel action
            },
          );
        },
      );
    

    
  }

  Future<void> signOut(context) async {
    BaseCommand().nukeData();
    // Navigator.of(context).pop();
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

    // var deviceState = await OneSignal.getDeviceState();

    //return if no deviceState is found
    // if (deviceState == null || deviceState.userId == null) {
    //   print("no deviceState found");
    //   return updateUserOSPIDResponse;
    // } else {
    //coming out to null
    print("deviceState found for userID: " + appModel.currentUser['_id']);
    // var playerId = deviceState.userId!;
    Map<String, dynamic> userInput = {
      '_id': appModel.currentUser['_id'],
      // "OSPID": playerId
    };
    await UserCommand().updateUser(userInput);

    updateUserOSPIDResponse["success"] = true;

    return updateUserOSPIDResponse;
    // }
  }

  Future<Map<String, dynamic>> setupUser(String email) async {
    print("setupUser");
    Map<String, dynamic> setupUserResp = {
      "success": false,
      "data": null,
    };
    Map<String, dynamic> getUserInput = {"email": email};

    try {
      if (!appModel.isGuest) {
        if(appModel.currentUser.isEmpty ){
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
              Map<String, dynamic> locationInput = {
                "latitude": 0,
                "longitude": 0
              };
              Map<String, dynamic> createPlayerResp = await PlayerCommand()
                  .createPlayer(userInput, {}, locationInput, false);
              user = createPlayerResp['data'];
            }
            appModel.currentUser = user;
            print("app model user: ");
            print(appModel.currentUser);
            // print("user['chats']['data']: ${user['chats']['data']}");
            // chatPageModel.generalChatList = user['chats']['data'];
            //setup onesignal
            
            print("testing some shit out!");
            //not being used so commented out
            // await loadUserImagesFromAWS();
            print(
                "get friends and myEvents from currentUser object: ${appModel.currentUser}");

            // await ImagesCommand().setUserProfileImage();
            setupUserResp['success'] = true;
            setupUserResp['data'] = user;
          } else {
            print("something went wrong in fetching user");
            // signOut(context);
          }

        }
        //appModel.currentUser is not empty: 
        else{
          print("niceeeeeeeeerrr");
          setupUserResp['success'] = true;
            setupUserResp['data'] = appModel.currentUser;
          await OneSignalService().login(appModel.currentUser['_id']);
        }
          appModel.isSuperUser = appModel.currentUser['isSuperUser'];
      } else {
        print("is guest");
      }
      return setupUserResp;
    } catch (e) {
      print("error in setupUser: ");
      print(e);
      return setupUserResp;
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
      // if (!appModel.isGuest) {
      //   await HomePageCommand().eventTypeTapped(Constants.MYEVENTS);
      // } else {
      Position userPosition = await GeoLocationCommand().determinePosition();
      LocationCommand().setCurrentPosition(userPosition);
      print("userPosition: $userPosition");
      appModel.currentUser['currentPosition'] = userPosition;
      await GeoLocationCommand()
          .setUserAddress(userPosition.latitude, userPosition.longitude);
      print("appModel.currentUser: " + appModel.currentUser.toString());
      await EventCommand().setArchivedEvents({"userId": appModel.currentUser['_id'], "startTime": DateTime.now().millisecondsSinceEpoch.toString()},  EventFragments().fullEvent());
      await HomePageCommand().eventTypeTapped(Constants.PICKUP);
      // }

      print("setup Events done");
      

      //,teams, players near me data.
      //get location and update user location
      print(
          "check appModel after setting userPosition: ${appModel.currentUser['currentPosition']}");
      //assume you have the latest events
      // Map<String, dynamic> findEventsNearPointResp =
      //     await EventCommand().findEventsNearPoint(eventsModel.events, 50);
      BaseCommand().startReloadTimer();

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

  void updateIsRatingDialogueShowing(bool newVal) {
    appModel.isRatingDialogueShowing = newVal;
  }

  void setOnboarded(bool onboarded) {
    if (onboarded == null) {
      onboarded = false;
    }
    appModel.onboarded = onboarded;
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

  Future<Widget> getRequestCard(
      String selectedKey, dynamic requestObject) async {
    print("getRequestCard()");
    print("selectedKey: " + selectedKey);
    print("requestObject: " + requestObject.toString());
    print("requestObject['type'].toString(): " +
        requestObject['type'].toString());
    dynamic user = UserCommand().getAppModelUser();
    bool didSendRequest = user['_id'] == requestObject['sender']['_id'];
    if (requestObject['type'].toString() ==
        Constants.FRIENDREQUEST.toString()) {
      Widget card = FriendRequestCard(
        friendRequestObject: requestObject,
        didSendRequest: didSendRequest,
      );
      return card;
    } else if (requestObject['type'].toString() ==
            Constants.GAMEREQUEST.toString() ||
        requestObject['type'].toString() ==
            Constants.TOURNAMENTREQUEST.toString() ||
        requestObject['type'].toString() ==
            Constants.LEAGUEREQUEST.toString() ||
        requestObject['type'].toString() ==
            Constants.TRAININGREQUEST.toString() ||
        requestObject['type'].toString() ==
            Constants.TRYOUTREQUEST.toString()) {
      Widget card = TSNEventRequestCard(
        eventRequestCardDetails: requestObject,
        backgroundColor: AppColors.tsnAlmostBlack,
      );
      // Widget card = EventRequestCard(
      //     eventRequestObject: requestObject,
      //     type: requestObject['type'],
      //     didSendRequest: didSendRequest);
      return card;
    } else {
      print("elseeeeee");
      print("team: " + requestObject['team'].toString());
      dynamic findTeamByIdResponse = await TeamCommand()
          .findTeamById({"_id": requestObject['team']['_id']});
      dynamic team = findTeamByIdResponse['data'];
      print("team: " + team.toString());
      dynamic teamDetails = await TeamCommand().getUserTeamDetails(team, false);
      print("teamDetails: " + teamDetails.toString());
      Widget card = TeamRequestCard(
        teamRequestObject: requestObject,
        didSendRequest: didSendRequest,
        userTeamDetails: teamDetails,
      );
      return card;
    }
  }

  Future<Widget> getCard(
      dynamic selectedKey, dynamic selectedObject, Svg svgImage) async {
    print("getCard()");
    print("selectedKey: " + selectedKey.toString());
    print("selectedObject: " + selectedObject.toString());

    Widget card = Text(
        "null"); //PickupCard2(gameObject: selectedObject, svgImage: svgImage, isMyEvent: isMyEvent);

    if (selectedKey == Constants.PICKUP) {
      print("selected pickup: " + selectedObject.toString());
      print("before getEventDetails");
      //first approach
      dynamic getEventDetailsResp =
          await EventCommand().getUserEventDetails([selectedObject], true);
      print("after getEventDetails");
      card = TSNPickupCard(
        pickupCardDetails: getEventDetailsResp,
        backgroundColor: AppColors.tsnAlmostBlack,
        svgImage: svgImage,
      );
    } else if (selectedKey == Constants.REQUESTSSENT ||
        selectedKey == Constants.REQUESTSRECEIVED) {
      card = await RequestsCommand()
          .getRequestCard("EVENTREQUEST", selectedObject);
    } else if (selectedKey == Constants.TRAINING) {
      dynamic getEventDetailsResp =
          await EventCommand().getUserEventDetails([selectedObject], false);
      card = TSNTrainingCard(
        trainingCardDetails: getEventDetailsResp,
        backgroundColor: AppColors.tsnAlmostBlack,
        svgImage: svgImage,
      );
    } else if (selectedKey == Constants.TRYOUT) {
      print("selected tryout");
      dynamic getEventDetailsResp =
          await EventCommand().getUserEventDetails([selectedObject], false);
      card = TSNTryoutCard(
        tryoutCardDetails: getEventDetailsResp,
        backgroundColor: AppColors.tsnAlmostBlack,
        svgImage: svgImage,
      );
    } else if (selectedKey == Constants.TOURNAMENT) {
      print("selectedObject: " + selectedObject.toString());
      dynamic getEventDetailsResp =
          await EventCommand().getUserEventDetails([selectedObject], false);

      card = TSNTournamentCard(
        tournamentCardDetails: getEventDetailsResp,
        backgroundColor: AppColors.tsnAlmostBlack,
        svgImage: svgImage,
      );
    } else if (selectedKey == Constants.LEAGUE) {
      dynamic getEventDetailsResp =
          await EventCommand().getUserEventDetails([selectedObject], false);
      card = LeagueCard(
          leagueObject: selectedObject,
          svgImage: svgImage,
          userEventDetails: getEventDetailsResp);
    } else if (selectedKey == Constants.PLAYER) {
      dynamic playerDetails =
          await UserCommand().getUserDetails(selectedObject, false);
      card = TSNPlayerCard(
        playerCardDetails: playerDetails,
        backgroundColor: AppColors.tsnAlmostBlack,
        svgImage: svgImage,
      );
    } else if (selectedKey == Constants.TEAM) {
      dynamic userTeamDetails =
          await TeamCommand().getUserTeamDetails(selectedObject, false);
      card = TSNTeamCard(
        teamCardDetails: userTeamDetails,
        backgroundColor: AppColors.tsnAlmostBlack,
        svgImage: svgImage,
      );
    } else if (selectedKey == Constants.GROUP) {
      dynamic userGroupDetails =
          await GroupCommand().getUserGroupDetails(selectedObject, false);
      card = TSNGroupCard(
        groupCardDetails: userGroupDetails,
        backgroundColor: AppColors.tsnAlmostBlack,
        svgImage: svgImage,
      );
    } else if (selectedKey == Constants.MYTEAMS) {
      print("selectedKey == MYTEAMS");
      print("selectedObject: " + selectedObject.toString());
      dynamic team = selectedObject['team'];
      dynamic userTeamDetails =
          await TeamCommand().getUserTeamDetails(team, true);
      print("teammmmmm: " + team.toString());
      print("userTeamDetails: " + userTeamDetails.toString());
      card = TSNTeamCard(
        teamCardDetails: userTeamDetails,
        backgroundColor: AppColors.tsnAlmostBlack,
        svgImage: svgImage,
      );
    } else if (selectedKey == Constants.MYGROUPS) {
      print("selectedKey == MYGROUPS");
      print("selectedObject: " + selectedObject.toString());
      dynamic group = selectedObject['group'];
      dynamic userGroupDetails =
          await GroupCommand().getUserGroupDetails(group, true);
      print("grouppup: " + group.toString());
      print("userGroupDetails: " + userGroupDetails.toString());
      card = TSNGroupCard(
        groupCardDetails: userGroupDetails,
        backgroundColor: AppColors.tsnAlmostBlack,
        svgImage: svgImage,
      );
    }
    //My Events
    else if (selectedKey == Constants.MYEVENTS) {
      dynamic event = null;
      print("MYEVENTS");
      print(selectedObject['event']);
      if (selectedObject['event'] == null) {
      } else if (selectedObject['event']['type'].toString() == "GAME") {
        print("TYPE GAME");

        dynamic getEventDetailsResp = await EventCommand()
            .getUserEventDetails([selectedObject['event']], true);
        print("getEventDetailsResp: " + getEventDetailsResp.toString());
        card = TSNPickupCard(
          pickupCardDetails: getEventDetailsResp,
          backgroundColor: AppColors.tsnAlmostBlack,
          svgImage: svgImage,
        );
      } else if (selectedObject['event']['type'].toString() == "TRAINING") {
        print("selectedObject['event']['trainings']: " +
            selectedObject['event']['trainings'].toString());
        dynamic getEventDetailsResp = await EventCommand()
            .getUserEventDetails([selectedObject['event']], false);
        card = TrainingCard(
            trainingObject: selectedObject['event'],
            svgImage: svgImage,
            userEventDetails: getEventDetailsResp);
      } else if (selectedObject['event']['type'].toString() == "TRYOUT") {
        dynamic getEventDetailsResp = await EventCommand()
            .getUserEventDetails([selectedObject['event']], false);
        card = TryoutCard(
            tryoutObject: selectedObject['event'],
            svgImage: svgImage,
            userEventDetails: getEventDetailsResp);
      } else if (selectedObject['event']['type'].toString() == "TOURNAMENT") {
        dynamic getEventDetailsResp = await EventCommand()
            .getUserEventDetails([selectedObject['event']], false);
        card = TournamentCard(
            tournamentObject: selectedObject['event'],
            svgImage: svgImage,
            userEventDetails: getEventDetailsResp);
      } else if (selectedObject['event']['type'].toString() == "LEAGUE") {
        dynamic getEventDetailsResp = await EventCommand()
            .getUserEventDetails([selectedObject['event']], false);
        card = LeagueCard(
            leagueObject: selectedObject['event'],
            svgImage: svgImage,
            userEventDetails: getEventDetailsResp);
      }
    }

    return card;
  }
}
