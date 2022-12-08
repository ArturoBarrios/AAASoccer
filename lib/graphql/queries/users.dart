class UserQueries {
  String getUser(String email){
    String getUser = """
      query getUser {
          getUser(email: "${email}") {      
              _id      
              name        	
              phone
              email
              username
              birthdate
              gender
              eventRequestsToAccept{
                data{
                  _id
                  status
                  requestAttempts
                  event{
                    _id
                    name
                  }
                }
              }            
                                               
              
            
          }
        }
    """;
  
    return getUser;
  }
 

  
}
