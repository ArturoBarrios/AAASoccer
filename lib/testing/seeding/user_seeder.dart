import '../../commands/user_command.dart';
import '../../commands/location_command.dart';
import '../../commands/player_command.dart';
import './location_seeder.dart';
import 'dart:math';
import 'package:faunadb_http/faunadb_http.dart';

class UserSeeder {
  Future<Map<String, dynamic>> createRandomPlayersForTeam(    
     Map<String, dynamic> data, Map<String, dynamic> team) async {
        print("createRandomUser");
    Map<String, dynamic> createRandomPlayerResponse = {
      "success": false,
      "message": "Something went wrong with creating random user locations",
      "data": [],
    };    
    
    for (int i = 0; i < data['numberOfPlayersPerTeam']; i++) {      
      Map<String, dynamic> getRandomUserDataResp = await getRandomUserData();
      Map<String, dynamic> getRandomPlayerDataResp = getRandomPlayerData();
      
      Map<String, dynamic> createLocationResp = await LocationSeeder().createRandomLocation();
      FaunaResponse locationFaunaResponse = createLocationResp["data"];
      Map<String, dynamic> locationResult = locationFaunaResponse.asMap();
      if(createLocationResp['success']){
        
        getRandomUserDataResp['location'] = locationResult;//createLocationResp["data"]["randomLocation"];          
        getRandomPlayerDataResp['team'] = team;
        Map<String, dynamic> createUserResponse = await PlayerCommand().createPlayer(getRandomUserDataResp, getRandomPlayerDataResp, true);

        if(createUserResponse["success"]){
          createRandomPlayerResponse["success"] = true;
          createRandomPlayerResponse["data"].add(createUserResponse["data"]);
          

      }
        
      
    }
    }

    

    return createRandomPlayerResponse;
  }


  Map<String, dynamic> getRandomUserData(){
    Map<String, dynamic> randomUserDataResponse = {
      "success": false,
      "message": "Something went wrong with creating random user data",
      "data": null,
    
    };
    var rng = Random();
    Map<String, dynamic> randomUserData = {
      "email": "randomEmail" + rng.nextInt(100000000).toString()+"@gmail.com",
      'name': 'Name' + rng.nextInt(100000000).toString(),
      "username": "randomUsername" + rng.nextInt(100000000).toString(),
      "phone": rng.nextInt(100000000).toString(),
      "birthdate": DateTime.now().subtract(Duration(days: rng.nextInt(1000000))),
      "gender": rng.nextInt(2) == 0 ? "GenderType.MALE" : "GenderType.FEMALE",
    };

    randomUserDataResponse['success'] = true;
    randomUserDataResponse['message'] = "random user generated";  
    randomUserDataResponse['data'] = randomUserData;   



    return randomUserDataResponse;

  }

  Map<String, dynamic> getRandomPlayerData(){
    Map<String, dynamic> randomPlayerDataResponse = {
      "success": false,
      "message": "Something went wrong with creating random user data",
      "data": null,
    
    };
    var rng = Random();
    Map<String, dynamic> randomPlayerData = {
      "email": "randomEmail" + rng.nextInt(100000000).toString()+"@gmail.com",
      'name': 'Name' + rng.nextInt(100000000).toString(),
      "username": "randomUsername" + rng.nextInt(100000000).toString(),
      "phone": rng.nextInt(100000000).toString(),
      "birthdate": DateTime.now().subtract(Duration(days: rng.nextInt(1000000))),
      "gender": rng.nextInt(2) == 0 ? "GenderType.MALE" : "GenderType.FEMALE",
    };

    randomPlayerDataResponse['success'] = true;
    randomPlayerDataResponse['message'] = "random user generated";  
    randomPlayerDataResponse['data'] = randomPlayerData;   



    return randomPlayerDataResponse;

  }
}
