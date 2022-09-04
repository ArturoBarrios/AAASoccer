import 'base_command.dart';
import 'package:faunadb_http/faunadb_http.dart';
import 'package:faunadb_http/query.dart';
import '../models/app_model.dart';
import '../commands/event_command.dart';
import '../commands/geolocation_command.dart';
import 'package:geolocator/geolocator.dart';

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


// final getGamesQuery = Map_(
//   Paginate(Documents(Collection('Game'))),
//   // and in this function, the magic will happen
//   Lambda('g',
//     Let(
//       {
//         'game': Get(Var('g')),
//         'players': Get(Select(['data', 'players'], Var('game'))), // we get the author reference
//       },
//       // And now we return a nested doc    
      
//         Obj({
//           'game': Var('game'),
//           'players': Var('player')
           
//         })
        
      
      
//       // Expr in_{
//       //   Var('game'),
//       //   Var('player')
//       // }
//     )
//   )
// );
    // final getGamesQuery = Paginate(Documents(Collection("Game")));
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
Future<Map<String, dynamic>> createGame(Map<String, dynamic> gameInput, Map<String, dynamic> eventInput ) async{
     print("createGame");
    Map<String, dynamic> createGameResponse = {"success": false, "message": "Default Error", "data": null};
    try {
      Map<String, dynamic> createEventResp = await EventCommand().createEvent(eventInput);
      if(createEventResp["success"]){
        FaunaResponse eventFaunaResult = createEventResp["data"];
        Map<String, dynamic> eventResult = eventFaunaResult.asMap();
        print("event before creating Game: ");
        print(eventResult['resource']['ref']['@ref']['id']);
        
          final createDocument = Create(
            Collection('Game'),
            Obj({
              'data': {
                'pickup': gameInput['pickup'],           
                'event': Ref(Collection("Event"), eventResult['resource']['ref']['@ref']['id']),
                
                }
            }),
          ); 
          final result = null;//await AppModel().faunaClient.query(createDocument);
          print("response: ");
          print(result.toJson());
          createGameResponse["success"] = true;
          createGameResponse["message"] = "Game Created";
          createGameResponse["data"] = result;
        
      }
      return createGameResponse;
    } on Exception catch (e) {
      print('Mutation failed: $e');
      return createGameResponse;
    }
  }

  

 

}