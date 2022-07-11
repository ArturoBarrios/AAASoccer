import 'base_command.dart';
import 'package:amplify_api/amplify_api.dart';
import '../models/User.dart';
import 'package:amplify_flutter/amplify_flutter.dart';

class UserCommand extends BaseCommand {

  Future<List<String>> run(String user) async {
    // Make service call and inject results into the model
    List<String> posts = await userService.getPosts(user);

    // Return our posts to the caller in case they care
    return posts;
  }

   Future<Map<String, dynamic>> createUser(Map<String, dynamic> userInput ) async{
     print("createUser");
    Map<String, dynamic> createUserResponse = {"success": false, "message": "Default Error"};
    try {
      User user = User(email: userInput['email'], username: userInput['username'], phone: userInput['phone'], birthdate: userInput['birthdate'], gender: userInput['gender'], address: userInput['address']);

      final request = ModelMutations.create(user);
      print("request");
      final response = await Amplify.API.mutate(request: request).response;
      print("response");

      User? createdUser = response.data;
      if (createdUser == null) {
        print('errors: ' + response.errors.toString());
        return createUserResponse;
      }
      createUserResponse["success"] = true;
      createUserResponse["messasge"] = "Successfully Created User";
      createUserResponse["data"] = user;

      print('Mutation result: ' );
      print(createdUser);
      return createUserResponse;
    } on ApiException catch (e) {
      print('Mutation failed: $e');
      return createUserResponse;
    }
  }

  Future<Map<String, dynamic>> updateUserLogin(String email ) async{ 
    Map<String, dynamic> updateUserResponse = {"success": false, "message": "Default Error"};
    try{
      User oldUser = (await Amplify.DataStore.query(User.classType,
      where: User.EMAIL.eq(email)))[0];
      
      User newUser = oldUser.copyWith(last_login: new DateTime.now().millisecondsSinceEpoch);
      await Amplify.DataStore.save(newUser);
      updateUserResponse["success"] = true;
    } catch(e){

      
    }
    return updateUserResponse;
 }

  Future<Map<String, dynamic>> updateUserStatus(String email, String newUserStatus ) async{ 
    Map<String, dynamic> updateUserResponse = {"success": false, "message": "Default Error"};
      try{
        User oldUser = (await Amplify.DataStore.query(User.classType,
        where: User.EMAIL.eq(email)))[0];
        
        User newUser = oldUser.copyWith(status: newUserStatus);
        await Amplify.DataStore.save(newUser);
        updateUserResponse["success"] = true;
      } catch(e){

        
      }
    return updateUserResponse;
  }


  void setUserID(){
      // userModel.userID = userId;
    }

    Future<Map<String, dynamic>> getUser(String email) async{
    print("getUser");
    Map<String, dynamic> resp = {"success": false, "message": "no user found", "data": null};
    try {
      print("before query");
      final request = ModelQueries.list(User.classType, where: User.EMAIL.eq(email));
      final response = await Amplify.API.query(request: request).response;

      User? user = response.data?.items.first;
      print("user got: ");
      print(user);
      if(user!=null){
        resp["success"] = true;
        resp["message"] = "user found";
        resp["data"] = user;
      }
      
    }  catch (e) {
      print('Query failed: $e');
    }
    return resp;
  }

  Future<Map<String, dynamic>> deleteUser(String userId) async {
    print("delteUser");
    Map<String, dynamic> resp = {"success": false, "message": "user not deleted", "data": null};
    try{
      final request = ModelMutations.deleteById(User.classType, userId);
      final response = await Amplify.API.mutate(request: request).response;
      resp['success'] = true;
    }on ApiException catch(e){
      print("handle exception");
    }
    return resp;
  }

 

}