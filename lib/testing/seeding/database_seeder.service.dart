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
  'numberOfTeams': 2,//4500,
  "numberOfUserLocations": 4,//4500,
  'numberOfUsers': 4,//4500,
  'randomLocations': [],
  'numberOfPickupGames': 4,//4500,
  'numberOfLeagues': 4,//4500,
  'numberOfTournaments': 4,//4500,
  'numberOfTryouts': 4,//4500,
  'numberOfTrainingSessions': 4,//4500,
  'numberOfPlayersPerTeam': 13,  //important
  'numberOfPlayersPerPickupGame': 13,  //important
 };

  Future run() async {
    print("run DatabaseSeeder");
    List players = [];
    List teams = [];
    //seed teams
    Map<String, dynamic> createTeamsResponse = await TeamSeeder().createRandomTeams(data);
    if(createTeamsResponse['success']){
      teams = createTeamsResponse['data'];
      print("create users for teams");
      //create x users for each team      
      for(int i = 0;i<teams.length;i++){
        FaunaResponse team = teams[i];                
        Map<String, dynamic> createPlayersPerTeamResponse = await UserSeeder().createRandomPlayersForTeam(data, team.asMap());
        if(createPlayersPerTeamResponse['success']){
          players = createPlayersPerTeamResponse['data'];
        }
        
      }

    }    
    data['players'] = players;
    data['teams'] = teams;
    Map<String, dynamic> createEventsResp = await EventSeeder().createEvents(data);
    
    print("finished Seeding DatabaseSeeder");
    
    

  }
}
