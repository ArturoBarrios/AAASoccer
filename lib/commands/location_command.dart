import 'dart:convert';
import 'package:geolocator/geolocator.dart';

import '../models/appModels/Location.dart';
import 'base_command.dart';
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:faunadb_http/faunadb_http.dart';
import 'package:faunadb_http/query.dart';
import '../models/pageModels/app_model.dart';
import 'package:http/http.dart' as http;
import '../graphql/mutations/locations.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:url_launcher/url_launcher.dart';

import 'geolocation_command.dart';



class LocationCommand extends BaseCommand {
  
  //get locations with conditions: 
  //2+ events in the last 30 days
  //2+ teams in the last 30 days
  //location details filled out(description, url)
  Future<List<Location>> getLocationsNearMe() async{
    int distance = appModel.distanceFilter;
    Position currentLocation = await LocationCommand().getCurrentPosition();
    List<Location> locations = [];
    locations.forEach((location) async {
      double distanceFromUser = await GeoLocationCommand().getDistanceFromPoint(location.latitude!, location.longitude!, currentLocation);
      if(distanceFromUser <= distance){
        locations.add(location);
      }
      
    });

    return locations;

  }

  void setCurrentPosition(Position position){
    appModel.currentPosition = position;    
  }

  Future<Position> getCurrentPosition() async{
    //check if current position is set
    if(appModel.currentPosition.latitude == 0){
      Position userPosition = await GeoLocationCommand().determinePosition();
      LocationCommand().setCurrentPosition(userPosition);      
    }          
    
    return appModel.currentPosition;
  }

   Future<Map<String, dynamic>> place_api_autocomplete(String searchText) async{        
        print("place_api_autocomplete()");
        Map<String, dynamic> responseMap = {"success": false, "message": "Default", "data": null};
        try{
            String autocompleteUrl = 'https://maps.googleapis.com/maps/api/place/autocomplete/json?input='+searchText.toString()+'&key='+'AIzaSyDTdSXb1X7vFTDvwBQhcVDY6DOMiLcjQuM';
            http.Response response = await http.get(
            Uri.parse(autocompleteUrl),
            headers: <String, String>{          
              'Content-Type': 'application/json'
            },        
          );
          // print("Response: "+jsonDecode(response.body));
          responseMap["success"] = true;
          responseMap["message"] = "Success";
          responseMap["data"] = jsonDecode(response.body)["predictions"];
          return responseMap;
        } catch(e){
          print(e);
          return responseMap;
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