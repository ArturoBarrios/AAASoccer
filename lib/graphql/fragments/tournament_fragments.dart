import 'package:soccermadeeasy/graphql/fragments/league_fragments.dart';
import 'package:soccermadeeasy/graphql/fragments/team_fragments.dart';
import 'package:soccermadeeasy/graphql/fragments/league_fragments.dart';

class TournamentFragments {
  
  String tournamentFragment() {
    String tournamentFragmentString = """
      _id              
      numberOfTeams
      groupPlay
      leagues{
        data{
          ${LeagueFragments().leagueFragment()}

        }
      }
      tournamentStage{        
          ${tournamentStageFragment()}        
      }         
    """;

    return tournamentFragmentString;
  }

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

  String teamOrderFragment() {
    String teamOrderFragmentString = """      
        _id
        points                
        team{                
            _id     
            name           
        }    
        group{
          _id
        }            
      
    """;

    return teamOrderFragmentString;
  }

  String groupFragment() {
    String groupFragmentString = """
      _id                                                                        
      groupNumber
      teamOrders{
        data{
         ${TournamentFragments().teamOrderFragment()}

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
                  teams{
                    data{
                      _id
                      name
                    }
                  }
                }
              }
            }
            
    """;

    return tournamentStageFragmentString;
  }
}
