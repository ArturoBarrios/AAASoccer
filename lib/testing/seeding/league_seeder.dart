import '../../commands/user_command.dart';
import '../../commands/team_command.dart';
import '../../commands/event_command.dart';
import '../../commands/game_command.dart';
import '../../commands/tournament_command.dart';
import '../../commands/location_command.dart';
import './location_seeder.dart';
import 'dart:math';

import '../../testing/seeding/location_seeder.dart';
import '../../testing/seeding/event_seeder.dart';

class LeagueSeeder {
  Future<Map<String, dynamic>> createLeagueRelationships() async{
    Map<String, dynamic> createLeagueRelationshipsResp = {
      "success": false,
      "message": "Something went wrong with creating game relationships",
      "data": null,
    };

    
      

    


    

    return createLeagueRelationshipsResp;

  }
}
