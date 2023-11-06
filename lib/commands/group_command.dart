import 'dart:convert';

import 'package:soccermadeeasy/extensions/parse_roles.dart';

import '../components/join_condition.dart';
import '../graphql/fragments/group_fragments.dart';
import '../graphql/queries/groups.dart';
import 'base_command.dart';
import 'package:amplify_api/amplify_api.dart';
import 'package:http/http.dart' as http;
import '../graphql/mutations/groups.dart';
import '../graphql/mutations/requests.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:geolocator/geolocator.dart';
import '../graphql/queries/groups.dart';
import '../commands/notifications_command.dart';
import '../commands/user_command.dart';
import '../constants.dart';
import '../graphql/mutations/groups.dart';
import 'home_page_command.dart';

class GroupCommand extends BaseCommand {
  Future<Map<String,dynamic>> createGroup(dynamic createGroupInput, dynamic locationInput) async{
    Map<String,dynamic> createGroupResp = {
      'status': false,
      'message': 'Error creating group',
      'data': null
    };

    try{
      createGroupInput['user_id'] = appModel.currentUser['_id'];
      createGroupInput['price'] = createGroupInput['price'] * 100;
      http.Response response = await http.post(
        Uri.parse('https://graphql.fauna.com/graphql'),
        headers: <String, String>{
          'Authorization': 'Bearer ${dotenv.env['FAUNADBSECRET']}',
          'Content-Type': 'application/json'
        },
        body: jsonEncode(<String, String>{
          'query': GroupMutations().createGroup(createGroupInput, locationInput),
        }),
      );

      print("response body: ");
      print(jsonDecode(response.body));
      if (response.statusCode == 200) {
        dynamic createdGroup = createGroupResp["data"] =
            jsonDecode(response.body)['data']['createGroup'];

        createGroupResp["data"] = createdGroup;
        createGroupResp["success"] = true;
        createGroupResp["message"] = "Group Created";
      } else {
        //rollback somehow???
        // If the server did not return a 200 OK response,
        // then throw an exception.
        throw Exception('Failed to load album');
      }



      return createGroupResp;
    } catch (e) {
      print("Error in createGroup(): $e");
      return createGroupResp;
    }
  }



  Future<Map<String, dynamic>> getAllGroups() async {
    print("getAllGroups");
    Map<String, dynamic> getAllGroupsResp = {
      "success": false,
      "message": "Default Error",
      "data": null
    };
    try {
      http.Response response = await http.post(
        Uri.parse('https://graphql.fauna.com/graphql'),
        headers: <String, String>{
          'Authorization': 'Bearer ${dotenv.env['FAUNADBSECRET']}',
          'Content-Type': 'application/json'
        },
        body: jsonEncode(<String, String>{
          'query': GroupQueries().getAllGroups(),
        }),
      );

      print("response body: ");
      print(jsonDecode(response.body));
      if (response.statusCode == 200) {
        dynamic result = jsonDecode(response.body)['data']['getGroups'];
        print("getAllGroups result: $result");
        getAllGroupsResp["success"] = true;
        getAllGroupsResp["message"] = "Groups Retrieved";
        getAllGroupsResp["data"] = result;
      }
      return getAllGroupsResp;
    } on Exception catch (e) {
      print('Mutation failed: $e');
      return getAllGroupsResp;
    }
  }

  Future<Map<String,dynamic>> getUserGroupDetails(dynamic group, bool addToEventPageModel) async {
    print("getUserGroupDetails()");

    Map<String,dynamic> userGroupDetails = {
      "success": false,
       "isMine": false,
      "isMember": "",
      "amountPaid": 0,
      "paymentObjects": [],
      "mainEvent": null,
      "group": group,
      "players": [],
      "organizers": [],
      "events": [],
      "roles": [],
      "chats": [],
      "userParticipants": [], 
    
    };

    try{
       dynamic groupResp = await findGroupById(group);
    print("groupResp: $groupResp");
    group = groupResp['data'];
    

    
    

    //get chats
    dynamic chats = group['chats']['data'];
    userGroupDetails['chats'] = chats;
    
    print("length of chats in userGroupDetails: ${chats.length}");

    List<dynamic> myGroupRoles = getMyGroupRoles(group, appModel.currentUser);
    print("myGroupRoless: $myGroupRoles");
    print("myGroupRoles.contains organizer: ${myGroupRoles.contains("ORGANIZER")}");

    userGroupDetails['roles'] = myGroupRoles;
    
    userGroupDetails['isMine'] = myGroupRoles.contains("ORGANIZER");
    
    userGroupDetails['isMember'] = myGroupRoles.contains("PLAYER");
    
    userGroupDetails['groupLocations'] = group['groupLocations']['data'];

    List<dynamic> userParticipants = group['userParticipants']['data'];
    userGroupDetails['userParticipants'] = userParticipants;   
    for (int i = 0; i < userParticipants.length; i++) {
      if (myGroupRoles.contains("PLAYER")) {
        userGroupDetails['players'].add(userParticipants[i]['user']);
        
      }
      if (myGroupRoles.contains("ORGANIZER")) {
        userGroupDetails['organizers'].add(userParticipants[i]['user']);
        
      }
    }

    //join conditions
      userGroupDetails['group']['joinConditions']['data'].forEach((joinCondition) {
        if(joinCondition['forGroup']){
          userGroupDetails['groupRequestJoin'] = new JoinCondition(label: "Join With Request", required: joinCondition['withRequest']); 
          userGroupDetails['groupPaymentJoin'] = new JoinCondition(label: "Join With Payment", required: joinCondition['withPayment']);                     
        }        
      });

    //get price and payment info
    List payments = group['payments']['data'];
    userGroupDetails['payments'] = payments;
    
    userGroupDetails['amountPaid'] = "0.00";
    
    userGroupDetails['amountRemaining'] = "0.00";
    
    userGroupDetails['price'] = group['price'];
    
    if (group['price'] != null) {
      print("payments: $payments");
      //get payment data
      double amountPaid = 0.0;
      for (int i = 0; i < payments.length; i++) {
        if (payments[i]['user']['_id'] == appModel.currentUser['_id']) {
          print("amount before parsing: ${payments[i]['amount']}");
          amountPaid += double.parse(payments[i]['amount']);
        }
      }
      userGroupDetails['amountPaid'] = (amountPaid).toStringAsFixed(2);
      
      userGroupDetails['amountRemaining'] =
          (double.parse(group['price']['amount']) - amountPaid)
              .toStringAsFixed(2);      
    }

    print(
        "getUserGroupDetails() finished with userGroupDetails: $userGroupDetails");

    if (addToEventPageModel) {
      groupPageModel.group = userGroupDetails['group'];
      groupPageModel.chats = userGroupDetails['chats'];
      groupPageModel.roles = userGroupDetails['roles'];
      groupPageModel.isMine = userGroupDetails['isMine'];
      groupPageModel.isMember = userGroupDetails['isMember'];
      groupPageModel.userParticipants = userGroupDetails['userParticipants'];
      groupPageModel.players = userGroupDetails['players'];
      groupPageModel.organizers = userGroupDetails['organizers'];
      groupPageModel.payments = userGroupDetails['payments'];
      groupPageModel.amountPaid = userGroupDetails['amountPaid'];
      groupPageModel.amountRemaining = userGroupDetails['amountRemaining'];
      groupPageModel.price = userGroupDetails['price'];
      groupPageModel.groupLocations = userGroupDetails['groupLocations'];
      groupPageModel.groupRequestJoin = userGroupDetails['groupRequestJoin'];
      groupPageModel.groupPaymentJoin = userGroupDetails['groupPaymentJoin'];
    }

      userGroupDetails['success'] = true; 

      return userGroupDetails;
    } catch(e){
      print("error in getUserGroupDetails: $e");
      return userGroupDetails;
    }
    
      
  }

   Future<Map<String, dynamic>> findGroupById(
    Map<String, dynamic> groupInput,
  ) async {
    print("getGroup");
    Map<String, dynamic> getGroupResp = {
      "success": false,
      "message": "no group found",
      "data": null
    };
    try {
      print("groupInput: ");
      print(groupInput);

      http.Response response = await http.post(
        Uri.parse('https://graphql.fauna.com/graphql'),
        headers: <String, String>{
          'Authorization': 'Bearer ${dotenv.env['FAUNADBSECRET']}',
          'Content-Type': 'application/json'
        },
        body: jsonEncode(<String, String>{
          'query': GroupQueries().findGroupByID(groupInput),
        }),
      );

      print("response: ");
      print(jsonDecode(response.body));
      final result = jsonDecode(response.body)['data']['findGroupByID'];
      // appModel.currentGroup = result;
      // if (result != null) {
      getGroupResp["success"] = true;
      getGroupResp["message"] = "group found";
      getGroupResp["data"] = result;
      // }
    } catch (e) {
      print('Query failed: $e');
    }
    return getGroupResp;
  }
 
}
