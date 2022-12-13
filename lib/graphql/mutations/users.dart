

class UserMutations {
  String sendFriendRequest(
      Map<String, dynamic> userInput, Map<String, dynamic> friendInput) {
      String sendFriendRequestString = """
      mutation {
        createFriendRequest(data: {    
          requestAttempts: 1, 
          status: PENDING,
          sender: {
            connect: "${userInput['_id']}"
          },  
          receiver: {
            connect: "${friendInput['_id']}"
            
          }                       
          }) {
            _id
            status
            requestAttempts
            sender{
              _id
              email
              name              
            }   
            receiver{              
              _id
              email
              name              
            }            
          }   
        }
        """;

    return sendFriendRequestString;
    } 

    String addFriend(
      Map<String, dynamic> userInput, Map<String, dynamic> friendInput) {
    String addFriendString = """      
      mutation {
        updateUser(id: ${userInput['_id']},
  				data: {            
            friends:              
              ${friendInput['_id']}                                                                                 
          }                      
        ){
        _id
        name
        email
        friends{          
            _id
            name
            email          
        }                                        			
  }
}
        """;

    return addFriendString;
  }
    
    String addTeam(
      Map<String, dynamic> userInput, Map<String, dynamic> teamInput) {
    String addTeamString = """      
      mutation {
        updateUser(id: ${userInput['_id']},
  				data: {            
            teams: {
              connect: [
                ${teamInput['_id']}                                                                                 
              ]
            }             
          }                      
        ){
        _id
        name
        email
        teams{      
          data{    
            _id
            name       
            teamUserOrganizers{
              users{
                data{
                  _id
                  name
                  email
                }
              }
            }             
          }
        }                                        			
  }
}
        """;

    return addTeamString;
  }



    String createTo(Map<String, dynamic> userInput) {
      String createTo = """
        mutation {
          createTo(data: {                    
            user: {
              connect: ${userInput['_id']}                                    
            }
            }) {
              _id
              user{
                _id
                name           
              }   
            }
          }
        """;

      return createTo;
  }


    String updateFriendRequest(
      Map<String, dynamic> friendRequestInput) {
    String updateFriendRequestString = """      
      mutation {
        updateFriendRequest(id: ${friendRequestInput['_id']},
  				data: {            
            status: ACCEPTED,                                                
          }                      
        ){
            _id
            status
            requestAttempts
            sender{              
              _id
              name              
            }   
            receiver{              
              _id
              name              
            }                        
            
    			
  }
}
        """;

    return updateFriendRequestString;
  }

}

