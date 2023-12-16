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

  void updateUserAccountDetails(Map<String,dynamic> accountDetailsInput){
    print("updateUserAccountDetails");
    print("accountDetailsInput: "+accountDetailsInput.toString());
    appModel.currentUser['name'] = accountDetailsInput['name'];
    appModel.currentUser['birthdate'] = accountDetailsInput['birthdate'];
    appModel.currentUser['gender'] = accountDetailsInput['gender'];

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
      print("is mineeeee");
      user = appModel.currentUser;
      getUserDetailsResp['isMine'] = true;
      imageUrl = '';//UserCommand().getProfileImage();            

      if (imageUrl == '') {
        String? key = Constants.privateBetaProfileImages[user['profileImageIndex']];//user['mainImageKey'];
        print("currentUser keyyyyy: $key");
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
        profilePageModel.user = findMyUserByIdResp['data'];
        user = findMyUserByIdResp['data'];
        String? key = Constants.privateBetaProfileImages[user['profileImageIndex']];//user['mainImageKey'];
        print("keyyyyy: $key");
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
      user['eventUserParticipants'];
    
    // getUserDetailsResp['isProfilePrivate'] = user['isProfilePrivate'];
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

  Future<Map<String, dynamic>> deleteUser(
      Map<String, dynamic> userInput) async {
    print("createUserCustomer");
    print("userInput: " + userInput.toString());
    Map<String, dynamic> updateUserResponse = {
      "success": false,
      "message": "Default Error",
      "data": null
    };
    try {
      http.Response response = await http.post(
        Uri.parse(dotenv.env['APOLLO_SERVER'].toString()),
        headers: <String, String>{          
          'Content-Type': 'application/json'
        },
        body: jsonEncode(<String, String>{
          'query': UserMutations()
              .deleteUser(userInput),
        }),
      );

      print("response body: ");
      print(jsonDecode(response.body));

      if(response.statusCode == 200){
        final result = jsonDecode(response.body)['data']['deleteUser'];
        if(result['success']){          
          updateUserResponse["success"] = true;
          updateUserResponse["message"] = "Successfully Deleted User";          

        }
        else{
          updateUserResponse["success"] = false;
          updateUserResponse["message"] = "Something Went Wrong";
          updateUserResponse["data"] = null;
        }
      }
      else{
        updateUserResponse["success"] = false;
          updateUserResponse["message"] = "Something Went Wrong";
          updateUserResponse["data"] = null;
      }


      return updateUserResponse;
    } on ApiException catch (e) {
      print('Mutation failed: $e');
      return updateUserResponse;
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
        Uri.parse(dotenv.env['APOLLO_SERVER'].toString()),
        headers: <String, String>{          
          'Content-Type': 'application/json'
        },
        body: jsonEncode(<String, String>{
          'query': UserMutations()
              .createUserStripeCustomer(userInput, stripeCustomerInput),
        }),
      );

      print("response body: ");
      print(jsonDecode(response.body));

      if(response.statusCode == 200){
        final result = jsonDecode(response.body)['data']['createStripeCustomer'];
        if(result['success']){
          Map<String, dynamic> user =
              result['stripeCustomer']['user'];

          updateUserResponse["success"] = true;
          updateUserResponse["message"] = "User Updated";
          updateUserResponse["data"] = user;

        }
        else{
          updateUserResponse["success"] = false;
          updateUserResponse["message"] = "Something Went Wrong";
          updateUserResponse["data"] = null;
        }
      }
      else{
        updateUserResponse["success"] = false;
          updateUserResponse["message"] = "Something Went Wrong";
          updateUserResponse["data"] = null;
      }


      return updateUserResponse;
    } on ApiException catch (e) {
      print('Mutation failed: $e');
      return updateUserResponse;
    }
  }

  void setUserID() {
    // userModel.userID = userId;
  }

  Future<Map<String, dynamic>> updateUsertermsAndPrivacy(
      dynamic userInput) async {
    print("updateAgreement");
    print("userInput: " + userInput.toString());

    Map<String, dynamic> partialUpdateUserResponse = {
      "success": false,
      "message": "Default Error",
      "data": null
    };

    try {
      http.Response response = await http.post(
        Uri.parse(dotenv.env['APOLLO_SERVER'].toString()),
        headers: <String, String>{          
          'Content-Type': 'application/json'
        },
        body: jsonEncode(<String, String>{
          'query': UserMutations().updateUsertermsAndPrivacy(userInput),
        }),
      );
      

      print(jsonDecode(response.body));
      print("response.statusCode: " + response.statusCode.toString());
      if (response.statusCode == 200) {                              
        final result = jsonDecode(response.body)['data']['updateUsertermsAndPrivacy'];
        partialUpdateUserResponse["data"] = null;
        if (result['success']) {
          partialUpdateUserResponse["success"] = true;
          partialUpdateUserResponse["message"] = "user found";
          partialUpdateUserResponse["data"] = result['user'];
        }       
      }
      return partialUpdateUserResponse;
    } on ApiException catch (e) {
      print('Mutation failed: $e');
      return partialUpdateUserResponse;
    }
  }

  Future<Map<String, dynamic>> updateUserAccount(
      dynamic userInput) async {
    print("updateUserAccount");
    print("userInput: " + userInput.toString());

    Map<String, dynamic> updateUserAccountResponse = {
      "success": false,
      "message": "Default Error",
      "data": null
    };

    try {
      http.Response response = await http.post(
        Uri.parse(dotenv.env['APOLLO_SERVER'].toString()),
        headers: <String, String>{          
          'Content-Type': 'application/json'
        },
        body: jsonEncode(<String, String>{
          'query': UserMutations().updateUserAccount(userInput),
        }),
      );

      print("response from updateUserAccount.....: ");

      print(jsonDecode(response.body));
      print("response.statusCode: " + response.statusCode.toString());
      if (response.statusCode == 200) {        
       
        final result = jsonDecode(response.body)['data']['updateUserAccount'];
        updateUserAccountResponse["data"] = null;
        if (result['success']) {
          dynamic userResp = result['user'];
          updateUserAccountDetails(userResp);
          updateUserAccountResponse["success"] = true;
          updateUserAccountResponse["message"] = "user found";
          updateUserAccountResponse["data"] = result['user'];
        }
              
       
      }
      return updateUserAccountResponse;
    } on ApiException catch (e) {
      print('Mutation failed: $e');
      return updateUserAccountResponse;
    }
  }
  Future<Map<String, dynamic>> updateUserOnboarding(
      dynamic processedUserInput) async {
    print("updateUserOnboarding");
    print("processedUserInput: " + processedUserInput.toString());

    Map<String, dynamic> partialUpdateUserResponse = {
      "success": false,
      "message": "Default Error",
      "data": null
    };

    try {
      http.Response response = await http.post(
        Uri.parse(dotenv.env['APOLLO_SERVER'].toString()),
        headers: <String, String>{          
          'Content-Type': 'application/json'
        },
        body: jsonEncode(<String, String>{
          'query': UserMutations().updateUserOnboarding(processedUserInput),
        }),
      );

      print("response from updateUserOnboarding.....: ");

      print(jsonDecode(response.body));
      print("response.statusCode: " + response.statusCode.toString());
      if (response.statusCode != 200) {        
        partialUpdateUserResponse["success"] = false;
        partialUpdateUserResponse["message"] = "no user found";
      } else {
        
        final result = jsonDecode(response.body)['data']['updateUserOnboarding'];
        partialUpdateUserResponse["data"] = null;
        if (result['success']) {
          partialUpdateUserResponse["success"] = true;
          partialUpdateUserResponse["message"] = "user found";
          partialUpdateUserResponse["data"] = result['user'];
        }
        else{
          partialUpdateUserResponse["success"] = false;
          partialUpdateUserResponse["message"] = "no user found";
        }
      }
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
    List<dynamic> followings = currentUser['following'];
    return followings
        .any((relation) => relation['following']['_id'] == userObject['_id']);
  }

  bool isCurrentUserFollowedByUser(dynamic userObject) {
    print("isUserFollowedByUser");
    dynamic currentUser = appModel.currentUser;
    List<dynamic> followings = currentUser['followers'];
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
        Uri.parse(dotenv.env['APOLLO_SERVER'].toString()),
        headers: <String, String>{          
          'Content-Type': 'application/json'
        },
        body: jsonEncode(<String, String>{
          'query': UserQueries().getUserByEmail(userInput),
        }),
      );

      print("response: ");

      print(jsonDecode(response.body));
      print("response.statusCode: " + response.statusCode.toString());
      if (response.statusCode != 200) {        
        getUserResp["success"] = false;
        getUserResp["message"] = "no user found";
      } else {
        
        final result = jsonDecode(response.body)['data']['findUserByEmail'];
        getUserResp["data"] = null;
        if (result['code'] != 200) {
          getUserResp["success"] = true;
          getUserResp["message"] = "user found";
          getUserResp["data"] = result['user'];
        }
        else{
          getUserResp["success"] = false;
          getUserResp["message"] = "no user found";
        }
      }

      // }
    } catch (e, s) {
      print(s);
      print('Query failed: $e');
    }
    return getUserResp;
  }

  Future<Map<String, dynamic>> findUserById(dynamic user) async {
    print("findMyUserById()");
    Map<String, dynamic> getUserResp = {
      "success": false,
      "message": "no user found",
      "data": null
    };
    try {
      print("before send request: "+user.toString());
      http.Response response = await http.post(
        Uri.parse(dotenv.env['APOLLO_SERVER'].toString()),
        headers: <String, String>{          
          'Content-Type': 'application/json'
        },
        body: jsonEncode(<String, String>{
          'query': UserQueries().findUserByID(user, UserFragments().fullUser()),
        }),
      );

      print("response: ");

      print(jsonDecode(response.body));
      print("response.statusCode: " + response.statusCode.toString());
      if (response.statusCode != 200) {        
        getUserResp["success"] = false;
        getUserResp["message"] = "no user found";
      } else {
        
        final result = jsonDecode(response.body)['data']['findUserById'];
        getUserResp["data"] = null;
        if (result['code'] != 200) {
          getUserResp["success"] = true;
          getUserResp["message"] = "user found";
          getUserResp["data"] = result['user'];
        }
        else{
          getUserResp["success"] = false;
          getUserResp["message"] = "no user found";
        }
      }
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

  
}
