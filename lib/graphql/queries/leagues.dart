import '../fragments/event_fragments.dart';
import '../fragments/league_fragments.dart';

class LeagueQueries {
   String getLeagues()
   {
      String getLeagues = """
        query GetLeagues {
          allLeagues {
            data {      
              ${LeagueFragments().leagueFragment()}
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
             ${LeagueFragments().leagueFragment()}
          }
        }
    """;
  
    return getLeague;
  }

}