import '../fragments/user_fragments.dart';
import '../fragments/chat_fragments.dart';

class ChatMutations {
  String createChat(
      Map<String, dynamic> chatInput, dynamic objectsToAttachInput) {
    String teamConnect = objectsToAttachInput['teamId'] != null
        ? 'team: { connect: "${objectsToAttachInput['teamId']}" }'
        : '';
    String eventConnect = objectsToAttachInput['eventId'] != null
        ? 'event: { connect: "${objectsToAttachInput['eventId']}" }'
        : '';

    String createChatString = """
     mutation {
      createChat(
        data: {
          name: "${chatInput['name']}",
          isPrivate: ${chatInput['isPrivate']},
          users: {
            connect:[
             ${objectsToAttachInput['playersIds']}
              
            ]
          }
          
          $eventConnect
          $teamConnect        
        }
    )
      {
       ${ChatFragments().chatObject()}
      }
      
    }
    """;

    return createChatString;
  }

  String updateChatImage(Map<String, dynamic> chatInput) {
    String updateUserString = """      
      mutation {
        updateChat(id: ${chatInput['_id']},
  				data: {            
            mainImageKey: "${chatInput['mainImageKey']}"                                                                                
          }                      
        ){
          ${ChatFragments().chatObject()}                              			
  }
}
        """;

    return updateUserString;
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
        chatObject{
          ${ChatFragments().chatObject()}
        }
        
        
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
