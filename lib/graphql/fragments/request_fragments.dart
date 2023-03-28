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
                name
              }
            }
            sender{                            
              _id
              email
              name              
            }   
            acceptedBy{              
                _id
                email
                name              
            }                                  
            event{              
                _id
                name              
            }                				                          
    ''';

    return fullRequestReturn;
  }
}
