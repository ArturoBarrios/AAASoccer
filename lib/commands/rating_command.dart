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


class RatingCommand extends BaseCommand {
  Future<Map<String, dynamic>> getObjectRatings(String id) async{        
    print("getRating()");
    Map<String, dynamic> responseMap = {"success": false, "message": "Default", "data": null};
    try{
        String autocompleteUrl = 'https://api.sportsengine.com/organizations/locations/'+id+'/reviews';
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

  double calculateAverageRating(List<dynamic> ratings){
    print("calculateAverageRating()");
    double averageRating = 0;
    double totalRating = 0;
    for(int i = 0; i < ratings.length; i++){
      totalRating += ratings[i]["rating"];
    }
    averageRating = totalRating/ratings.length;

    return averageRating;

  }

  

 

}