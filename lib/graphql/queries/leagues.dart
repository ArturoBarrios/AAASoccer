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

}