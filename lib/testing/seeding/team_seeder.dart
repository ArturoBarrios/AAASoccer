import '../../commands/user_command.dart';
import '../../commands/team_command.dart';
import '../../commands/location_command.dart';
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
      "data": <Map<String,dynamic>>[],
    };    
    for (int i = 0; i < data['numberOfTeams']; i++) {      
      Map<String, dynamic> getRandomTeamDataResp = getRandomTeamData();
      if(getRandomTeamDataResp["success"]){
        print("success");
        Map<String, dynamic> generateRandomLocation = await LocationSeeder().generateRandomLocation(LocationSeeder().locations[0]);
        Map<String, dynamic> locationInput = generateRandomLocation["data"]["randomLocation"];
        print("locationInputCheck: " + locationInput.toString());
        // Map<String,dynamic> location = createLocationResp['data'];
        // print("data after method call");
        // print(location);        
        // if(createLocationResp['success']){
        Map<String, dynamic> randomTeamData = getRandomTeamDataResp["data"];  
        //should return something like: {_id: 342647957360738896, name: Random Location97334003, latitude: -75.12578095675477, longitude: 39.688642504605156}
        // randomTeamData['location'] = location;//createLocationResp["data"]["randomLocation"];      
        Map<String, dynamic> createTeamResponse = await TeamCommand().createTeam(randomTeamData, locationInput);
        if(createTeamResponse['success']){            
          Map<String, dynamic> createdTeam = createTeamResponse["data"];
          print("createdTeam: ");
          print(createdTeam);
          createTeamsResponse["data"].add(createdTeam);
          
        }        
      }
    }
    print("random teams created");
    if(createTeamsResponse["data"].length==data['numberOfTeams']){
      createTeamsResponse["success"] = true;
      createTeamsResponse["message"] = "Successfully created random teams";
    }    

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
