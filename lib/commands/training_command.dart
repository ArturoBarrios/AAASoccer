import 'dart:convert';
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


      final result = jsonDecode(response.body)['data']['allTrainings']['data'];
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
      eventInput['type'] = EventType.TRAINING;
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
      Map<String, dynamic> createdTraining =
            jsonDecode(response.body)['data']['createTraining'];
      eventInput['_id'] = createdTraining['event']['_id'];
      // await EventCommand().addTraining(createdTraining, true);

      if(eventInput['price']>0){
        Map<String, dynamic> paymentInput = {'price': eventInput['price'].toString()};
        print("create price event input: "+ eventInput.toString());
        print("create price input: " + paymentInput['price'].toString());
        Map<String, dynamic> createPriceResp = await EventCommand().createPrice(paymentInput, eventInput);
        print("createPaymentResp: "+createPriceResp.toString());

        dynamic createPrice = createPriceResp['data'];
        createdTraining['event']['price'] = createPrice;
        EventCommand().updateViewModelsWithTraining(createdTraining);
      }
        
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
