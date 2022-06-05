import 'package:flutter/material.dart';
import '/models/app_model.dart';
import '/models/user_model.dart';
import '/services/user_service.dart';
import 'package:provider/provider.dart';
import 'package:amplify_api/amplify_api.dart';
import '../models/User.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_datastore/amplify_datastore.dart';
import '../commands/user_command.dart';


late BuildContext _mainContext;
// The commands will use this to access the Provided models and services.
void init(BuildContext c) => _mainContext = c;

// Provide quick lookup methods for all the top-level models and services. Keeps the Command code slightly cleaner.
class BaseCommand {
  // Models
  UserModel userModel = _mainContext.read();
  AppModel appModel = _mainContext.read();
  // Services
  UserService userService = _mainContext.read();

  Future <Map<String, dynamic>> setupInitialAppModels(String email) async{
    print("setupInitialAppModels");
    Map<String, dynamic> resp = {"success": 0, "message": "setup unsuccessfull", "data": null};
    try{
      
      Map<String, dynamic> getUserResp = await UserCommand().getUser(email);
      if(getUserResp["success"]){
        User user = getUserResp["data"];
        setUserId(user.id);
        setUser(user);
        userModel.userSetup.value = true;
        resp = {"success": 1, "message": "success", "data": null};
      }
      
    }catch(e){
      print("error");
      userModel.userSetup.value = false;
    }
    

    return resp;
  
  }
  

  setUserId(String userId){
    userModel.userID = userId;
}

  setUser(User user){
    userModel.user = user;
  }

  

  

  
}
