import 'package:soccermadeeasy/models/events_model.dart';

import 'base_command.dart';
import 'package:amplify_api/amplify_api.dart';
import '../models/Event.dart';
import '../models/app_model.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:faunadb_http/faunadb_http.dart';
import 'package:faunadb_http/query.dart';
import '../models/app_model.dart';
import '../commands/game_command.dart';
import '../commands/player_command.dart';
import '../commands/team_command.dart';
import '../commands/training_command.dart';
import '../commands/tryout_command.dart';
import '../commands/tournament_command.dart';
import '../commands/league_command.dart';
import 'package:http/http.dart' as http;
import '../graphql/mutations/events.dart';
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import './game_command.dart';

class EventCommand extends BaseCommand {

  

 Future<Map<String, dynamic>> createEvent(Map<String, dynamic> eventInput ) async{
     print("createEvent");
    Map<String, dynamic> createEventResponse = {"success": false, "message": "Default Error", "data": null};
    try {
      

      return createEventResponse;
    } on ApiException catch (e) {
      print('Mutation failed: $e');
      return createEventResponse;
    }
  }

  Future<Map<String, dynamic>> sendEventRequest(Map<String, dynamic> fromInput, Map<String, dynamic> toInput, Map<String, dynamic> eventInput  ) async{
    print("sendEventRequest");
    Map<String, dynamic> sendEventRequestResponse = {"success": false, "message": "Default Error", "data": null};
    try {      
      http.Response response = await http.post(
        Uri.parse('https://graphql.fauna.com/graphql'),
        headers: <String, String>{
          'Authorization': 'Bearer '+ dotenv.env['FAUNADBSECRET'].toString(),
          'Content-Type': 'application/json'
        },
        body: jsonEncode(<String, String>{
          'query': EventMutations().sendEventRequest(fromInput, toInput, eventInput),
        }),
      );

      print("response body: ");
      print(jsonDecode(response.body));

      
      
      sendEventRequestResponse["success"] = true;
      sendEventRequestResponse["message"] = "Player for Team Created";      
      sendEventRequestResponse["data"] = jsonDecode(response.body)['data']['CreateEventRequest'];
    
      
    } catch (e) {}

    return sendEventRequestResponse;
  }

  

   Future<Map<String, dynamic>> addPlayerToEvent(Map<String, dynamic> eventInput, Map<String, dynamic> playerInput ) async{
    print("addPlayerToEvent");
    Map<String, dynamic> addPlayerToEventResponse = {"success": false, "message": "Default Error", "data": null};
    
    http.Response response = await http.post(
        Uri.parse('https://graphql.fauna.com/graphql'),
        headers: <String, String>{
          'Authorization': 'Bearer '+ dotenv.env['FAUNADBSECRET'].toString(),
          'Content-Type': 'application/json'
        },
        body: jsonEncode(<String, String>{
          'query': EventMutations().addPlayerToEvent(eventInput, playerInput),
        }),
      );

      print("response body: ");
      print(jsonDecode(response.body));
        
      addPlayerToEventResponse["success"] = true;
      addPlayerToEventResponse["message"] = "Game Created";
      addPlayerToEventResponse["data"] = jsonDecode(response.body)['data']['updateEvent'];

    return addPlayerToEventResponse;
  }

  Future<Map<String, dynamic>> getEvents() async{
    Map<String,dynamic> getEventsResp = {"success": false, "message": "Default Error", "data": []};
    try{
      // http.Response response = await http.post(
      //   Uri.parse('https://graphql.fauna.com/graphql'),
      //   headers: <String, String>{
      //     'Authorization': 'Bearer '+ dotenv.env['FAUNADBSECRET'].toString(),
      //     'Content-Type': 'application/json'
      //   },
      //   body: jsonEncode(<String, String>{
      //     'query': EventQueries().getEvents(),
      //   }),
      // );

      // print("response body: ");
      // print(jsonDecode(response.body));
      // getEventsResp["success"] = true;
      // getEventsResp["message"] = "Events Retrieved";
      // getEventsResp["data"] = jsonDecode(response.body)['data']['allEvent']['data'];

    } on Exception catch (e) {
      print('Mutation failed: $e');
      return getEventsResp;
    }
    on Exception catch (e) {
      print('Mutation failed: $e');        
    }

    return getEventsResp;

  }

  Future<Map<String, dynamic>> getGames(bool pickup) async{
    Map<String,dynamic> getEventResp = {"success": false, "message": "Default Error", "data": []};
    try{
      // http.Response response = await http.post(
      //   Uri.parse('https://graphql.fauna.com/graphql'),
      //   headers: <String, String>{
      //     'Authorization': 'Bearer '+ dotenv.env['FAUNADBSECRET'].toString(),
      //     'Content-Type': 'application/json'
      //   },
      //   body: jsonEncode(<String, String>{
      //     'query': EventQueries().getEvent(id),
      //   }),
      // );

      // print("response body: ");
      // print(jsonDecode(response.body));
      // getEventResp["success"] = true;
      // getEventResp["message"] = "Event Retrieved";
      // getEventResp["data"] = jsonDecode(response.body)['data']['findEventByID']['data'];

    } on Exception catch (e) {
      print('Mutation failed: $e');
      return getEventResp;
    }
    on Exception catch (e) {
      print('Mutation failed: $e');        
    }

    return getEventResp;

  }


  //setupSelections() should be function name
  Future<Map<String, dynamic>> setupEvents() async{
    print("setupEvents()");
    Map<String,dynamic> setupEventsResp = {"success": false, "message": "Default Error", "data": []};

    Map<String, dynamic> getGamesNearLocationResp = await GameCommand().getGamesNearLocation();
    if(getGamesNearLocationResp['success']){
      List<dynamic> games = getGamesNearLocationResp['data']; 
      print("in if statement");
      print("games: "+games.toString());
      eventsModel.games = games;
      homePageModel.selectedObjects = json.decode(json.encode(games));     
      print("length of games: "+games.length.toString());        
    }
    Map<String, dynamic> getLeaguesNearLocationResp = await LeagueCommand().getLeaguesNearLocation();
    if(getLeaguesNearLocationResp['success']){
      List<dynamic> leagues = getLeaguesNearLocationResp['data']; 
      print("in if statement");
      print("leagues: "+leagues.toString());
      eventsModel.leagues = leagues;      
    } 
     Map<String, dynamic> getTournamentsNearLocationResp = await TournamentCommand().getTournamentsNearLocation();   
    if(getTournamentsNearLocationResp['success']){
      List<dynamic> tournaments = getTournamentsNearLocationResp['data']; 
      print("in if statement");
      print("tournaments: "+tournaments.toString());
      eventsModel.tournaments = tournaments;      
    }    
    Map<String, dynamic> getTrainingsNearLocationResp = await TrainingCommand().getTrainingsNearLocation();
    if(getTrainingsNearLocationResp['success']){
      List<dynamic> trainings = getTrainingsNearLocationResp['data'];
      print("trainings: ");
      print(trainings);
      eventsModel.trainings = trainings;            
    }
    Map<String, dynamic> getTryoutsNearLocationResp = await TryoutCommand().getTryoutsNearLocation();
    if(getTryoutsNearLocationResp['success']){
      List<dynamic> tryouts = getTryoutsNearLocationResp['data'];
      print("tryouts: ");
      print(tryouts);
      eventsModel.tryouts = tryouts;            
    }
    Map<String, dynamic> getPlayersNearLocationResp = await PlayerCommand().getPlayersNearLocation();
    if(getPlayersNearLocationResp['success']){
      List<dynamic> players = getPlayersNearLocationResp['data'];
      print("players: ");
      print(players);
      appModel.players = players;            
    }
    Map<String, dynamic> getTeamsNearLocationResp = await TeamCommand().getTeamsNearLocation();
    if(getTeamsNearLocationResp['success']){
      List<dynamic> teams = getTeamsNearLocationResp['data'];
      print("teams: ");
      print(teams);
      appModel.teams = teams;            
    }
    // Map<String, dynamic> getTrainingsNearLocationResp = await TrainingCommand().getTrainingsNearLocation();
    // if(getTrainingsNearLocationResp['success']){
    //   List<dynamic> trainings = getTrainingsNearLocationResp['data'];
    //   print("trainings: ");
    //   print(trainings);
    //   eventsModel.trainings = trainings;            
    // }


    

    return setupEventsResp;

  }

  // updates models for views dependent on EventsModel
  Future<Map<String, dynamic>> updateViewModelsWithGame(Map<String, dynamic> game) async{
    print("updateViewModelsWithGame()");
    Map<String,dynamic> updateViewModelsWithGameResp = {"success": false, "message": "Default Error", "data": []};
    print("length of events modeL games: ");
    print(eventsModel.games.length);
    print("length of homePageModel selectedObjects: ");
    homePageModel.selectedObjects = List.from(eventsModel.games);    
    
    
    


    

    return updateViewModelsWithGameResp;

  }
  
  Future<Map<String, dynamic>>deleteGame(Map<String, dynamic> game, bool updateViewModelsBool) async{
    Map<String,dynamic> deleteGameResp = {"success": false, "message": "Default Error", "data": []};
    print("length of games before deleting game: ");
    print(eventsModel.games.length);    
    var i = 0;
    var found = false;
    while(i < eventsModel.games.length-1 && !found){
      if(eventsModel.games[i]['id'] == game['id']){
        var removed = eventsModel.games.removeAt(i);        
        print("removedGameObject: ");
        print(removed);
        found = true;
      }            
      i+=1;
    }
    print("length of games after deleting game: ");
    print(eventsModel.games.length);    
    print("updateViewModelsBool: ");
    print(updateViewModelsBool);
    if(updateViewModelsBool)
      await updateViewModelsWithGame(game);

    return deleteGameResp;
  }

  Future<Map<String, dynamic>>addGame(Map<String, dynamic> game, bool updateViewModelsBool) async{
    Map<String,dynamic> addGameResp = {"success": false, "message": "Default Error", "data": []};
    print("length of games before adding game: ");
    print(eventsModel.games.length);    
    eventsModel.games.add(game);
    print("length of games after adding game: ");
    print(eventsModel.games.length);    
    print("updateViewModelsBool: ");
    print(updateViewModelsBool);
    if(updateViewModelsBool)
      await updateViewModelsWithGame(game);

    return addGameResp;
  }

  Future<Map<String, dynamic>> setupMappedEvents() async {
    Map<String, dynamic> setupMappedEventsResp = {"success": false, "message": "Default Error", "data": null};
    try{
      EventsModel().mappedEvents = {
        "0": EventsModel().games,
        "3": EventsModel().tryouts,
        "4": EventsModel().tournaments,
        "5": EventsModel().leagues,

      };
    }on Exception catch(e) {
      print('Could not setup mapped events: $e');
      return setupMappedEventsResp;
    }

    return setupMappedEventsResp;

  }

  

 

}