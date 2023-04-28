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

   String findTournamentByID(String tournamentId ){
    String getTournament = """
      query getTournament {
            findTournamentByID(id: $tournamentId) {  
              _id                        
              numberOfTeams
              groupPlay  
              events{
                data{
                  ${EventFragments().eventGameFragment()}                                                                                   
                }
              }
          }
        }
    """;
  
    return getTournament;
  }

}