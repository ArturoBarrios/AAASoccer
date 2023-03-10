import '../fragments/chat_fragments.dart';

class ChatQueries {
   String findChatByID(Map<String, dynamic> chatInput)
   {
      String findChatByIDResp = """
        query findChatByID {
            findChatByID(id: "${chatInput['_id']}") {      
             ${ChatFragments().chatObject()}                                                                                    
          }
        }
      """;

      return findChatByIDResp;
   }

}