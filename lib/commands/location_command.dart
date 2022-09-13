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

class LocationCommand extends BaseCommand {

  Future<List<String>> run(String user) async {
    // Make service call and inject results into the model
    List<String> posts = await userService.getPosts(user);

    // Return our posts to the caller in case they care
    return posts;
  }

 Future<Map<String, dynamic>> createLocation(Map<String, dynamic> locationInput ) async{
     print("createLocation");
    Map<String, dynamic> createLocationResponse = {"success": false, "message": "Default Error", "data": null};
    try {

      http.Response response = await http.post(
        Uri.parse('https://graphql.fauna.com/graphql'),
        headers: <String, String>{
          'Authorization': 'Bearer fnAEwU2qV_ACT5r5tpk0an5_qFS-M8vncFSUZPvL',
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