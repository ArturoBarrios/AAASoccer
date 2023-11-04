import 'dart:convert';

import 'package:soccermadeeasy/extensions/parse_roles.dart';

import '../components/join_condition.dart';
import '../graphql/fragments/team_fragments.dart';
import 'base_command.dart';
import 'package:amplify_api/amplify_api.dart';
import 'package:http/http.dart' as http;
import '../graphql/mutations/teams.dart';
import '../graphql/mutations/requests.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:geolocator/geolocator.dart';
import '../graphql/queries/teams.dart';
import '../commands/notifications_command.dart';
import '../commands/user_command.dart';
import '../constants.dart';
import '../graphql/mutations/users.dart';
import 'home_page_command.dart';

class GroupCommand extends BaseCommand {
  Future<Map<String,dynamic>> createGroup(dynamic createGroupInput, dynamic locationInput) async{
    Map<String,dynamic> createGroupResp = {
      'status': false,
      'message': 'Error creating group',
      'data': null
    };

    try{

      return createGroupResp;
    } catch (e) {
      print("Error in createGroup(): $e");
      return createGroupResp;
    }
  }
 
}
