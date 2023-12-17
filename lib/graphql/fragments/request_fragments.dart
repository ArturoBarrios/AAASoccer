class RequestFragments {
  String fullRequest() {
    String fullRequestReturn = r'''
       _id
            status
            requestAttempts   
            type     
            forRole    
            receivers{              
              _id
              email
              username              
            }
            sender{                            
              _id
              email
              username    
              phone          
            }   
            acceptedBy{              
              _id
              email
              name              
            }                                  
            event{              
              _id
              name  
              games{                  
                _id                                     
              }            
            }                                  
    ''';

    return fullRequestReturn;
  }
}
