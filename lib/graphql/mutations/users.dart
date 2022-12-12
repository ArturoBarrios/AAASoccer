

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

