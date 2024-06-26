import '../../commands/user_command.dart';
import '../../commands/team_command.dart';
import '../../commands/location_command.dart';
import './location_seeder.dart';
import 'dart:math';


class TournamentSeeder {
  Map<String, dynamic> createTournamentRelationships(){
    Map<String, dynamic> createTournamentRelationshipsResp = {
      "success": false,
      "message": "Something went wrong with creating Tournament relationships",
      "data": null,
    };

    List<dynamic> tournamentSizeOptions = [4,8,16,32];
    

    return createTournamentRelationshipsResp;
  }
  
}
