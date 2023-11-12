import 'dart:convert';
import 'package:amplify_api/amplify_api.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:soccermadeeasy/commands/home_page_command.dart';
import 'package:soccermadeeasy/graphql/fragments/user_fragments.dart';
import '../constants.dart';
import '../graphql/mutations/requests.dart';
import 'base_command.dart';

import '../graphql/queries/users.dart';
import '../graphql/mutations/users.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../commands/notifications_command.dart';
import '../models/enums/payment_status_type.dart';
import 'images_command.dart';

class UserCommand extends BaseCommand {
  updateOrganizer() {
    //iterate through events and find
  }

  Future<Map<String,dynamic>> getUserDetails(dynamic user, bool addToProfilePageModel) async {
    print("loadInitialData Profile: " + user.toString());
    Map<String,dynamic> getUserDetailsResp = {
      "success": false,
      "user": user,
      "objectImageInput": {},
      "followers": [],
      "following": [],
      "eventUserParticipants": [],
      "teamUserParticipants": [],
      "isMine": false,
    };

    try{
       //get current user
    String imageUrl = "";


    if (appModel.currentUser['_id'] == user['_id']) {
      user = appModel.currentUser;
      getUserDetailsResp['isMine'] = true;
      imageUrl = UserCommand().getProfileImage();      
      // profilePageModel.user = UserCommand().getAppModelUser();

      if (imageUrl == '') {
        String? key = user['mainImageKey'];
        if (key != null) {
          Map<String, dynamic> getUserProfileImageResp =
              await ImagesCommand().getImage(key);
          print("getUserProfileImageResp: $getUserProfileImageResp");
          if (getUserProfileImageResp['success']) {
            imageUrl = getUserProfileImageResp['data']['signedUrl'];
            userModel.profileImageUrl = imageUrl;
          }
        }
      }
    } else {
      Map<String, dynamic> findMyUserByIdResp =
          await UserCommand().findUserById(user);
      print("findMyUserByIdResp: $findMyUserByIdResp");
      if (findMyUserByIdResp['success']) {
        // profilePageModel.user = findMyUserByIdResp['data'];
        String? key = user['mainImageKey'];
        print("key: $key");
        if (key != null) {
          Map<String, dynamic> getUserProfileImageResp =
              await ImagesCommand().getImage(key);
          print("getUserProfileImageResp: $getUserProfileImageResp");
          if (getUserProfileImageResp['success']) {
            imageUrl = getUserProfileImageResp['data']['signedUrl'];
          }
        }
      }
    }
    print("loadInitialData Profile imageUrl: $imageUrl");

    getUserDetailsResp['objectImageInput'] = {
      "imageUrl": imageUrl,
      "containerType": Constants.PROFILEIMAGECIRCLE
    };

    getUserDetailsResp['eventUserParticipants'] =
      user['eventUserParticipants']['data'];
    getUserDetailsResp['teamUserParticipants'] =
        user['teamUserParticipants']['data'];
    getUserDetailsResp['isProfilePrivate'] = user['isProfilePrivate'];

    if(addToProfilePageModel){
      
      profilePageModel.isMine = getUserDetailsResp['isMine'];
      profilePageModel.user = user;
      profilePageModel.objectImageInput = getUserDetailsResp['objectImageInput'];
      profilePageModel.eventUserParticipants = getUserDetailsResp['eventUserParticipants'];
      profilePageModel.teamUserParticipants = getUserDetailsResp['teamUserParticipants'];
      profilePageModel.isProfilePrivate = getUserDetailsResp['isProfilePrivate'];

    }
      return getUserDetailsResp;
    } catch(e) {

      return getUserDetailsResp;
    }
   
  }

  String getProfileImage() {
    print("getProfileImage");
    print("appModel.currentUser.profileImage: ${userModel.profileImageUrl}");
    return userModel.profileImageUrl;
  }

  dynamic getAppModelUser() {
    print("getAppModelUser");
    print("appMOdel.currentUser: " + appModel.currentUser.toString());

    return appModel.currentUser;
  }

  dynamic setAppModelUser(dynamic userData) {
    print("setAppModelUser");
    print("appModel.currentUser: $userData");
    appModel.currentUser = userData;

    return appModel.currentUser;
  }

  dynamic getFriendsModel() {
    print("getFriendsModel");
    print("appMOdel.friends: " + appModel.friends.toString());

    return appModel.friends;
  }

  List<dynamic> getAppModelMyEvents() {
    print("getAppModelMyEvents");
    print("appModel.myEvents: " + appModel.myEvents.toString());
    return appModel.myEvents;
  }

  //get myTeams
  Future<List<dynamic>> getAppModelMyTeams() async {
    print("getAppModelMyTeams");
    print("appModel.myTeams: " + appModel.myTeams.toString());
    if (appModel.myTeams.length == 0) {
      await HomePageCommand().getSelectedObjects(Constants.MYTEAMS);
    }
    return appModel.myTeams;
  }

  dynamic getParticipantIdByUserId(List<dynamic> dataList, String userId) {
    for (var data in dataList) {
      if (data['user']['_id'] == userId) {
        return data;
      }
    }
    return null;
  }

  void updatePaymentStatus(PaymentStatusType status) {
    print("updatePaymentStatus");
    print("paymentModel.status before....: " + paymentModel.status.toString());
    paymentModel.status = status;
    print("paymentModel.status after....: " + paymentModel.status.toString());
  }

  Future<Map<String, dynamic>> updateUser(
      Map<String, dynamic> userInput) async {
    print("updateUser");
    Map<String, dynamic> updateUserResponse = {
      "success": false,
      "message": "Default Error",
      "data": null
    };
    try {
      http.Response response = await http.post(
        Uri.parse('https://graphql.fauna.com/graphql'),
        headers: <String, String>{
          'Authorization': 'Bearer ${dotenv.env['FAUNADBSECRET']}',
          'Content-Type': 'application/json'
        },
        body: jsonEncode(<String, String>{
          'query': UserMutations().updateUser(userInput),
        }),
      );

      print("response body: ");
      print(jsonDecode(response.body));

      Map<String, dynamic> user =
          jsonDecode(response.body)['data']['updateUser'];

      updateUserResponse["success"] = true;
      updateUserResponse["message"] = "User Updated";
      updateUserResponse["data"] = user;

      return updateUserResponse;
    } on ApiException catch (e) {
      print('Mutation failed: $e');
      return updateUserResponse;
    }
  }

  Future<Map<String, dynamic>> updateUserProfilePrivateStatus(
      Map<String, dynamic> userInput) async {
    Map<String, dynamic> updateUserProfilePrivateStatusResponse = {
      "success": false,
      "message": "Default Error",
      "data": null
    };
    try {
      userInput['userId'] = appModel.currentUser['_id'];

      http.Response response = await http.post(
        Uri.parse('https://graphql.fauna.com/graphql'),
        headers: <String, String>{
          'Authorization': 'Bearer ${dotenv.env['FAUNADBSECRET']}',
          'Content-Type': 'application/json'
        },
        body: jsonEncode(<String, String>{
          'query': UserMutations().updateUserPrivateStatus(userInput),
        }),
      );

      print("response body: ");
      print(jsonDecode(response.body));

      Map<String, dynamic> user =
          jsonDecode(response.body)['data']['updateUser'];

      if (user['_id'] != null) {
        appModel.currentUser = user;
        profilePageModel.user = user;
      }

      updateUserProfilePrivateStatusResponse["success"] = true;
      updateUserProfilePrivateStatusResponse["message"] = "User Updated";
      updateUserProfilePrivateStatusResponse["data"] = user;

      return updateUserProfilePrivateStatusResponse;
    } on ApiException catch (e) {
      print('Mutation failed: $e');
      return updateUserProfilePrivateStatusResponse;
    }
  }

  Future<Map<String, dynamic>> createUserCustomer(
      Map<String, dynamic> userInput,
      Map<String, dynamic> stripeCustomerInput) async {
    print("createUserCustomer");
    print("userInput: " + userInput.toString());
    Map<String, dynamic> updateUserResponse = {
      "success": false,
      "message": "Default Error",
      "data": null
    };
    try {
      http.Response response = await http.post(
        Uri.parse('https://graphql.fauna.com/graphql'),
        headers: <String, String>{
          'Authorization': 'Bearer ' + dotenv.env['FAUNADBSECRET'].toString(),
          'Content-Type': 'application/json'
        },
        body: jsonEncode(<String, String>{
          'query': UserMutations()
              .createUserStripeCustomer(userInput, stripeCustomerInput),
        }),
      );

      print("response body: ");
      print(jsonDecode(response.body));

      Map<String, dynamic> user =
          jsonDecode(response.body)['data']['createStripeCustomer'];

      updateUserResponse["success"] = true;
      updateUserResponse["message"] = "User Updated";
      updateUserResponse["data"] = user;

      return updateUserResponse;
    } on ApiException catch (e) {
      print('Mutation failed: $e');
      return updateUserResponse;
    }
  }

  void setUserID() {
    // userModel.userID = userId;
  }

  Future<Map<String, dynamic>> partialUpdateUser(
      dynamic processedUserInput) async {
    print("partialUpdateUser");
    print("processedUserInput: " + processedUserInput.toString());

    Map<String, dynamic> partialUpdateUserResponse = {
      "success": false,
      "message": "Default Error",
      "data": null
    };

    try {
      http.Response response = await http.post(
        Uri.parse('https://graphql.fauna.com/graphql'),
        headers: <String, String>{
          'Authorization': 'Bearer ${dotenv.env['FAUNADBSECRET']}',
          'Content-Type': 'application/json'
        },
        body: jsonEncode(<String, String>{
          'query': UserMutations().partialUserUpdate(processedUserInput),
        }),
      );

      print("response body: ");
      print(jsonDecode(response.body));
      partialUpdateUserResponse["success"] = true;
      partialUpdateUserResponse["message"] = "User Updated";
      partialUpdateUserResponse["data"] =
          jsonDecode(response.body)['data']['partialUpdateUser'];
      //todo update appModel.currentUser
      appModel.currentUser = partialUpdateUserResponse["data"];
      print("appModel.currentUser: " + appModel.currentUser.toString());

      return partialUpdateUserResponse;
    } on ApiException catch (e) {
      print('Mutation failed: $e');
      return partialUpdateUserResponse;
    }
  }

  Future<Map<String, dynamic>> sendFriendRequest(dynamic friendInput) async {
    print("sendFriendRequest");
    Map<String, dynamic> sendFriendRequestResponse = {
      "success": false,
      "message": "Default Error",
      "data": null
    };
    try {
      print("request for friend: " + friendInput.toString());

      Map<String, dynamic> sendFriendRequestInput = {
        "sender_id": appModel.currentUser['_id'],
        "receiver_id": friendInput['_id'],
      };
      print("sendFriendRequestInput");
      print(sendFriendRequestInput);

      print("set OSPIDs and phones");
      //populate list with onesignal player ids
      List<String> OSPIDs = [];
      List<String> phones = [];

      OSPIDs.add(friendInput['OSPID']);
      phones.add(friendInput['phone']);

      //create FriendRequest Object
      http.Response response = await http.post(
        Uri.parse('https://graphql.fauna.com/graphql'),
        headers: <String, String>{
          'Authorization': 'Bearer ' + dotenv.env['FAUNADBSECRET'].toString(),
          'Content-Type': 'application/json'
        },
        body: jsonEncode(<String, String>{
          'query': RequestMutations().sendFriendRequest(sendFriendRequestInput),
        }),
      );

      print("responseee body: ");
      print(jsonDecode(response.body));

      //send friend request notifications
      Map<String, dynamic> sendOrganizerRequestNotificationInput = {
        "phones": phones,
        "message": appModel.currentUser['username'] +
            " has sent you a friend request!",
        "OSPIDs": OSPIDs
      };
      await NotificationsCommand().sendOrganizerRequestNotification(
          sendOrganizerRequestNotificationInput);

      sendFriendRequestResponse["success"] = true;
      sendFriendRequestResponse["message"] = "Friend Request Created";
      // sendFriendRequestResponse["data"] = jsonDecode(response.body)['data']['CreateFriendRequest'];
    } catch (e) {}

    return sendFriendRequestResponse;
  }

  Future<Map<String, dynamic>> addEvent(
      Map<String, dynamic> userInput, Map<String, dynamic> eventInput) async {
    print("addEvent");
    Map<String, dynamic> addEventResponse = {
      "success": false,
      "message": "Default Error",
      "data": null
    };

    try {
      http.Response response = await http.post(
        Uri.parse('https://graphql.fauna.com/graphql'),
        headers: <String, String>{
          'Authorization': 'Bearer ' + dotenv.env['FAUNADBSECRET'].toString(),
          'Content-Type': 'application/json'
        },
        body: jsonEncode(<String, String>{
          'query': UserMutations().addEvent(userInput, eventInput),
        }),
      );

      print("response body: ");
      print(jsonDecode(response.body));

      addEventResponse["success"] = true;
      addEventResponse["message"] = "User added to Event";
      addEventResponse["data"] =
          jsonDecode(response.body)['data']['updateUser'];
    } catch (e) {
      print("error");
    }

    return addEventResponse;
  }

  bool isCurrentUserFollowingUser(dynamic userObject) {
    print("isUserFollowingUser");
    print("userObject: " + userObject.toString());
    dynamic currentUser = appModel.currentUser;
    List<dynamic> followings = currentUser['following']['data'];
    return followings
        .any((relation) => relation['following']['_id'] == userObject['_id']);
  }

  bool isCurrentUserFollowedByUser(dynamic userObject) {
    print("isUserFollowedByUser");
    dynamic currentUser = appModel.currentUser;
    List<dynamic> followings = currentUser['followers']['data'];
    return followings
        .any((relation) => relation['follower']['_id'] == userObject['_id']);
  }

  Future<Map<String, dynamic>> addTeam(Map<String, dynamic> userInput,
      Map<String, dynamic> teamInput, String role) async {
    print("addTeam");
    Map<String, dynamic> addTeamResponse = {
      "success": false,
      "message": "Default Error",
      "data": null
    };

    try {
      http.Response response = await http.post(
        Uri.parse('https://graphql.fauna.com/graphql'),
        headers: <String, String>{
          'Authorization': 'Bearer ' + dotenv.env['FAUNADBSECRET'].toString(),
          'Content-Type': 'application/json'
        },
        body: jsonEncode(<String, String>{
          'query': UserMutations().addUserToTeam(userInput, teamInput, role),
        }),
      );

      print("response body: ");
      print(jsonDecode(response.body));

      addTeamResponse["success"] = true;
      addTeamResponse["message"] = "Team added";
      addTeamResponse["data"] = jsonDecode(response.body)['data']['updateUser'];
    } catch (e) {
      print("error");
    }

    return addTeamResponse;
  }

  Future<Map<String, dynamic>> followUser(dynamic followUserInput) async {
    print("followUser");
    Map<String, dynamic> followUserResponse = {
      "success": false,
      "message": "Default Error",
      "data": null
    };

    try {
      http.Response response = await http.post(
        Uri.parse('https://graphql.fauna.com/graphql'),
        headers: <String, String>{
          'Authorization': 'Bearer ' + dotenv.env['FAUNADBSECRET'].toString(),
          'Content-Type': 'application/json'
        },
        body: jsonEncode(<String, String>{
          'query': UserMutations().followUser(followUserInput),
        }),
      );

      print("response body: ");
      print(jsonDecode(response.body));

      if (response.statusCode == 200) {
        dynamic createdFollowRelation =
            jsonDecode(response.body)['data']['createFollowRelation'];
        print("createdFollowRelation: " + createdFollowRelation.toString());
        followUserResponse["success"] = true;
        followUserResponse["message"] = "Followed Player";
        followUserResponse["data"] = createdFollowRelation;
      }
    } catch (e) {
      print("error");
    }

    return followUserResponse;
  }

  void updateUserModelWithUser(dynamic user) {
    print("updateUserModelWithUser");
    appModel.currentUser = user;
    print("appModel.currentUser: " + appModel.currentUser.toString());
  }

  Future<Map<String, dynamic>> getCurrentUserByEmail() async {
    print("getCurrentUserByEmail");
    Map<String, dynamic> getUserResp = {
      "success": false,
      "message": "no user found",
      "data": null
    };
    try {
      String email = appModel.currentUser['email'];
      print("email: ");
      print(email);
      Map<String, dynamic> userInput = {"email": email};
      http.Response response = await http.post(
        Uri.parse('https://graphql.fauna.com/graphql'),
        headers: <String, String>{
          'Authorization': 'Bearer ' + dotenv.env['FAUNADBSECRET'].toString(),
          'Content-Type': 'application/json'
        },
        body: jsonEncode(<String, String>{
          'query': UserQueries().getUserByEmail(userInput),
        }),
      );

      print("response: ");
      print(jsonDecode(response.body));
      final result = jsonDecode(response.body)['data']['getUserByEmail'];
      // if (result != null) {
      getUserResp["success"] = true;
      getUserResp["message"] = "user found";
      getUserResp["data"] = result;
      // }
    } catch (e) {
      print('Query failed: $e');
    }
    return getUserResp;
  }

  Future<Map<String, dynamic>> getUserByEmail(
      Map<String, dynamic> userInput) async {
    print("getUserByEmail()");
    print("userInput: $userInput");
    Map<String, dynamic> getUserResp = {
      "success": false,
      "message": "no user found",
      "data": null
    };
    try {
      http.Response response = await http.post(
        Uri.parse('https://graphql.fauna.com/graphql'),
        headers: <String, String>{
          'Authorization': 'Bearer ' + dotenv.env['FAUNADBSECRET'].toString(),
          'Content-Type': 'application/json'
        },
        body: jsonEncode(<String, String>{
          'query': UserQueries().getUserByEmail(userInput),
        }),
      );

      print("response: ");

      print(jsonDecode(response.body));
      if ((jsonDecode(response.body) as Map<String, dynamic>)
              .containsKey('errors') &&
          (jsonDecode(response.body) as Map<String, dynamic>)['errors'] !=
              null) {
        getUserResp["success"] = false;
        getUserResp["message"] = "no user found";
      } else {
        final result = jsonDecode(response.body)['data']['getUserByEmail'];
        // if (result != null) {
        getUserResp["success"] = true;
        getUserResp["message"] = "user found";
        getUserResp["data"] = result;
      }

      // }
    } catch (e, s) {
      print(s);
      print('Query failed: $e');
    }
    return getUserResp;
  }

  Future<Map<String, dynamic>> findMyUserById() async {
    print("findMyUserById()");
    Map<String, dynamic> getUserResp = {
      "success": false,
      "message": "no user found",
      "data": null
    };
    try {
      // print("appModel.currentUser: " + appModel.currentUser.toString());

      http.Response response = await http.post(
        Uri.parse('https://graphql.fauna.com/graphql'),
        headers: <String, String>{
          'Authorization': 'Bearer ' + dotenv.env['FAUNADBSECRET'].toString(),
          'Content-Type': 'application/json'
        },
        body: jsonEncode(<String, String>{
          'query': UserQueries().findUserByID(appModel.currentUser, UserFragments().fullUser()),
        }),
      );

      print("response: ");
      print(jsonDecode(response.body));
      final result = jsonDecode(response.body)['data']['findUserByID'];
      // appModel.currentUser = result;
      // if (result != null) {
      getUserResp["success"] = true;
      getUserResp["message"] = "user found";
      getUserResp["data"] = result;
      // }
    } catch (e) {
      print('Query failed: $e');
    }
    return getUserResp;
  }

  Future<Map<String, dynamic>> findUserById(
      Map<String, dynamic> userInput) async {
    print("getUser");
    Map<String, dynamic> getUserResp = {
      "success": false,
      "message": "no user found",
      "data": null
    };
    try {
      print("userInput: ");
      print(userInput);
      http.Response response = await http.post(
        Uri.parse('https://graphql.fauna.com/graphql'),
        headers: <String, String>{
          'Authorization': 'Bearer ' + dotenv.env['FAUNADBSECRET'].toString(),
          'Content-Type': 'application/json'
        },
        body: jsonEncode(<String, String>{
          'query': UserQueries().findUserByID(userInput, UserFragments().fullUser()),
        }),
      );

      print("response: ");
      print(jsonDecode(response.body));
      final result = jsonDecode(response.body)['data']['findUserByID'];
      // appModel.currentUser = result;
      // if (result != null) {
      getUserResp["success"] = true;
      getUserResp["message"] = "user found";
      getUserResp["data"] = result;
      // }
    } catch (e) {
      print('Query failed: $e');
    }
    return getUserResp;
  }

  Future<Map<String, dynamic>> findUserPlayerById(
      Map<String, dynamic> userInput) async {
    print("getUser");
    Map<String, dynamic> getUserResp = {
      "success": false,
      "message": "no user found",
      "data": null
    };
    try {
      print("userInput: ");
      print(userInput);
      http.Response response = await http.post(
        Uri.parse('https://graphql.fauna.com/graphql'),
        headers: <String, String>{
          'Authorization': 'Bearer ' + dotenv.env['FAUNADBSECRET'].toString(),
          'Content-Type': 'application/json'
        },
        body: jsonEncode(<String, String>{
          'query': UserQueries().findUserPlayerByID(userInput),
        }),
      );

      print("response: ");
      print(jsonDecode(response.body));
      final result = jsonDecode(response.body)['data']['findUserByID'];
      appModel.currentUser = result;
      // if (result != null) {
      getUserResp["success"] = true;
      getUserResp["message"] = "user found";
      getUserResp["data"] = result;
      // }
    } catch (e) {
      print('Query failed: $e');
    }
    return getUserResp;
  }

  Future<Map<String, dynamic>> getAllUsers() async {
    print("getUsers");
    Map<String, dynamic> resp = {
      "success": false,
      "message": "no users found",
      "data": null
    };
    try {
      print("before query");

      final result = null;
      // final readRespositoriesResult = useQuery(
      //   QueryOptions(
      //     document: gql(UserQueries.getAllUsers), // this is the query string you just created
      //     variables: {
      //       'nRepositories': 50,
      //     },
      //     pollInterval: const Duration(seconds: 10),
      //   ),
      // );
      // final result = readRespositoriesResult.result;

      print("users got: ");
      print(result);
    } catch (e) {
      print('Query failed: $e');
    }
    return resp;
  }

  Future<Map<String, dynamic>> configureOneSignalUserDetails() async {
    print("configureOneSignalUserDetails");
    Map<String, dynamic> configureOneSignalUserDetailsResp = {
      "success": false,
      "message": "Default Error"
    };

    try {
      // Add the following line to add Auth plugin to your app.
      // Pass in email provided by customer
      OneSignal.shared.setEmail(email: appModel.currentUser['email']);
      print("phone number to set: " + appModel.currentUser['phone']);
      // Pass in phone number provided by customer
      OneSignal.shared
          .setSMSNumber(smsNumber: "1" + appModel.currentUser['phone']);
      OneSignal.shared.sendTag("username", appModel.currentUser['username']);

      Map<String, dynamic> updateUserOSPIDResp = await updateUserOSPID();

      configureOneSignalUserDetailsResp["success"] = true;
      configureOneSignalUserDetailsResp["message"] = "Twilio Configured";

      appModel.onesignalUserDetailsSetup = true;
    } on Exception catch (e) {
      print('An error occurred in configureOneSignalUserDetailsResp() : $e');
    }

    return configureOneSignalUserDetailsResp;
  }
}
