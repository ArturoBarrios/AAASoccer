import 'package:soccermadeeasy/graphql/fragments/team_fragments.dart';
import 'package:soccermadeeasy/graphql/fragments/chat_fragments.dart';

class TournamentFragments {
  String groupStageFragment() {
    String groupStageFragmentString = """
       _id    
            numberOfTeams                                                  
            groups{
              data{
                ${groupFragment()}
              }
            }
    """;

    return groupStageFragmentString;
  }

  String groupFragment() {
    String groupFragmentString = """
      _id                                                                        
      groupNumber
    teamOrders{
      data{
        points                
        team{                
            _id                
        }                
      }
    } 
    groupStage{
      _id
    }

              
    """;

    return groupFragmentString;
  }

  String tournamentStageFragment() {
    String tournamentStageFragmentString = """
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
            
    """;

    return tournamentStageFragmentString;
  }
}
