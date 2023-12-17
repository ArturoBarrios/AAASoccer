import 'package:soccermadeeasy/commands/game_command.dart';

import '../../models/pageModels/app_model.dart';
import '../../commands/user_command.dart';
import '../../commands/team_command.dart';
import '../../commands/location_command.dart';
import './location_seeder.dart';
import 'dart:math';



class GameSeeder {
  //assumes that data contains List of games and players of FaunaResponse type
  Future<Map<String, dynamic>> createGameRelationships(
      Map<String, dynamic> data, Map<String, dynamic> game) async {
    print("createGameRelationships");
    Map<String, dynamic> createGameRelationshipsResp = {
      "success": false,
      "message": "Something went wrong with creating game relationships",
      "data": <Map<String, dynamic>>[],
    };
    print(data['players']);
    List<dynamic> players = data['players'];

    //attach players to game
    for(int i = 0; i < players.length; i++){
      print("player: ");
      print(players[i]);    
      print("game: ");
      print(game);
      dynamic player = players[i];  
      Map<String, dynamic> createPlayerGameResp = await GameCommand().addPlayerToGame(game, player);
      if(createPlayerGameResp['success']){
        print("createPlayerGameResp: " + createPlayerGameResp.toString());
        createGameRelationshipsResp['data'].add(createPlayerGameResp['data']);
      }
    }

    if(createGameRelationshipsResp['data'].length!=0){
      print("successfully attached players to game!");
      createGameRelationshipsResp['success'] = true;
      createGameRelationshipsResp['message'] = "Successfully created game relationships";
    }    
  

    return createGameRelationshipsResp;
  }
}
