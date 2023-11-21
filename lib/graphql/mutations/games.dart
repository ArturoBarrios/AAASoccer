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
// chats: {
//                 create: [
//                   {
//                     name: "General",
//                     isPrivate: false,
//                     users: {
//                       connect: [
//                         "${userInput['_id']}"
//                       ]
//                     }


//                   }
//                 ]
//               }  
  String createGame(Map<String, dynamic> gameInput,
      Map<String, dynamic> eventInput, Map<String, dynamic> locationInput, Map<String, dynamic> userInput) {
    var teamAmount = eventInput.containsKey('teamPrice') ? eventInput['teamPrice'] : "0.00";
    String createGame = """
      mutation {
        createGame(input: {
          pickup: ${gameInput['pickup']}, 
          event: {
            
            
              name: "${eventInput['name']}",
              type: GAME,
              archived: false,
              amenities: "${eventInput['amenities']}",
              isMainEvent: ${eventInput['isMainEvent']},
              startTime: "${eventInput['startTime']}",
              endTime: "${eventInput['endTime']}",
              createdAt: "${eventInput['createdAt']}",
              capacity: ${eventInput['capacity']},
                           
              price: {
                
                  amount: "${eventInput['price']}",              
                }
              
              joinConditions: {
                
                  {
                    withRequest: ${eventInput['withRequest']},
                    withPayment: ${eventInput['withPayment']},
                    forEvent: true
                  }   
                  
                
              },
              userParticipants: {
                create:                  
                  userId: "${userInput['_id']}"                                                              
                  roles: "${eventInput['roles']}"                                                                                              
              },                    
              fieldLocations: {                            
                    isMainField: true,
                    location: {                     
                        name: "${locationInput['name']}",
                        address: "${locationInput['address']}",
                        latitude: ${locationInput['latitude']},
                        longitude: ${locationInput['longitude']}                     
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

  String archiveEvent(
      dynamic game) {
    String archiveEventString = """      
      mutation {
        updateEvent(id: ${game['_id']},
          data: {
            archived: true
               
          }  				                  
        ){
          ${EventFragments().fullEvent()}

    			  
  }
}
        """;

    return archiveEventString;
  }
}
