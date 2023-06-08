import 'package:soccermadeeasy/graphql/fragments/tournament_fragments.dart';

import '../fragments/event_fragments.dart';

class TournamentMutations {
  String createTournament(Map<String, dynamic> tournamentInput,
      Map<String, dynamic> eventInput, Map<String, dynamic> locationInput, 
      dynamic league) {
      String leagueConnect = league != null
      ? 'leagues: { connect: ${league['_id']} }'
      : '';
    
    String createTournament = """
      mutation {
        createTournament(data: {      
          numberOfTeams: ${tournamentInput['numberOfTeams']},   
          groupPlay: ${tournamentInput['groupPlay']},                    
          ${leagueConnect}
   
          events: {
            create: 
            {
              name: "${eventInput['name']}",
              isMainEvent: ${eventInput['isMainEvent']},
              type: TOURNAMENT,
              capacity: ${eventInput['capacity']},
              startTime: "${eventInput['startTime']}",
              endTime: "${eventInput['endTime']}",
              createdAt: "${eventInput['createdAt']}",

              joinConditions: {
                create: [
                  {
                    withRequest: ${eventInput['withRequest']},
                    withPayment: ${eventInput['withPayment']},
                    forEvent: true
                  },
                  {
                    withRequest: ${eventInput['withTeamRequest']},
                    withPayment: ${eventInput['withTeamPayment']},
                    forTeam: true
                  }

                ]
              },
              userParticipants: {
                create:
                  {
                    user: {
                      connect:                   
                          "${eventInput['user_id']}"    
                      }                                         
                      roles: "{ORGANIZER, PLAYER}"
                                       
                  }                                     
              },      
              location: {
                create: 
                {
                  name: "${locationInput['name']}",
                  latitude: ${locationInput['latitude']},
                  longitude: ${locationInput['longitude']},
                }
              }
            }
          } 
          }) {
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
        """;

    return createTournament;
  }

  String addEventToTournament(
      Map<String, dynamic> tournamentInput, Map<String, dynamic> eventInput) {
    String addGameToTournament = """      
      mutation {
        updateTournament(id: ${tournamentInput['_id']},
  				data: {            
            events:{
              connect:[
                ${eventInput['_id']}
              ]
              
            }
          }
                      
        ){
            _id    	
            numberOfTeams
            groupPlay			            
            events{
              data{
                _id
                location{
                  data{
                    _id
                    latitude
                    longitude
                  }
                }
              }
            }     				                                                      
          }
        }
        """;

    return addGameToTournament;
  }

  String addTeamToTeamOrder(Map<String, dynamic> teamOrderInput) {
    String addTeamToTeamOrderString = """      
     mutation {
  updateTeamOrder(id: ${teamOrderInput['_id']},
    data: {            
           
          team: {
            connect: ${teamOrderInput['team_id']}        
        }      
          points: ${teamOrderInput['points']}
    }                  
  ){
    ${TournamentFragments().teamOrderFragment()}
        			   				                                                      
  }
}

        """;

    return addTeamToTeamOrderString;
  }

  String removeTeamFromTeamOrder(Map<String, dynamic> teamOrderInput) {
    String removeTeamFromTeamOrderString = """      
     mutation {
  updateTeamOrder(id: ${teamOrderInput['_id']},
    data: {            
      team: {                          
        disconnect: true                               
      },      
    }                  
  ){
    ${TournamentFragments().teamOrderFragment()}
        			   				                                                      
  }
}

        """;

    return removeTeamFromTeamOrderString;
  }

  String addPlayerToGame(
      Map<String, dynamic> gameInput, Map<String, dynamic> playerInput) {
    String addPlayerToGame = """      
      mutation {
        updateGame(id: ${gameInput['_id']},
  				data: {            
            players:{
              connect:[
                ${playerInput['_id']}
              ]
              
            }
          }
                      
        ){
            _id
    				pickup            
            event{
              _id
              location{
                data{
                  _id
                  latitude
                  longitude
                }
              }
            } 
    				players{	
              data{
                  	_id
                    
              }
            }
            
                  
            
            
  }
}
        """;

    return addPlayerToGame;
  }

  String createGroup(Map<String, dynamic> groupInput) {
    String createGroup = """      
       mutation {
        createGroup(data: {      
          groupNumber: ${groupInput['groupNumber']},                               
          }) {
               ${TournamentFragments().groupFragment()}                                                         
          }   
        }
        """;

    return createGroup;
  }

  String createTeamOrder(Map<String, dynamic> teamOrderInput) {
    String createTeamOrderString = """      
       mutation {
        createTeamOrder(data: {               
          points: ${teamOrderInput['points']}
          group: {
            connect: "${teamOrderInput['group_id']}"            
          }
          }) {
               _id                                                             
          }   
        }
        """;

    return createTeamOrderString;
  }

  String createGroupStage(Map<String, dynamic> groupStageInput) {
    String createGroupStage = """      
       mutation {
        createGroupStage(data: {      
          numberOfTeams: ${groupStageInput['numberOfTeams']},             
          tournament: {
            connect: "${groupStageInput['tournament_id']}"            
          }
          groups: {            
              connect: [
                  ${groupStageInput['groups']}
                ]            
            }          
          }) {
            ${TournamentFragments().groupStageFragment()}
          }   
        }
        """;

    return createGroupStage;
  }

  String createTournamentStage(Map<String, dynamic> tournamentStageInput) {
    String createGroupStage = """   
   mutation {
    createTournamentStage(data: {      
      numberOfTeams: ${tournamentStageInput['numberOfTeams']},             
      numberOfRoundsPerTeam: ${tournamentStageInput['numberOfRoundsPerTeam']},             
      tournament: {
        connect: "${tournamentStageInput['tournament_id']}"            
      }
      }) {
        ${TournamentFragments().tournamentStageFragment()}
      }   
    }
    """;

    return createGroupStage;
  }

  String createEventOrder(Map<String, dynamic> eventOrdersInput) {
    String createEventOrderString = """
    mutation {
      createEventOrder(data: {
        order: ${eventOrdersInput['order']},
        event: {
          create: {
            name: "${eventOrdersInput['name']}",
          }
        },
        tournamentStage: {
          connect: ${eventOrdersInput['tournamentStage_id']},
        }
      }) {
        _id
        order
        event {
          _id
          name
        }
        tournamentStage {
          _id
        }
      }
    }
  """;

    return createEventOrderString;
  }
}
