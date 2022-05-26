import 'base_command.dart';
import 'package:amplify_api/amplify_api.dart';
import '../models/User.dart';
import 'package:amplify_flutter/amplify_flutter.dart';

class UserCommand extends BaseCommand {

  Future<List<String>> run(String user) async {
    // Make service call and inject results into the model
    List<String> posts = await userService.getPosts(user);
    userModel.userPosts = posts;

    // Return our posts to the caller in case they care
    return posts;
  }

   Future<Map<String, dynamic>> createUser(Map<String, dynamic> userInput ) async{
     print("createUser");
    Map<String, dynamic> createUserResponse = {"success": 0, "message": "Default Error"};
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
      createUserResponse["success"] = 1;
      createUserResponse["messasge"] = "Successfully Created User";
      print('Mutation result: ' );
      print(createdUser);
      return createUserResponse;
    } on ApiException catch (e) {
      print('Mutation failed: $e');
      return createUserResponse;
    }
  }
  
}