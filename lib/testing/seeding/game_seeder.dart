import '../../models/Location.dart';
import '../../models/GenderType.dart';
import '../../commands/user_command.dart';
import '../../commands/team_command.dart';
import '../../commands/location_command.dart';
import '../../models/User.dart';
import './location_seeder.dart';
import 'dart:math';
import 'package:faunadb_http/faunadb_http.dart';

class GameSeeder {
  Map<String, dynamic> createGameRelationships(){
    Map<String, dynamic> createGameRelationshipsResp = {
      "success": false,
      "message": "Something went wrong with creating game relationships",
      "data": null,
    };

    //create relationship with games and players
    //get all games
    

    return createGameRelationshipsResp;

  }
}
