import '../../models/Location.dart';
import '../../models/GenderType.dart';
import '../../commands/user_command.dart';
import '../../commands/team_command.dart';
import '../../commands/location_command.dart';
import '../../models/User.dart';
import './location_seeder.dart';
import 'dart:math';
import 'package:faunadb_http/faunadb_http.dart';

class TournamentSeeder {
  Map<String, dynamic> createTournamentRelationships(){
    Map<String, dynamic> createTournamentRelationshipsResp = {
      "success": false,
      "message": "Something went wrong with creating Tournament relationships",
      "data": null,
    };

    return createTournamentRelationshipsResp;
  }
}
