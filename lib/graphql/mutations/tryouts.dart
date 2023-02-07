class TryoutMutations{
  String createTryout(Map<String, dynamic> tryoutInput, Map<String, dynamic> eventInput ,Map<String, dynamic> locationInput, Map<String, dynamic> userInput) {
    String createTryout = """
      mutation {
        createTryout(data: {                    
          event: {
            create: 
            {
              name: "${eventInput['name']}",
              type: TRAINING,
              archived: false,
              isMainEvent:true,
              eventUserOrganizers: {
                create:
                  {
                    users: {
                      connect:[                        
                          "${userInput['_id']}"                   
                      ]
                    }                    
                  }                                     
              },                    
              location: {
                create: 
                {
                  latitude: ${locationInput['latitude']},
                  longitude: ${locationInput['longitude']},
                }
              }
            }
          }
        }) {
            _id                       
           event{
                  name        	
                  _id  
                  type                  
                  archived
                  deleted    
                  price{                    
                    _id
                    amount
                    event{
                      _id
                      name                      
                    }
                  }
                  location{
                    data{
                    _id
                    latitude
                    longitude
                    }
                  }
                  eventUserOrganizers{                    
                      users{
                        data{
                          _id
                          name
                        }
                      }    
                      event{                        
                          _id
                          name  
                          archived
                          deleted                      
                      }                
                    }
                }
          }   
        }
        """;

    return createTryout;
  }

  String addPlayerToTryout(
      Map<String, dynamic> tryoutInput, Map<String, dynamic> playerInput) {
    String addPlayerToTryout = """      
      mutation {
        updateTryout(id: ${tryoutInput['_id']},
  				data: {            
            players:{
              connect:[
                ${playerInput['_id']}
              ]
              
            }
          }
                      
        ){
            _id    				        
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

    return addPlayerToTryout;
  }
}