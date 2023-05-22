import '../fragments/event_fragments.dart';
import '../fragments/tournament_fragments.dart';

class TournamentQueries {
  String getTournaments() {
    String getTournaments = """
        query GetTournaments {
          allTournaments {
            data {      
              _id              
              numberOfTeams
              groupPlay
              tournamentStage{
                _id    
                numberOfTeams                                    
                numberOfRoundsPerTeam                                    
                tournament{
                  _id
                }
                eventOrders{
                  data{
                    _id
                    order                  
                    event{
                      _id
                    }
                  }
                }
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
              _id                        
              numberOfTeams
              groupPlay  
              tournamentStage{
                _id    
                numberOfTeams                                    
                numberOfRoundsPerTeam                                    
                tournament{
                  _id
                }
                eventOrders{
                  data{
                    _id
                    order                  
                    event{
                      _id
                    }
                  }
                }
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
    """;

    return getTournament;
  }
}
