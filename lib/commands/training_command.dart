import 'dart:convert';
import 'base_command.dart';
import 'package:amplify_api/amplify_api.dart';
import '../models/Training.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import '../commands/event_command.dart';
import 'package:faunadb_http/faunadb_http.dart';
import 'package:faunadb_http/query.dart';
import '../models/app_model.dart';
import '../graphql/mutations/training.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart';
import '../commands/geolocation_command.dart';
import '../graphql/queries/trainings.dart';

class TrainingCommand extends BaseCommand {
  
  Future<Map<String, dynamic>> getTrainingsNearLocation() async{
      print("getGamesNearLocation");
    Map<String, dynamic> getTrainingsNearLocationResp = {"success": false, "message": "Default Error", "data": null};
    try{
      print("my position");
      Position myPosition = await GeoLocationCommand().determinePosition();
      http.Response response = await http.post(
          Uri.parse('https://graphql.fauna.com/graphql'),
          headers: <String, String>{
            'Authorization': 'Bearer '+ dotenv.env['FAUNADBSECRET'].toString(),
            'Content-Type': 'application/json'
          },
          body: jsonEncode(<String, String>{
            'query': TrainingQueries().getTrainings(),
          }),
        );

        print("response body: ");
        print(jsonDecode(response.body));


      final result = jsonDecode(response.body)['data']['allTrainings']['data'];
      getTrainingsNearLocationResp["success"] = true;
      getTrainingsNearLocationResp["message"] = "Games Retrieved";
      getTrainingsNearLocationResp["data"] = result;
      
    } on Exception catch (e) {
      print('Mutation failed: $e');  
    }

    return getTrainingsNearLocationResp;

  }

  Future<Map<String, dynamic>> createTraining(
      Map<String, dynamic> trainingInput,
      Map<String, dynamic> eventInput, Map<String, dynamic> locationInput) async {
    print("createTraining");
    Map<String, dynamic> createTrainingResponse = {
      "success": false,
      "message": "Default Error",
      "data": null
    };
    try {
     
      http.Response response = await http.post(
        Uri.parse('https://graphql.fauna.com/graphql'),
        headers: <String, String>{
          'Authorization': 'Bearer '+ dotenv.env['FAUNADBSECRET'].toString(),
          'Content-Type': 'application/json'
        },
        body: jsonEncode(<String, String>{
          'query': TrainingMutations().createTraining(trainingInput, eventInput, locationInput),
        }),
      );

      print("response body: ");
      print(jsonDecode(response.body));
        
        createTrainingResponse["success"] = true;
        createTrainingResponse["message"] = "Game Created";
        createTrainingResponse["data"] = jsonDecode(response.body)['data']['createTraining'];
        
      
      

      
    } on ApiException catch (e) {
      print('Mutation failed: $e');
      
    }
      return createTrainingResponse;  
  }

  Future<Map<String, dynamic>> addTrainingToGame(Map<String, dynamic> trainingInput, Map<String, dynamic> playerInput ) async{
    print("addPlayerToGame");
    Map<String, dynamic> addPlayerToGameResponse = {"success": false, "message": "Default Error", "data": null};
    
    http.Response response = await http.post(
        Uri.parse('https://graphql.fauna.com/graphql'),
        headers: <String, String>{
          'Authorization': 'Bearer '+ dotenv.env['FAUNADBSECRET'].toString(),
          'Content-Type': 'application/json'
        },
        body: jsonEncode(<String, String>{
          'query': TrainingMutations().addPlayerToTraining(trainingInput, playerInput),
        }),
      );

      print("response body: ");
      print(jsonDecode(response.body));
        
      addPlayerToGameResponse["success"] = true;
      addPlayerToGameResponse["message"] = "Game Created";
      addPlayerToGameResponse["data"] = jsonDecode(response.body)['data']['updateTraining'];

    return addPlayerToGameResponse;
  }
}
