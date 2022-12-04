
class LeagueQueries {
   String getLeagues()
   {
      String getLeagues = """
        query GetLeagues {
          allLeagues {
            data {      
              _id              
              numberOfTeams              
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

      return getLeagues;
   }

}