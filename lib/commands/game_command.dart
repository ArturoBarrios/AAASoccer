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
          FaunaResponse result = await AppModel().faunaClient.query(createDocument);
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