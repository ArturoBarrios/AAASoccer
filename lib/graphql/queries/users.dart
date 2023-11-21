import '../fragments/user_fragments.dart';

class UserQueries {
  String checkUserUniqueness(Map<String, dynamic> userInput) {
    String updateUserString = """
      query getUser{
        getUserByEmail(email: "${userInput['email']}") {
          _id
        }
        getUserByUsername(username: "${userInput['username']}") {
          _id
        }
        getUserByPhone(phone: "${userInput['phone']}") {
          _id
        }
      }
        """;

    return updateUserString;
  }

  // String getUserByEmail(Map<String, dynamic> userInput) {
  //   String getUser = """
  //     query getUser {
  //         getUserByEmail(email: "${userInput['email']}") {      
  //             ${UserFragments().fullUser()}           
                                               
              
            
  //         }
  //       }
  //   """;

  //   return getUser;
  // }
String getUserByEmail(Map<String, dynamic> userInput) {
    String getUser = """
      query FindUserByEmail {
      findUserByEmail(email: "${userInput['email']}") {
        user{
          username
        }
        code
        message
        success

      }
    }
    """;

  return getUser;
}

  String findUserByID(Map<String, dynamic> userInput, String userFragment) {
    String getUser = """
      query getUser {
            findUserByID(id: "${userInput['_id']}") {      
             ${userFragment}                                                                                    
          }
        }
    """;

    return getUser;
  }

  String findUserPlayerByID(Map<String, dynamic> userInput) {
    String getUser = """
      query getUser {
            findUserByID(id: "${userInput['_id']}") {      
             ${UserFragments().fullUser()}                                                                                    
          }
        }
    """;

    return getUser;
  }

  String removeEventFromUser(
      Map<String, dynamic> eventInput, Map<String, dynamic> userInput) {
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
