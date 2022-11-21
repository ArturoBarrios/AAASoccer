class TeamQueries {
  String getTeam(String id)
   {
      String getTeam = """
        query getTeam {
          findPlayer(id: $id) {
            data {      
              _id              
              user{
                  name        	
                  phone
                  email
                  username
                  birthdate
                  gender
                  location                                    
              } 
            }
          }
        }
      """;

      return getTeam;
   }

    String getTeams()
    {
        String getTeams = """
          query getTeams {
            allTeams {
              data {      
                _id 
                name                             
                players{
                  data{
                    _id
                    }
                    }
                  }
                }
              }
          """;

          return getTeams;

    }

  
}
