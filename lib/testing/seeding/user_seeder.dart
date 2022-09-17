import '../../commands/user_command.dart';
import '../../commands/location_command.dart';
import '../../commands/player_command.dart';
import './location_seeder.dart';
import 'dart:math';
import 'package:faunadb_http/faunadb_http.dart';

class UserSeeder {
  Future<Map<String, dynamic>> createRandomPlayersForTeam(    
     Map<String, dynamic> data, Map<String, dynamic> team) async {
        print("createRandomPlayersForTeam");
    Map<String, dynamic> createRandomPlayersResponse = {
      "success": false,
      "message": "Something went wrong with creating random user locations",
      "data": <Map<String,dynamic>>[],
    };    
    
    for (int i = 0; i < data['numberOfPlayersPerTeam']; i++) {      
      Map<String, dynamic> getRandomUserDataResp = await getRandomUserData();
      Map<String, dynamic> getRandomPlayerDataResp = getRandomPlayerData();
      
      Map<String, dynamic> generateRandomLocation = await LocationSeeder().generateRandomLocation(LocationSeeder().locations[0]);
      Map<String, dynamic> locationInput = generateRandomLocation["data"]["randomLocation"];
      print("locationInputCheck: " + locationInput.toString());                                  
      Map<String, dynamic> createRandomPlayerResponse = await PlayerCommand().createPlayer(getRandomUserDataResp, getRandomPlayerDataResp, locationInput, true);

      print("createRandomPlayerResponse");
      print(createRandomPlayerResponse);

      if(createRandomPlayerResponse["success"]){           
        Map<String, dynamic> randomPlayer = createRandomPlayerResponse["data"];
        Map<String, dynamic> updatePlayerWithTeamResponse = await PlayerCommand().updatePlayerWithTeam(randomPlayer, team);
        if(updatePlayerWithTeamResponse["success"]){
          print("updatePlayerWithTeamResponse");
          print(updatePlayerWithTeamResponse['data']);
          Map<String, dynamic> playerWithTeam = updatePlayerWithTeamResponse['data'];
          createRandomPlayersResponse["data"].add(playerWithTeam);
        }        
      }                  
    }
    if(createRandomPlayersResponse["data"].length!=0){
      createRandomPlayersResponse["success"] = true;
      createRandomPlayersResponse["message"] = "Successfully created random players";
    }

    return createRandomPlayersResponse;
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
