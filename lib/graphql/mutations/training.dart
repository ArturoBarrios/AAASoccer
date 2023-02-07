class TrainingMutations{
  String createTraining(Map<String, dynamic> trainingInput, Map<String, dynamic> eventInput ,Map<String, dynamic> locationInput, Map<String, dynamic> userInput) {
    String createTraining = """
      mutation {
        createTraining(data: {                    
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

    return createTraining;
  }

  String addPlayerToTraining(
      Map<String, dynamic> trainingInput, Map<String, dynamic> playerInput) {
    String addPlayerToTraining = """      
      mutation {
        updateTraining(id: ${trainingInput['_id']},
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

    return addPlayerToTraining;
  }
}