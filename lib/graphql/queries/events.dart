import '../../models/enums/EventType.dart';
import '../fragments/event_fragments.dart';

class EventQueries {
  String allEventsOfType(
      String startTime, EventType type, String eventFragment) {
    String enumValue = type.toString().split('.').last;
    String getEvents = """
    query GetEvents {
      allEventsOfType(startTime: "$startTime", type: $enumValue) {                  
          $eventFragment        
      }
    }
  """;

    return getEvents;
  }
  
  String allEventsInAreaOfType(
      dynamic getEventsOfTypeNearLocation,
      String eventFragment) {
    String enumValue = getEventsOfTypeNearLocation['type'].toString().split('.').last;
    String getEvents = """
    query AllEventsOfType {
      allEventsInAreaOfType(
        type: GAME,
        latitude: ${getEventsOfTypeNearLocation['latitude']}
        longitude: ${getEventsOfTypeNearLocation['longitude']}
        radius: 100
        startTime: "122656565"
        ) {    
          code
          success
          message     
          events{
            ${eventFragment}

          }         
      }
    }
  """;

    return getEvents;
  }

  String allEventsOfAllTypes(String startTime, String eventFragment) {
    String getEvents = """
      query GetEvents {
        allEventsOfAllTypes(startTime: "$startTime") {                  
            $eventFragment        
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

  String getEvent(String id) {
    String getGame = """
        query getEvent {
          findEventByID(id: $id) {                           
            ${EventFragments().fullEvent()}              
          }          
        }
      """;

    return getGame;
  }
}
