import 'package:flutter/foundation.dart';
import 'package:amplify_api/amplify_api.dart';
import './User.dart';

class UserModel extends ChangeNotifier {
  List<String> _userPosts = [];

  List<String> get userPosts => _userPosts;

  set userPosts(List<String> userPosts) {
    _userPosts = userPosts;
    notifyListeners();
  }

  //   var map = {
  //   "myPropertyName":50,
  //   "myArrayProperty":[
  //     "anArrayEntry"
  //   ],
  //   "mySubobject": {
  //     "subObjectProperty":"someValue"
  //   }
  // };

  String createUser(String email, String username, String phoneController){
    try {
      User todo = User(email: 'my first todo',: 'todo description');
      final request = ModelMutations.create(User);
      final response = await Amplify.API.mutate(request: request).response;

      User? createdTodo = response.data;
      if (createdTodo == null) {
        print('errors: ' + response.errors.toString());
        return "fuck";
      }
      print('Mutation result: ' + createdTodo.name);
    } on ApiException catch (e) {
      print('Mutation failed: $e');
      return "fuck";
    }

    return "";
  }


}
