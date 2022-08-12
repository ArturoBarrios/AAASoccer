import '../../models/Location.dart';
import '../../models/GenderType.dart';
import '../../commands/user_command.dart';
import '../../commands/team_command.dart';
import '../../commands/location_command.dart';
import '../../models/User.dart';
import './location_seeder.dart';
import 'dart:math';
import 'package:faunadb_http/faunadb_http.dart';

class TrainingSeeder {
  Map<String, dynamic> createTrainingRelationships(){
    Map<String, dynamic> createTrainingRelationshipsResp = {
      "success": false,
      "message": "Something went wrong with creating Training relationships",
      "data": null,
    };

    

    return createTrainingRelationshipsResp;

  }
}
