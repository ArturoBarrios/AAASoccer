import '../fragments/event_fragments.dart';

class TrainingQueries {
   String getTrainings()
   {
      String getTrainings = """
        query GetTrainings {
          allTrainings {
            data {      
              _id              
              event{
                ${EventFragments().fullEvent()}                  
              }        
            }
          }
        }
      """;

      return getTrainings;
   }

}