import '../../enums/EventType.dart';
import '../fragments/event_fragments.dart';
import 'package:faunadb_http/faunadb_http.dart';
import 'package:faunadb_http/query.dart';

class EventQueries {
   String allEventsOfType(String startTime, EventType type, String eventFragment) {
    String enumValue = type.toString().split('.').last;
  String getEvents = """
    query GetEvents {
      allEventsOfType(startTime: "$startTime", type: $enumValue) {                  
          ${eventFragment}        
      }
    }
  """;

  return getEvents;
}

  String allEventsOfAllTypes(String startTime, String eventFragment) {    
    String getEvents = """
      query GetEvents {
        allEventsOfAllTypes(startTime: "$startTime") {                  
            ${eventFragment}        
        }
      }
    """;
  return getEvents;
}
  
  String allUserEventParticipants(dynamic allUserEventParticipantsInput) {    
    String getUserEvents = """
      query GetEventUserParticipants {
        allCurrentUserEventParticipants(startTime: "${allUserEventParticipantsInput['startTime']}", userId:"${allUserEventParticipantsInput['userId']}") {                              
              ${allUserEventParticipantsInput['eventFragment']}            
        }
      }
    """;
  return getUserEvents;
}



}