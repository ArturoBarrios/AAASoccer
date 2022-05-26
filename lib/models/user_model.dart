import 'package:flutter/foundation.dart';
import 'package:amplify_api/amplify_api.dart';
import './User.dart';
import 'package:amplify_flutter/amplify_flutter.dart';

class UserModel extends ChangeNotifier {
  List<String> _userPosts = [];

  List<String> get userPosts => _userPosts;

  set userPosts(List<String> userPosts) {
    _userPosts = userPosts;
    notifyListeners();
  }

  Future<Map<String, dynamic>> createUser(String email, String username, String phone, String birthdate, String gender, String address ) async{
    Map<String, dynamic> createUserResponse = {"success": 0, "message": "Default Error"};
    try {
      User user = User(email: email, username: username, phone: phone, birthdate: birthdate, gender: gender, address: address);
      final request = ModelMutations.create(user);
      final response = await Amplify.API.mutate(request: request).response;

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
