import 'dart:ffi';
import 'dart:math';

import '../../commands/location_command.dart';
import '../../commands/event_command.dart';
import '../../commands/training_command.dart';
import '../../commands/tryout_command.dart';
import '../../commands/tournament_command.dart';
import '../../commands/league_command.dart';
import '../../commands/game_command.dart';
import 'game_seeder.dart';
import '../../commands/geolocation_command.dart';
import '../../testing/seeding/location_seeder.dart';
import '../../testing/seeding/training_seeder.dart';
import '../../testing/seeding/tournament_seeder.dart';
import '../../testing/seeding/league_seeder.dart';
import 'package:faunadb_http/faunadb_http.dart';

class EventSeeder {
  Future<Map<String, dynamic>> createEvents(
      Map<String, dynamic> data) async {
        print("createEvents");
    Map<String, dynamic> createEventsResponse = {
      "success": false,
      "message": "Something went wrong with creating random user locations",
      "data": Map<String, dynamic>(),
    };
    
    //pickup games
    // for(int i = 0; i<data['numberOfPickupGames']; i++){
    //   Map<String, dynamic> randomPickupData = getRandomPickupGameData();
    //   var rng = Random();
    //   Map<String, dynamic> generateRandomLocation = await LocationSeeder().generateRandomLocation(LocationSeeder().locations[0]);
    //   Map<String, dynamic> locationInput = generateRandomLocation["data"]["randomLocation"];
    //   print("locationInputCheck: " + locationInput.toString());                                  
    //   Map<String, dynamic> eventInput = {
    //     "name": "Pickup Game " + i.toString(),
    //     'isMainEvent': true,        
    //   };
    //   Map<String, dynamic> createPickupGameResp = await GameCommand().createGame(randomPickupData, eventInput, locationInput);      
      
    //   if(createPickupGameResp['success']){
    //     Map<String, dynamic> pickupGame = createPickupGameResp['data'];
    //     Map<String, dynamic> event = pickupGame['event'];        
    //     await EventSeeder().createEventRelationships(data, event);
    //   }    
    // }  
    
    // Training Sessions
    // for(int i = 0; i<data['numberOfTrainingSessions']; i++){
    //   Map<String, dynamic> randomTraniningData = getRandomTrainingData();      
    //   Map<String, dynamic> generateRandomLocation = await LocationSeeder().generateRandomLocation(LocationSeeder().locations[0]);
    //   Map<String, dynamic> locationInput = generateRandomLocation["data"]["randomLocation"];
    //   Map<String, dynamic> eventInput = {
    //     "name": "Training Session " + i.toString(),
    //     'isMainEvent': true,        
    //   };
    //   Map<String, dynamic> trainingInput = {
        
    //   };
    //   Map<String, dynamic> createTrainingResp = await TrainingCommand().createTraining(trainingInput, eventInput, locationInput);
    //   if(createTrainingResp['success']){
    //     Map<String, dynamic> training = createTrainingResp['data'];
    //     Map<String, dynamic> event = training['event'];
    //     await EventSeeder().createEventRelationships(data, event);
    //   }

    //Tryouts
    // for(int i = 0; i<data['numberOfTryouts']; i++){
    //   Map<String, dynamic> randomTryoutData = getRandomTryoutData();      
    //   Map<String, dynamic> generateRandomLocation = await LocationSeeder().generateRandomLocation(LocationSeeder().locations[0]);
    //   Map<String, dynamic> locationInput = generateRandomLocation["data"]["randomLocation"];
    //   Map<String, dynamic> eventInput = {
    //     "name": "Tryout Session " + i.toString(),
    //     'isMainEvent': true,        
    //   };
    //   Map<String, dynamic> tryoutInput = {
        
    //   };
    //   Map<String, dynamic> createTryoutResp = await TryoutCommand().createTryout(tryoutInput, eventInput, locationInput);
    //   if(createTryoutResp['success']){
    //     Map<String, dynamic> tryout = createTryoutResp['data'];
    //     Map<String, dynamic> event = tryout['event'];
    //     await EventSeeder().createEventRelationships(data, event);
    //   }

    // }


    //tournaments
     
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
    //leagues
    // for(int i = 0;i<data['numberOfLeagues'];i++){
    //   Map<String, dynamic> leagueInput = getRandomLeagueData();
    //   Map<String, dynamic> generateRandomLocation = await LocationSeeder().generateRandomLocation(LocationSeeder().locations[0]);
    //   Map<String, dynamic> locationInput = generateRandomLocation["data"]["randomLocation"];
    //   Map<String, dynamic> eventInput = {
    //     "name": "League " + i.toString(),
    //     'isMainEvent': true,                
    //   };      
    //   Map<String, dynamic> createLeagueResp = await LeagueCommand().createLeague(leagueInput, eventInput, locationInput);
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
  

   //assumes that data contains List of games and players of FaunaResponse type
  Future<Map<String, dynamic>> createEventRelationships(
      Map<String, dynamic> data, Map<String, dynamic> event) async {
    print("createEventRelationships");
    Map<String, dynamic> createEventRelationshipsResp = {
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
      print("event: ");
      print(event);
      dynamic player = players[i];  
      Map<String, dynamic> createPlayerEventResp = await EventCommand().addPlayerToEvent(event, player);
      if(createPlayerEventResp['success']){
        print("createPlayerGameResp: " + createPlayerEventResp.toString());
        createEventRelationshipsResp['data'].add(createPlayerEventResp['data']);
      }
    }

    if(createEventRelationshipsResp['data'].length!=0){
      print("successfully attached players to game!");
      createEventRelationshipsResp['success'] = true;
      createEventRelationshipsResp['message'] = "Successfully created game relationships";
    }    
  

    return createEventRelationshipsResp;
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

  Map<String, dynamic> getRandomNonPickupGameData() {
    Map<String, dynamic> randomPickupGameData = {};
    var rng = Random();
    int randomLocationNumber = rng.nextInt(100000000);
    

    randomPickupGameData["pickup"] =
        false;
    

    return randomPickupGameData;
  }

  Map<String, dynamic> getRandomTrainingData(){
    Map<String, dynamic> randomTrainingData = {};
    var rng = Random();
    int randomLocationNumber = rng.nextInt(100000000);
    

    randomTrainingData["name"] = "Training Session " + randomLocationNumber.toString();
    

    return randomTrainingData;
  }

  Map<String, dynamic> getRandomTryoutData(){
    Map<String, dynamic> randomTryoutData = {};
    var rng = Random();
    int randomLocationNumber = rng.nextInt(100000000);
    

    randomTryoutData["name"] = "Tryout Session " + randomLocationNumber.toString();
    

    return randomTryoutData;
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
    

    return randomLeagueData;
  }
  }

