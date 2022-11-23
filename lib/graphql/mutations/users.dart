

class UserMutations {
  String sendFriendRequest(
        Map<String, dynamic> userInput, Map<String, dynamic> friendInput) {
      String updatePlayerWithTeam = """      
        mutation {
          updateUser(id: "${userInput['_id']}",
            data: {
              friends:{
                connect:[
                  "${friendInput['_id']}"
                ]
                
              }
            }
                        
          ){
                _id
                name,
                phone
                location{
                  _id
                  latitude
                  longitude
                } 
              
    }
  }
          """;

      return updatePlayerWithTeam;
    }

}

