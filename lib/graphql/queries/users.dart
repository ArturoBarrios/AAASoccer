import '../fragments/user_fragments.dart';

class UserQueries {
String getUserByEmail(Map<String, dynamic> userInput) {
    String getUser = """
      query FindUserByEmail {
      findUserByEmail(email: "${userInput['email']}") {
        user{
          ${UserFragments().fullUser()}
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
      query FindUserById {
      findUserById(_id: "${userInput['_id']}") {
        user{
          ${userFragment}
        }
        code
        message
        success

      }
    }


    """;
      // query getUser {
      //       findUserByID(id: "${userInput['_id']}") {      
      //        ${userFragment}                                                                                    
      //     }
      //   }

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
