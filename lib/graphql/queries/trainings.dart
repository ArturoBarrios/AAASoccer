
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
                  type                  
                  archived
                  isMainEvent
                  deleted    
                  price{                    
                    _id
                    amount
                    event{
                      _id
                      name                      
                    }
                  }
                  location{
                    data{
                    _id
                    latitude
                    longitude
                    }
                  }
                  eventUserOrganizers{                    
                      users{
                        data{
                          _id
                          name
                        }
                      }    
                      event{                        
                          _id
                          name  
                          archived
                          deleted                      
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