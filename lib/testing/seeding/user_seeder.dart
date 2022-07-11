import '../../models/Location.dart';
import '../../models/GenderType.dart';
import '../../commands/user_command.dart';
import '../../models/User.dart';
import 'dart:math';

class UserSeeder {
  Future<Map<String, dynamic>> createRandomUsers(
      Map<String, dynamic> data) async {
    Map<String, dynamic> createUsersResponse = {
      "success": false,
      "message": "Something went wrong with creating random user locations",
      "data": null,
    };
    for (int i = 0; i < data['numberOfUserLocations']; i++) {
      Map<String, dynamic> getRandomUserDataResp = getRandomUserData();
      if(getRandomUserDataResp["success"]){
        Map<String, dynamic> randomUserData = getRandomUserDataResp["data"]["randomUserData"];
        randomUserData["locationID"] = randomUserData["data"]["randomLocation"];
        Map<String, dynamic> createUserResponse = await UserCommand().createUser(randomUserData);
        if(createUserResponse["success"]){
          
        }
        
      }
    }

    createUsersResponse["success"] = true;

    return createUsersResponse;
  }

  Map<String, dynamic> getRandomUserData(){
    Map<String, dynamic> randomUserDataResponse = {
      "success": false,
      "message": "Something went wrong with creating random user data",
      "data": Map<String, dynamic>(),
    
    };
    var rng = Random();
    Map<String, dynamic> randomUserData = {
      "email": "randomEmail" + rng.nextInt(1000000000).toString()+"@gmail.com",
      "username": "randomUsername" + rng.nextInt(1000000000).toString(),
      "phone": rng.nextInt(10000000000).toString(),
      "birthdate": DateTime.now().subtract(Duration(days: rng.nextInt(1000000))),
      "gender": rng.nextInt(2) == 0 ? GenderType.MALE : GenderType.FEMALE, 
      "address": "randomAddress" + rng.nextInt(1000000000).toString()
      

    };



    return randomUserDataResponse;

  }
}
