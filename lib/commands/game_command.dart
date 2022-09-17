import 'dart:convert';
import 'dart:ffi';
import 'base_command.dart';
import 'package:faunadb_http/faunadb_http.dart';
import 'package:faunadb_http/query.dart';
import '../models/app_model.dart';
import '../commands/event_command.dart';
import '../commands/geolocation_command.dart';
import 'package:geolocator/geolocator.dart';
import '../graphql/mutations/games.dart';
import 'package:http/http.dart' as http;

class GameCommand extends BaseCommand {


//read
Future<Map<String, dynamic>> getGamesNearLocation() async{
  Map<String, dynamic> gamesResp = {"success": false, "message": "Default Error", "data": []};
  try{
    print("getGamesNearLocation");
    print("my position");
    Position myPosition = await GeoLocationCommand().determinePosition();
final getGamesQuery = Map_(
  Paginate(Documents(Collection('Game'))),
  // and in this function, the magic will happen, for now we just return the tweet.
  Lambda('g',
    Let({
        'game': Get(Var('g')),
        'players': Get(Select(['data', 'players'], Var('game'))),
      },
      Obj({
        'game': Select(['data', 'id'], Var('game')),
        'players': {
          'name': Select(['data', 'id'], Var('players')), 
        }
        //  'game':  Var('game'),
        //   'player': Var('players'),
      })
    )
  )
);


    final result = null;//await AppModel().faunaClient.query(getGamesQuery);
    
    print("result: ");
    print(result.toJson());
    //get games
    print(myPosition);
  } on Exception catch (e) {
    print('Mutation failed: $e');
    return gamesResp;
  }

  return gamesResp;

}
//create
Future<Map<String, dynamic>> createGame(Map<String, dynamic> gameInput, Map<String, dynamic> eventInput, Map<String, dynamic> locationInput ) async{
     print("createGame");
     print(gameInput);
    Map<String, dynamic> createGameResponse = {"success": false, "message": "Default Error", "data": null};
    try {

      http.Response response = await http.post(
        Uri.parse('https://graphql.fauna.com/graphql'),
        headers: <String, String>{
          'Authorization': 'Bearer fnAEwU2qV_ACT5r5tpk0an5_qFS-M8vncFSUZPvL',
          'Content-Type': 'application/json'
        },
        body: jsonEncode(<String, String>{
          'query': GameMutations().createGame(gameInput, eventInput, locationInput),
        }),
      );

      print("response body: ");
      print(jsonDecode(response.body));
        
        createGameResponse["success"] = true;
        createGameResponse["message"] = "Game Created";
        createGameResponse["data"] = jsonDecode(response.body)['data']['createGame'];
        
      
      return createGameResponse;
    } on Exception catch (e) {
      print('Mutation failed: $e');
      return createGameResponse;
    }
  }

  Future<Map<String, dynamic>> addPlayerToGame(Map<String, dynamic> gameInput, Map<String, dynamic> playerInput ) async{
    print("addPlayerToGame");
    Map<String, dynamic> addPlayerToGameResponse = {"success": false, "message": "Default Error", "data": null};
    
    http.Response response = await http.post(
        Uri.parse('https://graphql.fauna.com/graphql'),
        headers: <String, String>{
          'Authorization': 'Bearer fnAEwU2qV_ACT5r5tpk0an5_qFS-M8vncFSUZPvL',
          'Content-Type': 'application/json'
        },
        body: jsonEncode(<String, String>{
          'query': GameMutations().addPlayerToGame(gameInput, playerInput),
        }),
      );

      print("response body: ");
      print(jsonDecode(response.body));
        
      addPlayerToGameResponse["success"] = true;
      addPlayerToGameResponse["message"] = "Game Created";
      addPlayerToGameResponse["data"] = jsonDecode(response.body)['data']['updateGame'];

    return addPlayerToGameResponse;
  }



  

 

}