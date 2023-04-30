import '../fragments/event_fragments.dart';

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
                  ${EventFragments().fullEvent()}
                }                  
              } 
            }
          }
        }
      """;

      return getLeagues;
   }

   String findLeagueByID(String leagueId ){
    String getLeague = """
      query getLeague {
            findLeagueByID(id: $leagueId) {  
              _id                        
              numberOfTeams
              events{
                data{
                  ${EventFragments().fullEvent()}                                                                                   
                }
              }
          }
        }
    """;
  
    return getLeague;
  }

}