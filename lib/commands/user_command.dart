import 'dart:convert';
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:faunadb_http/faunadb_http.dart';
import 'base_command.dart';
import 'package:faunadb_http/query.dart';
import '../models/app_model.dart';
import '../models/User.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import '../graphql/queries/users.dart';
import '../graphql/mutations/users.dart';
import '../graphql/mutations/teams.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../commands/notifications_command.dart';

class UserCommand extends BaseCommand {
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
          'Authorization': 'Bearer ' + dotenv.env['FAUNADBSECRET'].toString(),
          'Content-Type': 'application/json'
        },
        body: jsonEncode(<String, String>{
          'query': UserMutations()
              .updateUser(userInput),
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
  
  Future<Map<String, dynamic>> createUserCustomer(
      Map<String, dynamic> userInput,
      Map<String, dynamic> stripeCustomerInput
      ) async {
    print("createUserCustomer");
    print("userInput: "+userInput.toString());
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

  Future<Map<String, dynamic>> updateUserLogin(String email) async {
    Map<String, dynamic> updateUserResponse = {
      "success": false,
      "message": "Default Error"
    };
    try {
      User oldUser = (await Amplify.DataStore.query(User.classType,
          where: User.EMAIL.eq(email)))[0];

      User newUser = oldUser.copyWith(
          last_login: new DateTime.now().millisecondsSinceEpoch);
      await Amplify.DataStore.save(newUser);
      updateUserResponse["success"] = true;
    } catch (e) {}
    return updateUserResponse;
  }

  Future<Map<String, dynamic>> updateUserStatus(
      String email, String newUserStatus) async {
    Map<String, dynamic> updateUserResponse = {
      "success": false,
      "message": "Default Error"
    };
    try {
      User oldUser = (await Amplify.DataStore.query(User.classType,
          where: User.EMAIL.eq(email)))[0];

      User newUser = oldUser.copyWith(status: newUserStatus);
      await Amplify.DataStore.save(newUser);
      updateUserResponse["success"] = true;
    } catch (e) {}
    return updateUserResponse;
  }

  void setUserID() {
    // userModel.userID = userId;
  }

  Future<Map<String, dynamic>> sendFriendRequest(dynamic friendInput  ) async{
    print("sendFriendRequest");
    Map<String, dynamic> sendFriendRequestResponse = {"success": false, "message": "Default Error", "data": null};
    try {    
      print("request for friend: "+ friendInput.toString());

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
          'Authorization': 'Bearer '+ dotenv.env['FAUNADBSECRET'].toString(),
          'Content-Type': 'application/json'
        },
        body: jsonEncode(<String, String>{
          'query': UserMutations().sendFriendRequest(sendFriendRequestInput),
        }),
      );

      print("responseee body: ");
      print(jsonDecode(response.body));

      //send friend request notifications
      Map<String, dynamic> sendOrganizerRequestNotificationInput = {
        "phones": phones,
        "message": appModel.currentUser['name'] + " has sent you a friend request!",
        "OSPIDs": OSPIDs
      };
      await NotificationsCommand().sendOrganizerRequestNotification(sendOrganizerRequestNotificationInput);
    
            
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

  Future<Map<String, dynamic>> addTeam(
      Map<String, dynamic> userInput, Map<String, dynamic> teamInput) async {
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
          'query': UserMutations().addTeam(userInput, teamInput),
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

  

  Future<Map<String, dynamic>> addFriend(
      Map<String, dynamic> userInput, Map<String, dynamic> friendInput) async {
    print("addFriend");
    Map<String, dynamic> addFriendResponse = {
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
          'query': UserMutations().addFriend(userInput, friendInput),
        }),
      );

      print("response body: ");
      print(jsonDecode(response.body));

      print("update currentUser friends");
      print("currentUser: " + appModel.currentUser.toString());

            

      addFriendResponse["success"] = true;
      addFriendResponse["message"] = "Player for Team Created";
      addFriendResponse["data"] =
          jsonDecode(response.body)['data']['createUserLink'];
    } catch (e) {
      print("error");
    }

    return addFriendResponse;
  }

  Future<Map<String, dynamic>> removeFriend(dynamic friendInput) async {
    print("removeFriend");
    Map<String, dynamic> removeFriendResp = {
      "success": false,
      "message": "friend not removed",
      "data": null
    };

    try {
      print("removeFriend in try");
      print("friendInput: "+ friendInput.toString());
      Map<String, dynamic> userInput = {
        "_id": appModel.currentUser['_id']
      };
     

      http.Response response = await http.post(
      Uri.parse('https://graphql.fauna.com/graphql'),
      headers: <String, String>{
        'Authorization': 'Bearer ' + dotenv.env['FAUNADBSECRET'].toString(),
        'Content-Type': 'application/json'
      },
      body: jsonEncode(<String, String>{
        'query': UserMutations().removeFriend(userInput, friendInput),
      }),
    );

    //find the friend in the currentUser friends list
    dynamic friends = appModel.currentUser['friends']['data'];
    print("friends: " + friends.toString());
    for(int i = 0; i < friends.length; i++){
      print("friends[i]['user']: " + friends[i]['user'].toString());      
      if(friends[i]['user'] == friendInput['user']['_id']){
        print("found friend");
        friends.removeAt(i);
        break;
      }
    }

    print("response body: ");
    print(jsonDecode(response.body));


    } catch (e) {
      print("error");
    }

    return removeFriendResp;
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
      Map<String, dynamic> userInput = {
        "email": email
      };
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
      final result = jsonDecode(response.body)['data']['getUser'];
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

  Future<Map<String, dynamic>> getUserByEmail(Map<String, dynamic> userInput) async {
    print("getUserByEmail()");
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
      final result = jsonDecode(response.body)['data']['getUser'];
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

  void updateFriendsPageModel(List<dynamic> friends) {
    friendsPageModel.selectedObjects = friends;
  }

  Future<Map<String, dynamic>> findUserById(Map<String, dynamic> userInput) async {
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
          'query': UserQueries().findUserByID(userInput),
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

  Future<Map<String, dynamic>> deleteUser(String userId) async {
    print("delteUser");
    Map<String, dynamic> resp = {
      "success": false,
      "message": "user not deleted",
      "data": null
    };
    try {
      final request = ModelMutations.deleteById(User.classType, userId);
      final response = await Amplify.API.mutate(request: request).response;
      resp['success'] = true;
    } on ApiException catch (e) {
      print("handle exception");
    }
    return resp;
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
