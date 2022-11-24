class TeamMutations {
  String createTeam(Map<String, dynamic> teamInput, Map<String, dynamic> locationInput) {
    String createTeam = """
      mutation {
        createTeam(data: {
          name: "${teamInput['name']}",
          color: "${teamInput['color']}",
          location: {
            create: 
            {
              latitude: ${locationInput['latitude']},
              longitude: ${locationInput ['longitude']},
            }
          } 
          }) {
            _id
            name
            color
            location{
              _id
              latitude
              longitude
            }      
          }   
        }
        """;

    return createTeam;
  }

  String sendTeamRequest(
      Map<String, dynamic> senderInput, Map<String, dynamic> teamInput) {
      String createTeamRequest = """
      mutation {
        CreateFriendRequest(data: {    
          requestAttempts: 1, 
          team: {
            connect: 
            {
              _id: "${teamInput['_id']}"
            }
          },  
          from: {
            connect: 
            {
              _id: "${senderInput['_id']}"
            }
          }                       
          }) {
            _id
            status
            requestAttempts
            team{
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

    return createTeamRequest;
    }
}
