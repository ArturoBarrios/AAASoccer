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
                                               
              
            
          }
        }
    """;
  
    return getUser;
  }
 

  
}
