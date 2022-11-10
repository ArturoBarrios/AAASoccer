class LeagueMutations{
  String createLeague(Map<String, dynamic> leagueInput, Map<String, dynamic> eventInput ,Map<String, dynamic> locationInput) {
    String createLeague = """
      mutation {
        createLeague(data: {                             
          events: {
            create: 
            {
              name: "${eventInput['name']}",
              isMainEvent: ${eventInput ['isMainEvent']},
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
            events{
              data{
              _id
              name
              isMainEvent
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