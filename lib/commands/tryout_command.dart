import 'package:soccermadeeasy/constants.dart';

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

List<dynamic> sortTryouts(List<dynamic> tryouts,String sortBy){
    //assume events are sorted by date for now
    print("sortEvents()");
    print("sortBy: " + sortBy);
    List<dynamic> sortedtryouts = List.from(tryouts);
    sortedtryouts.sort((a, b) {
      int aCreatedAt = int.tryParse(a["event"]["createdAt"]) ?? 0;
      int bCreatedAt = int.tryParse(b["event"]["createdAt"]) ?? 0;
      print("aCreatedAt: " + aCreatedAt.toString());
      print("bCreatedAt: " + bCreatedAt.toString());
      return bCreatedAt.compareTo(aCreatedAt);
    });

    return sortedtryouts;

  }

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


      dynamic result = jsonDecode(response.body)['data']['allTryouts']['data'];
      print("result: "+ result.toString());
      result = sortTryouts(result, Constants.CREATEDATE);

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

      if(response.statusCode == 200){
        Map<String, dynamic> createdTryout =
              jsonDecode(response.body)['data']['createTryout'];                          
        createTryoutResponse["success"] = true;
        createTryoutResponse["message"] = "Game Created";
        createTryoutResponse["data"] = createdTryout;
      }
        
      
      

      
    } on ApiException catch (e) {
      print('Mutation failed: $e');
      
    }
      return createTryoutResponse;  
  }

  

 

}