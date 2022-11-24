

class UserMutations {
  String sendFriendRequest(
      Map<String, dynamic> userInput, Map<String, dynamic> friendInput) {
      String createFriendRequest = """
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

    return createFriendRequest;
    }

}

