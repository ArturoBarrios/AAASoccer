
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
              organizers{
                data{
                  _id
                  name
                }
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
   String getTeamRequests()
   {
      String getTeamRequests = """
        query GetTeamRequests {
          allTeamRequests {
            data {      
              _id
              status
              requestAttempts
              organizers{
                data{
                  _id
                  email
                  name
                }
              }
              receivers{
                data{
                  _id
                  email
                  name
                }
              }             
              sender{
                _id
                email
                name
              }
              acceptedBy{
                _id
                email
                name
              }              
              team{
                name        	
                _id  
                teamUserOrganizers{                    
                  users{
                    data{
                      email
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

      return getTeamRequests;
   }

}