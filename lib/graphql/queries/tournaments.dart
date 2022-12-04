
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
                  }                  
              } 
            }
          }
        }
      """;

      return getTournaments;
   }

}