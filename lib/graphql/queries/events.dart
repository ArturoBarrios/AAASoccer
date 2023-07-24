import '../../enums/EventType.dart';
import '../fragments/event_fragments.dart';

class EventQueries {
   String allEventsOfType(String startTime, EventType type, String eventFragment) {
    String enumValue = type.toString().split('.').last;
  String getEvents = """
    query GetEvents {
      allEventsOftype(startTime: "$startTime", type: $enumValue) {
        
          
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


}