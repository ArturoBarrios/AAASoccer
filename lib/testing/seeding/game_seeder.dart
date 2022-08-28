import '../../models/app_model.dart';
import '../../commands/user_command.dart';
import '../../commands/team_command.dart';
import '../../commands/location_command.dart';
import './location_seeder.dart';
import 'dart:math';
import 'package:faunadb_http/faunadb_http.dart';
import 'package:faunadb_http/query.dart';

class GameSeeder {
  //assumes that data contains List of games and players of FaunaResponse type
  Future<Map<String, dynamic>> createGameRelationships(
      Map<String, dynamic> data, FaunaResponse gameFaunaResponse) async {
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
    print("for loop!");
    for (int i = 0; i < numberOfPlayersPerPickupGame; i++) {
      Map<String, dynamic> playerMap = data['players'][i].asMap();
      String playerRef = playerMap['resource']['ref']['@ref']['id'];
      print("playerRef: ");
      print(playerRef);
      String gameRef =
          gameFaunaResponse.asMap()['resource']['ref']['@ref']['id'];

//     Update(
//   Ref(Collection('users'), '281080202238362125'),
//   Obj({
//     'data': {'isCool': true}
//   }),
// );

      final updateUser = Update(
        Ref(Collection('Game'), gameRef),
        Obj({
          'data': {
            'players': {'connect': [Ref(Collection("Player"), playerRef)]}
          }
        }),
      );

      final result = await AppModel().faunaClient.query(updateUser);
      print("result: ");
      print(result.toJson());
    }
    print("end of for loop");

    return createGameRelationshipsResp;
  }
}
