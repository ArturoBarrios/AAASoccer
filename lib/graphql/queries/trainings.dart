
class TrainingQueries {
   String getTrainings()
   {
      String getTrainings = """
        query GetTrainings {
          allTrainings {
            data {      
              _id              
              event{
                  name        	
                  _id                  
              } 
            }
          }
        }
      """;

      return getTrainings;
   }

}