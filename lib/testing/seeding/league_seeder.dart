import '../../models/Location.dart';
import '../../models/GenderType.dart';
import '../../commands/user_command.dart';
import '../../commands/team_command.dart';
import '../../commands/location_command.dart';
import '../../models/User.dart';
import './location_seeder.dart';
import 'dart:math';
import 'package:faunadb_http/faunadb_http.dart';

class LeagueSeeder {
  Map<String, dynamic> createLeagueRelationships(){
    Map<String, dynamic> createLeagueRelationshipsResp = {
      "success": false,
      "message": "Something went wrong with creating game relationships",
      "data": null,
    };

    //create relationship with games and players
    //get all games
    

    return createLeagueRelationshipsResp;

  }
}
