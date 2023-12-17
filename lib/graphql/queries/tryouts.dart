import '../fragments/event_fragments.dart';

class TryoutQueries {
   String getTryouts()
   {
      String getTryouts = """
        query GetTryouts {
          allTryouts {
            data {      
              _id              
              event{
                ${EventFragments().fullEvent()}              
              } 
            }
          }
        }
      """;

      return getTryouts;
   }

}