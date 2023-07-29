import '../fragments/event_fragments.dart';

class LeagueMutations{
  String createLeague(Map<String, dynamic> leagueInput, Map<String, dynamic> eventInput ,Map<String, dynamic> locationInput) {
    var teamAmount = eventInput.containsKey('teamPrice') ? eventInput['teamPrice'] : "0.00";
    String createLeague = """
      mutation {
        createLeague(data: {      
          numberOfTeams: ${leagueInput['numberOfTeams']},                       
          events: {
            create: 
            {
              name: "${eventInput['name']}",
              isMainEvent: ${eventInput ['isMainEvent']},
              capacity: ${eventInput['capacity']},
              startTime: "${eventInput['startTime']}",
              endTime: "${eventInput['endTime']}",
              createdAt: "${eventInput['createdAt']}", 
              type: LEAGUE,    
               price: {
                create: {
                  amount: "${eventInput['price']}",
                  teamAmount: "$teamAmount",                  
                }
              },         
              joinConditions: {
                create: [
                  {
                    withRequest: ${eventInput['withRequest']},
                    withPayment: ${eventInput['withPayment']},
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
                  longitude: ${locationInput ['longitude']},
                }
              }
            }
          } 
          }) {                         
           _id    
            numberOfTeams                  
            events{
              data{
                 ${EventFragments().fullEvent()}
              }
            } 
          }   
        }
        """;

    return createLeague;
  }

  String addEventToLeague(
      Map<String, dynamic> leagueInput, Map<String, dynamic> eventInput) {
         String addGameToLeague = """      
      mutation {
        updateLeague(id: ${leagueInput['_id']},
  				data: {            
            events:{
              connect:[
                ${eventInput['_id']}
              ]
              
            }
          }
                      
        ){
            _id    				            
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

return addGameToLeague;

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


  
}