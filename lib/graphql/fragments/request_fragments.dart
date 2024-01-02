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
              name        
            }
            sender{                            
              _id
              email
              name    
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
