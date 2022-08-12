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
  Future<Map<String, dynamic>> createGameRelationships() async{
    Map<String, dynamic> createGameRelationshipsResp = {
      "success": false,
      "message": "Something went wrong with creating game relationships",
      "data": null,
    };

    //create relationship with games and players
    //get all games and seed each game with players


final readAllUsers = Map_(
  Paginate(Match(Index('all_Users'))),
  Lambda(
    'userRef',
    Let(
      {
        'userDoc': Get(Var('userRef')),
      },
      Obj(
        {
          'id': Select(['ref', 'id'], Var('userDoc')),
          'name': Select(['data', 'name'], Var('userDoc')),
        },
      ),
    ),
  ),
);

  final result = await AppModel().faunaClient.query(query);
    

    return createGameRelationshipsResp;

  }
}
