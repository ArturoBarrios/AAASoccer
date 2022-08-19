import 'dart:ffi';
import 'dart:math';

import '../../commands/location_command.dart';
import '../../commands/event_command.dart';
import '../../commands/training_command.dart';
import '../../commands/tournament_command.dart';
import '../../commands/league_command.dart';
import '../../commands/game_command.dart';
import 'game_seeder.dart';
import '../../commands/geolocation_command.dart';
import '../../testing/seeding/location_seeder.dart';
import '../../testing/seeding/training_seeder.dart';
import '../../testing/seeding/tournament_seeder.dart';
import '../../testing/seeding/league_seeder.dart';

import '../../models/SurfaceType.dart';
import '../../models/FieldPlayerOccupancySize.dart';
import 'package:faunadb_http/faunadb_http.dart';

class EventSeeder {
  Future<Map<String, dynamic>> createEvents(
      Map<String, dynamic> data) async {
    Map<String, dynamic> createEventsResponse = {
      "success": false,
      "message": "Something went wrong with creating random user locations",
      "data": Map<String, dynamic>(),
    };
    
    //pickup games
    for(int i = 0; i<data['numberOfPickupGames']; i++){
      Map<String, dynamic> randomPickupData = getRandomPickupGameData();
      var rng = Random();
      Map<String, dynamic> locationResult = await createRandomLocation();      
      Map<String, dynamic> eventInput = {
        "name": "Pickup Game " + i.toString(),
        'isMainEvent': true,
        'location': locationResult,
      };
      Map<String, dynamic> createPickupGameResp = await GameCommand().createGame(randomPickupData, eventInput);      
      
      if(createPickupGameResp['success']){
        
        GameSeeder().createGameRelationships(data, createPickupGameResp['data']);
      }      
    }
    // //Training Sessions
    // for(int i = 0; i<data['numberOfTrainingSessions']; i++){
    //   Map<String, dynamic> randomTraniningData = getRandomTrainingData();      
    //   Map<String, dynamic> locationResult = await createRandomLocation();
    //   Map<String, dynamic> eventInput = {
    //     "name": "Training Session " + i.toString(),
    //     'isMainEvent': true,
    //     "location": locationResult,        
    //   };
    //   Map<String, dynamic> trainingInput = {
        
    //   };
    //   Map<String, dynamic> createTrainingResp = await TrainingCommand().createTraining(trainingInput, eventInput);
    //   if(createTrainingResp['success']){
    //     TrainingSeeder().createTrainingRelationships();
    //   }

    // }
    // //tournaments
     
    // for(int i = 0;i<data['numberOfTournaments'];i++){
    //   Map<String, dynamic> randomTournamentData = getRandomTournamentData();
    //     Map<String, dynamic> locationResult = await createRandomLocation();
    //   Map<String, dynamic> eventInput = {
    //     "name": "Tournament " + i.toString(),
    //     'isMainEvent': true,        
    //     "location": locationResult,
    //   };
    //   Map<String, dynamic> createTournamentResp = await TournamentCommand().createTournament(randomTournamentData, eventInput);
    //   if(createTournamentResp['success']){
    //     TournamentSeeder().createTournamentRelationships();
    //   }
    // }
    // //leagues
    // for(int i = 0;i<data['numberOfLeagues'];i++){
    //   Map<String, dynamic> randomLeagueData = getRandomLeagueData();
    //     Map<String, dynamic> locationResult = await createRandomLocation();
    //   Map<String, dynamic> eventInput = {
    //     "name": "League " + i.toString(),
    //     'isMainEvent': true,        
    //     "location": locationResult,
    //   };
    //   Map<String, dynamic> createLeagueResp = await LeagueCommand().createLeague(randomLeagueData, eventInput);
    //   if(randomLeagueData['hasTournament']){
    //     //add tournament to league here?
    //   }
    //   if(createLeagueResp['success']){
    //     //make sure to check if league has tournament
    //     //you should be able to keep adding tournaments 
    //     //even as the league is going on
    //     LeagueSeeder().createLeagueRelationships();
    //   }
    // }

    createEventsResponse["success"] = true;


    return createEventsResponse;
  }
  

  Future<Map<String, dynamic>> createRandomLocation() async{
    Map<String, dynamic> createLocationResp = await LocationSeeder().createRandomLocation();
      FaunaResponse locationFaunaResponse = createLocationResp["data"];
      Map<String, dynamic> locationResult = locationFaunaResponse.asMap();

      return locationResult;

  }

  Map<String, dynamic> getRandomPickupGameData() {
    Map<String, dynamic> randomPickupGameData = {};
    var rng = Random();
    int randomLocationNumber = rng.nextInt(100000000);
    

    randomPickupGameData["pickup"] =
        true;
    

    return randomPickupGameData;
  }

  Map<String, dynamic> getRandomTrainingData(){
    Map<String, dynamic> randomTrainingData = {};
    var rng = Random();
    int randomLocationNumber = rng.nextInt(100000000);
    

    randomTrainingData["name"] = "Training Session " + randomLocationNumber.toString();
    

    return randomTrainingData;
  }

  Map<String, dynamic> getRandomTournamentData(){
    Map<String, dynamic> randomTournamentData = {};
    List numberOfTeamsOptions = [2,4,8,16];
    var rng = Random();
    int randomLocationNumber = rng.nextInt(100000000);
    randomTournamentData['groupPlay'] = rng.nextBool();
    randomTournamentData['numberOfTeams'] = numberOfTeamsOptions[rng.nextInt(numberOfTeamsOptions.length)];
    // randomTournamentData['numberOfGroups'] = rng

    return randomTournamentData;
  }

  Map<String, dynamic> getRandomLeagueData(){
    Map<String, dynamic> randomLeagueData = {};
    var rng = Random();
    int randomLocationNumber = rng.nextInt(100000000);
    

    randomLeagueData["name"] = "League " + randomLocationNumber.toString();
    randomLeagueData["hasTournament"] = rng.nextBool();
    

    return randomLeagueData;
  }
}
