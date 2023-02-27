class ChatFragments{

  String chatObject(){
     String chatObject = r'''      
        	_id
          name
          users{
            data{
              _id
              name
            }
          }   
          messages{
            data{
               _id
              messageType
              textObject{
                _id
                content
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








