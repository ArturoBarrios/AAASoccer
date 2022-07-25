import '../../models/Location.dart';
import '../../models/GenderType.dart';
import '../../commands/user_command.dart';
import '../../commands/location_command.dart';
import '../../models/User.dart';
import './location_seeder.dart';
import 'dart:math';
import 'package:faunadb_http/faunadb_http.dart';

class UserSeeder {
  Future<Map<String, dynamic>> createRandomUsers(
      Map<String, dynamic> data) async {
    Map<String, dynamic> createUsersResponse = {
      "success": false,
      "message": "Something went wrong with creating random user locations",
      "data": [],
    };    
    for (int i = 0; i < data['numberOfUsers']; i++) {
      Map<String, dynamic> getRandomUserDataResp = getRandomUserData();
      if(getRandomUserDataResp["success"]){
        Map<String, dynamic> phillyLocation = LocationSeeder().locations[0];
        Map<String, dynamic> randomLocationResp = await LocationSeeder().generateRandomLocation(phillyLocation);
        Map<String, dynamic> randomLocationData = randomLocationResp["data"]["randomLocation"];
        Map<String, dynamic>createLocationInput = LocationSeeder().getRandomLocationData();
        createLocationInput["latitude"] = randomLocationData["data"]["randomLocation"]["latitude"];
        createLocationInput["longitude"] = randomLocationData["data"]["randomLocation"]["longitude"];
        Map<String, dynamic> createLocationResp = await LocationCommand().createLocation(createLocationInput);
        FaunaResponse locationFaunaResponse = createLocationResp["data"];
        Map<String, dynamic> locationResult = locationFaunaResponse.asMap();
        if(createLocationResp['success']){
          Map<String, dynamic> randomUserData = getRandomUserDataResp["data"]["randomUserData"];  
          randomUserData['location'] = locationResult;//createLocationResp["data"]["randomLocation"];      
          Map<String, dynamic> createUserResponse = await UserCommand().createUser(randomUserData);
          if(createUserResponse["success"]){
            FaunaResponse createdUser = createUserResponse["data"];
            createUsersResponse["data"].add(createdUser);
            
          }
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
      'name': 'Name' + rng.nextInt(1000000000).toString(),
      "username": "randomUsername" + rng.nextInt(1000000000).toString(),
      "phone": rng.nextInt(10000000000).toString(),
      "birthdate": DateTime.now().subtract(Duration(days: rng.nextInt(1000000))),
      "gender": rng.nextInt(2) == 0 ? GenderType.MALE : GenderType.FEMALE,
    };



    return randomUserDataResponse;

  }
}
