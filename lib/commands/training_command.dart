import 'dart:convert';
import 'package:soccermadeeasy/constants.dart';

import '../enums/EventType.dart';
import 'base_command.dart';
import 'package:amplify_api/amplify_api.dart';
import '../models/Training.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import '../../commands/payment_commands.dart';
import 'package:faunadb_http/faunadb_http.dart';
import 'package:faunadb_http/query.dart';
import '../models/app_model.dart';
import '../graphql/mutations/training.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:geolocator/geolocator.dart';
import '../commands/geolocation_command.dart';
import '../commands/event_command.dart';
import '../graphql/queries/trainings.dart';

class TrainingCommand extends BaseCommand {
  
  List<dynamic> sortTrainings(List<dynamic> trainings,String sortBy){
    //assume events are sorted by date for now
    print("sortEvents()");
    print("sortBy: " + sortBy);
    List<dynamic> sortedtrainings = List.from(trainings);
    sortedtrainings.sort((a, b) {
      int aCreatedAt = int.tryParse(a["event"]["createdAt"]) ?? 0;
      int bCreatedAt = int.tryParse(b["event"]["createdAt"]) ?? 0;
      print("aCreatedAt: " + aCreatedAt.toString());
      print("bCreatedAt: " + bCreatedAt.toString());
      return bCreatedAt.compareTo(aCreatedAt);
    });

    return sortedtrainings;


  }

  Future<Map<String, dynamic>> getTrainingsNearLocation() async{
      print("getTrainingNearLocation");
    Map<String, dynamic> getTrainingsNearLocationResp = {"success": false, "message": "Default Error", "data": null};
    try{
      print("my position");
      // Position myPosition = await GeoLocationCommand().determinePosition();
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


      dynamic result = jsonDecode(response.body)['data']['allTrainings']['data'];
      print("result: "+ result.toString());
      result = sortTrainings(result, Constants.CREATEDATE);
      getTrainingsNearLocationResp["success"] = true;
      getTrainingsNearLocationResp["message"] = "Trainings Retrieved";
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
    print("trainingInput: "+trainingInput.toString());
    print("eventInput: "+eventInput.toString());
    Map<String, dynamic> createTrainingResponse = {
      "success": false,
      "message": "Default Error",
      "data": null
    };
    try {
      Map<String, dynamic> userInput = {
        "_id": appModel.currentUser['_id'],
      };         
      eventInput['price'] = eventInput['price']*100;
     
      http.Response response = await http.post(
        Uri.parse('https://graphql.fauna.com/graphql'),
        headers: <String, String>{
          'Authorization': 'Bearer '+ dotenv.env['FAUNADBSECRET'].toString(),
          'Content-Type': 'application/json'
        },
        body: jsonEncode(<String, String>{
          'query': TrainingMutations().createTraining(trainingInput, eventInput, locationInput, userInput),
        }),
      );

      print("response body: ");
      print(jsonDecode(response.body));

      if(response.statusCode == 200){
        Map<String, dynamic> createdTraining =
              jsonDecode(response.body)['data']['createTraining'];
                
          createTrainingResponse["success"] = true;
          createTrainingResponse["message"] = "Game Created";
          createTrainingResponse["data"] = createdTraining;       
      }
        
      
      

      
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
