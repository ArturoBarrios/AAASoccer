import 'dart:convert';
import 'base_command.dart';
import 'package:amplify_api/amplify_api.dart';
import '../models/Location.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:faunadb_http/faunadb_http.dart';
import 'package:faunadb_http/query.dart';
import '../models/app_model.dart';
import 'package:http/http.dart' as http;
import '../graphql/mutations/locations.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:url_launcher/url_launcher.dart';


class LocationCommand extends BaseCommand {


// Future<List<Prediction>> searchLocation(BuildContext context, String text) async {
//     if(text != null && text.isNotEmpty) {
//       http.Response response = await getLocationData(text);
//       var data = jsonDecode(response.body.toString());
//       print("my status is "+data["status"]);
//       if ( data['status']== 'OK') {
//         _predictionList = [];
//         data['predictions'].forEach((prediction)
//         => _predictionList.add(Prediction.fromJson(prediction)));
//       } else {
//         // ApiChecker.checkApi(response);
//       }
//     }
//     return _predictionList;
//   }

   Future<void> place_api_autocomplete(String searchText) async{        
        print("place_api_autocomplete()");
        try{
            String autocompleteUrl = 'https://maps.googleapis.com/maps/api/place/autocomplete/json?input='+searchText.toString()+'&key='+'AIzaSyDTdSXb1X7vFTDvwBQhcVDY6DOMiLcjQuM';
            http.Response response = await http.get(
            Uri.parse(autocompleteUrl),
            headers: <String, String>{          
              'Content-Type': 'application/json'
            },        
          );
          print("Response: "+response.body.toString());

        } catch(e){
          print(e);
        }
    }

  Future<void> openMap(double latitude, double longitude) async{
    String googleUrl = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunchUrl(Uri.parse(googleUrl))) {
      await launchUrl(Uri.parse(googleUrl));
    } else {
      throw 'Could not open the map.';
    }
  }
  

 Future<Map<String, dynamic>> createLocation(Map<String, dynamic> locationInput ) async{
     print("createLocation");
    Map<String, dynamic> createLocationResponse = {"success": false, "message": "Default Error", "data": null};
    try {

      http.Response response = await http.post(
        Uri.parse('https://graphql.fauna.com/graphql'),
        headers: <String, String>{
          'Authorization': 'Bearer '+ dotenv.env['FAUNADBSECRET'].toString(),
          'Content-Type': 'application/json'
        },
        body: jsonEncode(<String, String>{
          'query': LocationMutations().createLocation(locationInput),
        }),
      );

      if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
      print("response body: ");
      print(jsonDecode(response.body));

      createLocationResponse["success"] = true;
      createLocationResponse["message"] = "Location Created";
      createLocationResponse["data"] = jsonDecode(response.body)['data']['createLocation'];
  } else {
    //rollback somehow???
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
      return createLocationResponse;
    } on ApiException catch (e) {
      print('Mutation failed: $e');
      return createLocationResponse;
    }
  }

  

 

}