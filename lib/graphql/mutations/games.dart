import '../fragments/event_fragments.dart';

class GameMutations {  
  String partiallyUpdateGameEvent(Map<String, dynamic> gameEventInput) {
    String updateGame = """
      mutation {
        partialUpdateEvent(id: "${gameEventInput['event']['_id']}" ,
          data:  {             
            ${gameEventInput['event']['data']}    
            }
          ) {
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
      partialUpdateGame(id: "${gameEventInput['game']['_id']}" ,
          data: {              
            ${gameEventInput['game']['data']}            
          }) {
    					_id
    					homegoals
  }
        }
        """;

    return updateGame;
  }

  String createGame(Map<String, dynamic> gameInput,
      Map<String, dynamic> eventInput, Map<String, dynamic> locationInput, Map<String, dynamic> userInput) {
    String createGame = """
      mutation {
        createGame(data: {
          pickup: ${gameInput['pickup']}, 
          event: {
            create: 
            {
              name: "${eventInput['name']}",
              type: GAME,
              archived: false,
              isMainEvent: ${eventInput['isMainEvent']},
              startTime: "${eventInput['startTime']}",
              endTime: "${eventInput['endTime']}",
              createdAt: "${eventInput['createdAt']}",
              capacity: ${eventInput['capacity']},
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
                          "${userInput['_id']}"    
                      }                                         
                      roles: "${eventInput['roles']}"
                                       
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
              pickup
              event{
                   ${EventFragments().fullEvent()}
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

  String archiveEventGame(
      String event_id) {
    String archiveEventString = """      
      mutation {
        updateEvent(id: ${event_id},
          data: {
            archived: true
               
          }
  				                  
        ){
            _id   
            name
            archived
            isMainEvent 				
            location{
                data{
                  _id
                  latitude
                  longitude
                }
              } 
              games{   
                data{
                  _id
                  pickup
                }
              }                       
    			  
  }
}
        """;

    return archiveEventString;
  }
}
