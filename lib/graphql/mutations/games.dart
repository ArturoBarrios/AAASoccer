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
    var teamAmount = eventInput.containsKey('teamPrice') ? eventInput['teamPrice'] : "0.00";
    String createGame = """
      mutation {
        createGame(
          pickup: ${gameInput['pickup']})  {
            code
        success
        message
        game {
          
          pickup
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
