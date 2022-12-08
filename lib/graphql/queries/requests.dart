
class RequestsQueries {
   String getEventRequests()
   {
      String getEventRequests = """
        query GetEventRequests {
          allEventRequests {
            data {      
              _id
              status
              requestAttempts
              organizerWhoAcceptedOrSentRequest{
                _id
                name
              }
              sender{
                _id
                name
              }
              acceptedBy{
                _id
                name
              }
              event{
                name        	
                _id  
                eventUserOrganizers{                    
                  users{
                    data{
                      _id
                      name
                    }
                  }                          
                }
              }                         
            }
          }
        }
      """;

      return getEventRequests;
   }

}