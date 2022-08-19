import '../../models/Location.dart';
import '../../models/GenderType.dart';
import '../../commands/user_command.dart';
import '../../commands/team_command.dart';
import '../../commands/location_command.dart';
import '../../models/User.dart';
import './location_seeder.dart';
import 'dart:math';
import 'package:faunadb_http/faunadb_http.dart';

class TeamSeeder {
  Future<Map<String, dynamic>> createRandomTeams(    
      Map<String, dynamic> data) async {
        print("createRandomTeams");
    Map<String, dynamic> createTeamsResponse = {
      "success": false,
      "message": "Something went wrong with creating random user locations",
      "data": [],
    };    
    for (int i = 0; i < data['numberOfTeams']; i++) {      
      Map<String, dynamic> getRandomTeamDataResp = getRandomTeamData();
      if(getRandomTeamDataResp["success"]){
        print("success");
        Map<String, dynamic> createLocationResp = await LocationSeeder().createRandomLocation();
        FaunaResponse locationFaunaResponse = createLocationResp["data"];
        Map<String, dynamic> locationResult = locationFaunaResponse.asMap();
        if(createLocationResp['success']){
          Map<String, dynamic> randomTeamData = getRandomTeamDataResp["data"];  
          randomTeamData['location'] = locationResult;//createLocationResp["data"]["randomLocation"];      
          Map<String, dynamic> createTeamResponse = await TeamCommand().createTeam(randomTeamData);
          if(createTeamResponse["success"]){
            FaunaResponse createdTeam = createTeamResponse["data"];
            createTeamsResponse["data"].add(createdTeam);
            
          }
        }
        
      }
    }
    print("random teams created");
    createTeamsResponse["success"] = true;

    return createTeamsResponse;
  }


  Map<String, dynamic> getRandomTeamData(){
    Map<String, dynamic> randomUserDataResponse = {
      "success": false,
      "message": "Something went wrong with creating random user data",
      "data": null,
    
    };
    //create a List of colors
    List<String> colors = [
      "red",
      "blue",
      "green",
      "yellow",
      "orange",
      "purple",
      "pink",
      "brown",
      "black",
      "white",
    ];

    var rng = Random();
    Map<String, dynamic> randomTeamData = {      
      'name': 'Team Name' + rng.nextInt(100000000).toString(),      
      'color': colors[rng.nextInt(colors.length)]      
    };

    randomUserDataResponse['success'] = true;
    randomUserDataResponse['message'] = "random team generated";  
    randomUserDataResponse['data'] = randomTeamData;   



    return randomUserDataResponse;

  }
}