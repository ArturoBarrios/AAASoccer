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
    String image = messageInput['image_url'] != null
        ? """
    imageObject: {
      create:{
        s3bucket: "${messageInput['s3bucket']}"
        key: "${messageInput['image_key']}"
        url: "${messageInput['image_url']}"
      }
    }
    messageType: IMAGE 
  """
        : "";

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
          $image
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

  String disconnectUser(Map<String, dynamic> chatInput) {
    String updateChatString = """
      mutation {
        updateChat(
        id: "${chatInput['chatId']}", 
        data: {
          users: {
            disconnect: ["${chatInput['userId']}"]
          }
        })
      {        
       ${ChatFragments().chatObject()}
      }  
    }
    """;

    return updateChatString;
  }

  String addUserToChat(Map<String, dynamic> chatInput) {
    String createChatString = """
      mutation {
        updateChat(
        id: "${chatInput['chatId']}", 
        data: {
          users: {
            connect: ["${chatInput['userId']}"]
          }
        })
      {        
       ${ChatFragments().chatObject()}
      }  
    }
    """;

    return createChatString;
  }
}
