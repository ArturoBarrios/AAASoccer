import 'dart:convert';
import 'package:geolocator/geolocator.dart';

import '../graphql/fragments/location_fragments.dart';
import '../graphql/queries/locations.dart';
import '../models/appModels/Location.dart';
import '../models/enums/LocationType.dart';
import 'base_command.dart';
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';


import '../models/pageModels/app_model.dart';
import 'package:http/http.dart' as http;
import '../graphql/mutations/locations.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:url_launcher/url_launcher.dart';

import 'geolocation_command.dart';



class LocationCommand extends BaseCommand {

  Future<Map<String,dynamic>> getFieldLocationsFromLocation(dynamic input) async{    
    Map<String, dynamic> getFieldLocationsResp = {"success": false, "message": "Default", "data": null};

    print("getFieldLocationsFromLocation()");
    print("input: " + input.toString());
    try{
       http.Response response = await http.post(
        Uri.parse(dotenv.env['APOLLO_SERVER'].toString()),
        headers: <String, String>{          
          'Content-Type': 'application/json'
        },
        body: jsonEncode(<String, String>{
          'query': LocationQueries().getFieldLocationsOfLocation(input, LocationFragments().FieldLocationFull()),
        }),
      );
      print("response body: ");
      print(jsonDecode(response.body));
      
      if(response.statusCode == 200){
        final result = jsonDecode(response.body)['data']['getFieldLocationsOfLocation'];
        if(result['success']){                    
          getFieldLocationsResp["success"] = true;
          getFieldLocationsResp["message"] = "Field Locations Nearby Retrieved";
          getFieldLocationsResp["data"] = result['fieldLocations'];
        }

      }

      return getFieldLocationsResp;
      
      
    } on ApiException catch(e){
      print('Query failed: $e');
      return getFieldLocationsResp;
    }
  }

  Future<Map<String,dynamic>> getFieldLocationsNearby(dynamic getFieldLocationsNearbyInput) async{    
    Map<String, dynamic> getFieldLocationsResp = {"success": false, "message": "Default", "data": null};

    print("getFieldLocationsNearby()");
    print("getFieldLocationsNearbyInput: " + getFieldLocationsNearbyInput.toString());
    try{
       http.Response response = await http.post(
        Uri.parse(dotenv.env['APOLLO_SERVER'].toString()),
        headers: <String, String>{          
          'Content-Type': 'application/json'
        },
        body: jsonEncode(<String, String>{
          'query': LocationQueries().getFieldLocationsNearby(getFieldLocationsNearbyInput, LocationFragments().FieldLocationFull()),
        }),
      );
      print("response body: ");
      print(jsonDecode(response.body));
      if(response.statusCode == 200){
        final result = jsonDecode(response.body)['data']['getFieldLocationsNearby'];
        if(result['success']){          
          
          getFieldLocationsResp["success"] = true;
          getFieldLocationsResp["message"] = "Field Locations Nearby Retrieved";
          getFieldLocationsResp["data"] = result['fieldLocations'];

        }

      }

      return getFieldLocationsResp;
      
      
    } on ApiException catch(e){
      print('Query failed: $e');
      return getFieldLocationsResp;
    }
  }
  
  Future<Map<String,dynamic>> getLocationsNearby(dynamic getLocationsNearbyInput) async{    
    Map<String, dynamic> getLocationsResp = {"success": false, "message": "Default", "data": null};

    print("getLocationsNearby()");
    print("getLocationsNearbyInput: " + getLocationsNearbyInput.toString());
    try{
       http.Response response = await http.post(
        Uri.parse(dotenv.env['APOLLO_SERVER'].toString()),
        headers: <String, String>{          
          'Content-Type': 'application/json'
        },
        body: jsonEncode(<String, String>{
          'query': LocationQueries().getLocationsNearby(getLocationsNearbyInput, LocationFragments().LocationFull()),
        }),
      );
      print("response body: ");
      print(jsonDecode(response.body));
      if(response.statusCode == 200){
        final result = jsonDecode(response.body)['data']['getLocationsNearby'];
        if(result['success']){          
          
          getLocationsResp["success"] = true;
          getLocationsResp["message"] = "Field Locations Nearby Retrieved";
          getLocationsResp["data"] = result['locations'];

        }

      }

      return getLocationsResp;
      
      
    } on ApiException catch(e){
      print('Query failed: $e');
      return getLocationsResp;
    }
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