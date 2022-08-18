import '../../models/Location.dart';
import '../../models/GenderType.dart';
import '../../models/app_model.dart';
import '../../commands/user_command.dart';
import '../../commands/team_command.dart';
import '../../commands/location_command.dart';
import '../../models/User.dart';
import './location_seeder.dart';
import 'dart:math';
import 'package:faunadb_http/faunadb_http.dart';
import 'package:faunadb_http/query.dart';

class GameSeeder {
  //assumes that data contains List of games and players of FaunaResponse type
  Future<Map<String, dynamic>> createGameRelationships(FaunaResponse gameFaunaResponse,data) async{
    print("createGameRelationships");
    Map<String, dynamic> createGameRelationshipsResp = {
      "success": false,
      "message": "Something went wrong with creating game relationships",
      "data": null,
    };
    // Map<String, dynamic> gameMap = gameFaunaResponse.asMap();
    // final readUser = Get(Ref(Collection('Game'), gameMap['resource']['ref']['@ref']['id']));

    // final result = await AppModel().faunaClient.query(readUser);

    //create relationship with games and players
    int numberOfPlayersPerPickupGame = data['numberOfPlayersPerPickupGame'];
    for(int i = 0;i<numberOfPlayersPerPickupGame;i++){
      String userRef = "";
      final readUser = Get(Ref(Collection('users'), userRef));

        final result = await AppModel().faunaClient.query(readUser);


    }





    
  print("result: ");
  print(result.toJson());
    return createGameRelationshipsResp;

  }
}
