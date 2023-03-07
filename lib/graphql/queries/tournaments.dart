import '../fragments/event_fragments.dart';

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
                 ${EventFragments().fullEvent()}
                }                  
              } 
            }
          }
        }
      """;

      return getTournaments;
   }

}