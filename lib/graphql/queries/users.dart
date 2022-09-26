class UserQueries {
  String getUser(String email){
    String getUser = """
      query getUser {
          getUser(email: $email) {
            data {                
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
    """;
  
    return getUser;
  }
 

  
}
