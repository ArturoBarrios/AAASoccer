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
  
  String getArchivedEvents(
      dynamic getArchivedEventsInput,
      String eventFragment) {           
    String getEvents = """
      query GetArchivedEvents {
        getArchivedEvents(                
          startTime: "${getArchivedEventsInput['startTime']}"
          userId: "${getArchivedEventsInput['userId']}"
          ) {    
            code
            success
            message     
            archivedEvents{
              name        	
      _id  
      type                        
      isMainEvent
      mainImageKey
      archived
      deleted  
      startTime
      endTime  
      capacity
      createdAt    
      amenities

            }         
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

//userEventParticipants fragment in EventFreatments
  String allUserEventParticipants(dynamic allUserEventParticipantsInput) {
    String getUserEvents = """
      query AllUserEventParticipants {
        allUserEventParticipants(startTime:"${allUserEventParticipantsInput['startTime']}", _id: "${allUserEventParticipantsInput['_id']}" ) {          
          code
          success
          message
          eventUserParticipants {
            ${allUserEventParticipantsInput['eventFragment']}
          }
        }
      }
    """;
      // query GetEventUserParticipants {
      //   allCurrentUserEventParticipants(startTime: "${allUserEventParticipantsInput['startTime']}", userId:"${allUserEventParticipantsInput['userId']}") {                              
      //         ${allUserEventParticipantsInput['eventFragment']}            
      //   }
      // }
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
