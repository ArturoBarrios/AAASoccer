import 'package:soccermadeeasy/commands/training_command.dart';

import '../../commands/user_command.dart';
import '../../commands/team_command.dart';
import '../../commands/location_command.dart';
import './location_seeder.dart';
import 'dart:math';


class TrainingSeeder {
  Future <Map<String, dynamic>> createTrainingRelationships(Map<String, dynamic> data, Map<String, dynamic> training) async {
    print("createTrainingRelationships");
    Map<String, dynamic> createTrainingRelationshipsResp = {
      "success": false,
      "message": "Something went wrong with creating Training relationships",
      "data": <Map<String, dynamic>>[],
    };

    List<dynamic> players = data['players'];

  //attach players to training
    for(int i = 0; i < players.length; i++){
      print("player: ");
      print(players[i]);    
      print("training: ");
      print(training);
      dynamic player = players[i];  
      Map<String, dynamic> createPlayerTrainingResp = await TrainingCommand().addTrainingToGame(training, player);
      if(createPlayerTrainingResp['success']){
        print("createPlayerTrainingResp: " + createPlayerTrainingResp.toString());
        createTrainingRelationshipsResp['data'].add(createPlayerTrainingResp['data']);
      }
    }




    

    return createTrainingRelationshipsResp;

  }
}
