import 'dart:convert';
import '../graphql/mutations/organizations.dart';
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


class OrganizationCommand extends BaseCommand {

  Future<Map<String,dynamic>> createOrganization(dynamic organizationInput)async {
    print("createOrganization()");
    Map<String, dynamic> createOrganizationResp = {
      "success": false, 
      "message": "Default", 
      "data": null
    };
    
    try{
      http.Response response = await http.post(
        Uri.parse('https://graphql.fauna.com/graphql'),
        headers: <String, String>{
          'Authorization': 'Bearer '+ dotenv.env['FAUNADBSECRET'].toString(),
          'Content-Type': 'application/json'
        },
        body: jsonEncode(<String, String>{
          'query': OrganizationMutations().createOrganization(organizationInput),
        }),
      );

      print("response body: ");
      print(jsonDecode(response.body));

      Map<String, dynamic> createOrganization =
            jsonDecode(response.body)['data']['createOrganization'];
      createOrganizationResp["success"] = true;
      createOrganizationResp["data"] = createOrganization;

      return createOrganizationResp;
    } catch (e){
      print(e);
      return createOrganizationResp;
    }

  }



}