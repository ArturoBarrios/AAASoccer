import '../fragments/event_fragments.dart';

class EventQueries {
   String getEvents(String startTime, String endTime, String type, String eventFragment) {
  String getEvents = """
    query GetEvents {
      allEvents(startTime: "$startTime", endTime: "$endTime", type: "GAME") {
        data {
          _id
          ${eventFragment}
        }
      }
    }
  """;

  return getEvents;
}


}