import '../fragments/event_fragments.dart';
import '../fragments/tournament_fragments.dart';

class TournamentQueries {
  String getTournaments() {
    String getTournaments = """
        query GetTournaments {
          allTournaments {
            data {      
              ${TournamentFragments().tournamentFragment()}
            }              
              groupStage{
                ${TournamentFragments().groupStageFragment()}
              }
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

  String findTournamentByID(String tournamentId) {
    String getTournament = """
      query getTournament {
            findTournamentByID(id: $tournamentId) {  
             ${TournamentFragments().tournamentFragment()} 
              groupStage{
                ${TournamentFragments().groupStageFragment()}
              }
              events{
                data{
                  ${EventFragments().fullEvent()}                                                                                   
                }
              }
          }
        }
    """;

    return getTournament;
  }
}
