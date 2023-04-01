class RequestFragments {
  String fullRequest() {
    String fullRequestReturn = r'''
       _id
            status
            requestAttempts   
            type         
            receivers{
              data{
                _id
                email
                username
              }
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
                  data{
                    _id                   
                  }
                }            
              }
            team{
              _id
              name
            }                				                          
    ''';

    return fullRequestReturn;
  }
}
