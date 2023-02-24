import '../fragments/user_fragments.dart';

class ChatMutations {
  String createChat(Map<String, dynamic> chatInput) {
    String createChatString = """
     mutation {
      createChat(
        data: {
          name: "${chatInput['name']}"
          users: {
            connect:[
              ${chatInput['user_id']}
              
            ]
          }
        }
    )
      {
        _id
        users{
          data{
            ${ UserFragments().fullUser() }                                  			
          }
        }
      }
      
    }
    """;

    return createChatString;
  }
  
  String deleteChat(Map<String, dynamic> chatInput) {
    String createChatString = """
      mutation {
      deleteChat(id: ${chatInput['_id']})
      {
        _id        
      }  
    }
    """;

    return createChatString;
  }
  
  String updateChat(Map<String, dynamic> chatInput) {
    String updateChatString = """
      mutation {
        partialUpdateChat(id: ${chatInput['_id']}, 
        data:{
         ${chatInput['chatData']}
        })
        {
          _id
          users{
            data{
              _id
              email
              name
            }
          }
        }  
      }
    """;

    return updateChatString;
  }
}
