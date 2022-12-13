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

class UserCommand extends BaseCommand {
  Future<List<String>> run(String user) async {
    // Make service call and inject results into the model
    List<String> posts = await userService.getPosts(user);

    // Return our posts to the caller in case they care
    return posts;
  }

  Future<Map<String, dynamic>> createUser(
      Map<String, dynamic> userInput) async {
    print("createUser");
    Map<String, dynamic> createUserResponse = {
      "success": false,
      "message": "Default Error",
      "data": null
    };
    try {
      print("location Input: ");
      print(userInput);
      final createDocument = Create(
        Collection('User'),
        Obj({
          'data': {
            'email': userInput['email'],
            'name': userInput['name'],
            'username': userInput['username'],
            'phone': userInput['phone'],
            'birthdate': userInput['birthdate'],
            'gender': "test", //should be userInput['gender'];
            'location': Ref(Collection("Location"),
                userInput['location']['resource']['ref']['@ref']['id']),
          }
        }),
      );

      final result = null; //await AppModel().faunaClient.query(createDocument);
      print("result: ");
      print(result.toJson());
      createUserResponse["success"] = true;
      createUserResponse["message"] = "User Created";
      createUserResponse["data"] = result;

      return createUserResponse;
    } on ApiException catch (e) {
      print('Mutation failed: $e');
      return createUserResponse;
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

  Future<Map<String, dynamic>> addEvent(Map<String, dynamic> userInput, Map<String, dynamic> eventInput) async {
    
    print("addEvent");
    Map<String, dynamic> addEventResponse = {
      "success": false,
      "message": "Default Error",
      "data": null
    };

    try{

      http.Response response = await http.post(
        Uri.parse('https://graphql.fauna.com/graphql'),
        headers: <String, String>{
          'Authorization': 'Bearer '+ dotenv.env['FAUNADBSECRET'].toString(),
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
      addEventResponse["data"] = jsonDecode(response.body)['data']['updateUser'];

    }catch(e){
      print("error");
    }


    return addEventResponse;

  }

  Future<Map<String, dynamic>> addTeam(Map<String, dynamic> userInput, Map<String, dynamic> teamInput) async {
    
    print("addTeam");
    Map<String, dynamic> addTeamResponse = {
      "success": false,
      "message": "Default Error",
      "data": null
    };

    try{

      http.Response response = await http.post(
        Uri.parse('https://graphql.fauna.com/graphql'),
        headers: <String, String>{
          'Authorization': 'Bearer '+ dotenv.env['FAUNADBSECRET'].toString(),
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

    }catch(e){
      print("error");
    }


    return addTeamResponse;

  }


  Future<Map<String, dynamic>> addFriend(Map<String, dynamic> userInput, Map<String, dynamic> friendInput) async {
    
    print("addFriend");
    Map<String, dynamic> addFriendResponse = {
      "success": false,
      "message": "Default Error",
      "data": null
    };

    try{

      http.Response response = await http.post(
        Uri.parse('https://graphql.fauna.com/graphql'),
        headers: <String, String>{
          'Authorization': 'Bearer '+ dotenv.env['FAUNADBSECRET'].toString(),
          'Content-Type': 'application/json'
        },
        body: jsonEncode(<String, String>{
          'query': UserMutations().addFriend(userInput, friendInput),
        }),
      );

      print("response body: ");
      print(jsonDecode(response.body));

      
      
      addFriendResponse["success"] = true;
      addFriendResponse["message"] = "Player for Team Created";      
      addFriendResponse["data"] = jsonDecode(response.body)['data']['updateUser'];

    }catch(e){
      print("error");
    }


    return addFriendResponse;

  }


  Future<Map<String, dynamic>> sendFriendRequest(Map<String, dynamic> receiverInput) async {
    print("sendFriendRequest");
    Map<String, dynamic> sendFriendRequestResponse = {
      "success": false,
      "message": "Default Error",
      "data": null
    };
    Map<String, dynamic> senderInput = {
      "_id": appModel.currentUser['_id'],
    };
    print("senderInput");
    print(senderInput);
    print("receiverInput");
    print(receiverInput);
    try {      
      http.Response response = await http.post(
        Uri.parse('https://graphql.fauna.com/graphql'),
        headers: <String, String>{
          'Authorization': 'Bearer '+ dotenv.env['FAUNADBSECRET'].toString(),
          'Content-Type': 'application/json'
        },
        body: jsonEncode(<String, String>{
          'query': UserMutations().sendFriendRequest(senderInput, receiverInput),
        }),
      );

      print("response body: ");
      print(jsonDecode(response.body));

      
      
      sendFriendRequestResponse["success"] = true;
      sendFriendRequestResponse["message"] = "Player for Team Created";      
      sendFriendRequestResponse["data"] = jsonDecode(response.body)['data']['CreateFriendRequest'];
    
      
    } catch (e) {}
    return sendFriendRequestResponse;
  }
  

  Future<Map<String, dynamic>> getCurrentUser() async {
    print("getCurrentUser");
    Map<String, dynamic> getUserResp = {
      "success": false,
      "message": "no user found",
      "data": null
    };
    try {
      String email = appModel.currentUser['email'];
      print("email: ");
      print(email);
      http.Response response = await http.post(
        Uri.parse('https://graphql.fauna.com/graphql'),
        headers: <String, String>{
          'Authorization': 'Bearer ' + dotenv.env['FAUNADBSECRET'].toString(),
          'Content-Type': 'application/json'
        },
        body: jsonEncode(<String, String>{
          'query': UserQueries().getUser(email),
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

  Future<Map<String, dynamic>> getUser(String email) async {
    print("getUser");
    Map<String, dynamic> getUserResp = {
      "success": false,
      "message": "no user found",
      "data": null
    };
    try {
      print("email: ");
      print(email);
      http.Response response = await http.post(
        Uri.parse('https://graphql.fauna.com/graphql'),
        headers: <String, String>{
          'Authorization': 'Bearer ' + dotenv.env['FAUNADBSECRET'].toString(),
          'Content-Type': 'application/json'
        },
        body: jsonEncode(<String, String>{
          'query': UserQueries().getUser(email),
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
