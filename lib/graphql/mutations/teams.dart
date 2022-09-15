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
}
