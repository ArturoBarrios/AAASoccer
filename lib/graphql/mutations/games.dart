class GameMutations{
  String createGame(Map<String, dynamic> gameInput, Map<String, dynamic> eventInput ,Map<String, dynamic> locationInput) {
    String createGame = """
      mutation {
        createGame(data: {
          pickup: ${gameInput['pickup']},                     
          event: {
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
            pickup            
            event{
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
        """;

    return createGame;
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