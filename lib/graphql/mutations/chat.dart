import '../fragments/user_fragments.dart';
import '../fragments/chat_fragments.dart';

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
  
  String createTextMessage(Map<String, dynamic> messageInput) {
    String createTextMessageString = """
     mutation {
      createMessage(
        data: {
          chatObject:{
            connect: ${messageInput['chat_id']}
          }
          textObject: {
            create:{
              content: "${messageInput['content']}"
            }
          }
          sender: {
            connect: ${messageInput['sender_id']}
          }
        }
    )
      {
        _id
        messageType
        ${ChatFragments().chatObject()}
        
        
        }
      }
    """;

    return createTextMessageString;
  }
  
  String deleteChat(Map<String, dynamic> chatInput) {
    String createChatString = """
      mutation {
      deleteChat(id: ${chatInput['_id']})
      {        
        ${ChatFragments().chatObject()}      
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
          ${ChatFragments().chatObject()}
        }  
      }
    """;

    return updateChatString;
  }
}
