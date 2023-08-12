class ChatFragments {
  String chatObject() {
    String chatObject = r'''      
        	_id
          name
          isPrivate
          mainImageKey
          users{
            data{
              _id
              name
            }
          }   
          event{
            _id
            name            
          }
          team{
            _id
            name
          }
          messages{
            data{
               _id
              messageType
              textObject{
                _id
                content
              }
              imageObject{
                _id
                url
              }
              sender{
                _id
                name
              }    
            }                                               
          }       
        
    ''';

    return chatObject;
  }
}
