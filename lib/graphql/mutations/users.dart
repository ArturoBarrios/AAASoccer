

class UserMutations {
  String sendFriendRequest(
      Map<String, dynamic> userInput, Map<String, dynamic> friendInput) {
      String sendFriendRequestString = """
      mutation {
        CreateFriendRequest(data: {    
          requestAttempts: 1, 
          to: {
            connect: 
            {
              _id: "${friendInput['_id']}"
            }
          },  
          from: {
            connect: 
            {
              _id: "${userInput['_id']}"
            }
          }                       
          }) {
            _id
            status
            requestAttempts
            to{
              data{
                _id
                name
              }
            }   
            from{
              data{
                _id
                name
              }
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


    String acceptFriendRequest(
      Map<String, dynamic> friendRequestInput) {
    String acceptFriendRequestString = """      
      mutation {
        UpdateFriendRequest(id: ${friendRequestInput['_id']},
  				data: {            
            status:           
                ${friendRequestInput['status']}                          
          }                      
        ){
            _id
            status
            requestAttempts
            to{
              data{
                _id
                name
              }
            }   
            from{
              data{
                _id
                name
              }
            }                        
            
    			
  }
}
        """;

    return acceptFriendRequestString;
  }

}

