import 'base_command.dart';
import 'package:amplify_api/amplify_api.dart';
import '../graphql/mutations/tryouts.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:geolocator/geolocator.dart';
import '../commands/geolocation_command.dart';
import '../graphql/queries/tryouts.dart';
import '../commands/event_command.dart';

class TryoutCommand extends BaseCommand {


Future<Map<String, dynamic>> getTryoutsNearLocation() async{
      print("getTryoutsNearLocation");
    Map<String, dynamic> getTryoutsNearLocationResp = {"success": false, "message": "Default Error", "data": null};
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
            'query': TryoutQueries().getTryouts(),
          }),
        );

        print("response body: ");
        print(jsonDecode(response.body));


      final result = jsonDecode(response.body)['data']['allTryouts']['data'];
      getTryoutsNearLocationResp["success"] = true;
      getTryoutsNearLocationResp["message"] = "Tryouts Retrieved";
      getTryoutsNearLocationResp["data"] = result;
      
    } on Exception catch (e) {
      print('Mutation failed: $e');  
    }

    return getTryoutsNearLocationResp;

  }


 Future<Map<String, dynamic>> createTryout(
      Map<String, dynamic> tryoutInput,
      Map<String, dynamic> eventInput, Map<String, dynamic> locationInput) async {
    print("createTryout");
    print("tryoutInput: "+tryoutInput.toString());
    print("eventInput: "+eventInput.toString());
    eventInput['price'] = eventInput['price']*100;
    
    Map<String, dynamic> createTryoutResponse = {
      "success": false,
      "message": "Default Error",
      "data": null
    };
    try {
      Map<String, dynamic> userInput = {
        "_id": appModel.currentUser['_id'],
      };   
     
      http.Response response = await http.post(
        Uri.parse('https://graphql.fauna.com/graphql'),
        headers: <String, String>{
          'Authorization': 'Bearer '+ dotenv.env['FAUNADBSECRET'].toString(),
          'Content-Type': 'application/json'
        },
        body: jsonEncode(<String, String>{
          'query': TryoutMutations().createTryout(tryoutInput, eventInput, locationInput, userInput),
        }),
      );

      print("response body: ");
      print(jsonDecode(response.body));
      Map<String, dynamic> createdTryout =
            jsonDecode(response.body)['data']['createTryout'];
      // await EventCommand().addGame(createdTryout, true);


      eventInput['_id'] = createdTryout['event']['_id'];
      Map<String, dynamic> paymentInput = {'price': eventInput['price'].toString()};
      print("create price event input: "+ eventInput.toString());
      print("create price input: " + paymentInput['price'].toString());
      Map<String, dynamic> createPriceResp = await EventCommand().createPrice(paymentInput, eventInput);
      print("createPaymentResp: "+createPriceResp.toString());

      dynamic createPrice = createPriceResp['data'];
      createdTryout['event']['price'] = createPrice;
      EventCommand().updateViewModelsWithTryout(createdTryout);
        
        createTryoutResponse["success"] = true;
        createTryoutResponse["message"] = "Game Created";
        createTryoutResponse["data"] = createdTryout;
        
      
      

      
    } on ApiException catch (e) {
      print('Mutation failed: $e');
      
    }
      return createTryoutResponse;  
  }

  

 

}