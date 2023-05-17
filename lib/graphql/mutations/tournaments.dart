import '../fragments/event_fragments.dart';

class TournamentMutations{
  String createTournament(Map<String, dynamic> tournamentInput, Map<String, dynamic> eventInput ,Map<String, dynamic> locationInput) {
    String createTournament = """
      mutation {
        createTournament(data: {      
          numberOfTeams: ${tournamentInput['numberOfTeams']},   
          groupPlay: ${tournamentInput['groupPlay']},                    
          events: {
            create: 
            {
              name: "${eventInput['name']}",
              isMainEvent: ${eventInput ['isMainEvent']},
              type: TOURNAMENT,
              startTime: "${eventInput['startTime']}",
              endTime: "${eventInput['endTime']}",
              createdAt: "${eventInput['createdAt']}",

              joinConditions: {
                create: {
                  withRequest: ${eventInput['withRequest']},
                  withPayment: ${eventInput['withPayment']},
                }
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
                  latitude: ${locationInput['latitude']},
                  longitude: ${locationInput ['longitude']},
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


  
  String createGroup(
      Map<String, dynamic> groupInput) {
    String createGroup = """      
       mutation {
        createGroup(data: {      
          groupNumber: ${groupInput['groupNumber']},             
          
          }) {
            _id                                                    
          }   
        }
        """;

    return createGroup;
  }

  String createGroupStage(
      Map<String, dynamic> groupStageInput) {
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
            _id    
            numberOfTeams                                    
            groups{
              data{
                 groupNumber
                 teams{
                    data{
                      _id
                    }
                 }
              }
            } 
          }   
        }
        """;

    return createGroupStage;
  }
}