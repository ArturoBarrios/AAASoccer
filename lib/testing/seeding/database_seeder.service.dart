// dart lib/testing/seeding/database_seeder.service.dart
/// This file is at lib/testing/seeding/seed_services.service.dart
import 'dart:convert';
import 'package:faunadb_http/faunadb_http.dart';

import 'location_seeder.dart';
import 'event_seeder.dart';
import 'user_seeder.dart';
import 'team_seeder.dart';

// import '../../models/Location.dart';

class DatabaseSeeder {
  Map<String, dynamic> data = {
  'numberOfTeams': 4,//4500,
  "numberOfUserLocations": 4,//4500,
  'numberOfUsers': 4,//4500,
  'randomLocations': [],
  'numberOfPickupGames': 4,//4500,
  'numberOfLeagues': 1,//4500,
  'numberOfTournaments': 1,//4500,
  'numberOfTryouts': 4,//4500,
  'numberOfTrainingSessions': 4,//4500,
  'numberOfPlayersPerTeam': 5,  //important
  'numberOfPlayersPerPickupGame': 2,  //important
 };

  Future run() async {
    print("run DatabaseSeeder");
    List<Map<String, dynamic>> players = [];
    List<Map<String, dynamic>> teams = [];
    //seed teams
    Map<String, dynamic> createTeamsResponse = await TeamSeeder().createRandomTeams(data);
    if(createTeamsResponse['success']){
      teams = createTeamsResponse['data'];
      print("create users for teams");
      //create x users for each team      
      for(int i = 0;i<teams.length;i++){
        Map<String, dynamic> team = teams[i];           
        print("yaiii");
        print(team);
        Map<String, dynamic> createPlayersPerTeamResponse = await UserSeeder().createRandomPlayersForTeam(data, team);
          print("testtttttttt: ");
          print(createPlayersPerTeamResponse);
        if(createPlayersPerTeamResponse['success']){
          players = createPlayersPerTeamResponse['data'];
        }
        
      }

    }    
    // data['players'] = players;
    // data['teams'] = teams;
    Map<String, dynamic> createEventsResp = await EventSeeder().createEvents(data);
    
    print("finished Seeding DatabaseSeeder");
    
    

  }
}
