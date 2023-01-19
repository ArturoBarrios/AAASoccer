
class TournamentQueries {
   String getTournaments()
   {
      String getTournaments = """
        query GetTournaments {
          allTournaments {
            data {      
              _id              
              numberOfTeams
              groupPlay
              events{
                data{                  
                  name        	
                  _id
                  isMainEvent
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
        }
      """;

      return getTournaments;
   }

}