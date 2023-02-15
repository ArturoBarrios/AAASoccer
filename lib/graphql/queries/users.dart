import '../user_fragments.dart';

class UserQueries {
  String getUserByEmail(Map<String, dynamic> userInput ){
    String getUser = """
      query getUser {
          getUser(email: "${userInput['email']}") {      
              ${UserFragments().fullUser()}           
                                               
              
            
          }
        }
    """;
  
    return getUser;
  }
  
  String findUserByID(Map<String, dynamic> userInput ){
    String getUser = """
      query getUser {
            findUserByID(id: "${userInput['user_id']}") {      
             ${UserFragments().fullUser()}                                                                                    
          }
        }
    """;
  
    return getUser;
  }

 String removeEventFromUser(
      Map<String, dynamic> eventInput, Map<String, dynamic> userInput ) {
    String addPlayerToEvent = """      
      mutation {
        updateUser(id: ${userInput['_id']}, data: {          
          events: {
            disconnect: ${eventInput['_id']}
          }
        }) {
          ${UserFragments().fullUser()}        
        }
      }
        """;

    return addPlayerToEvent;
  }
  
 

  
}
