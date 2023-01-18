
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
                location{
                  data{
                    _id
                    latitude
                    longitude
                  }
                } 
              } 
            }
          }
        }
      """;

      return getTrainings;
   }

}