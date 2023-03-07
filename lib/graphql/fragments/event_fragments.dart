class EventFragments{

  String fullEvent(){
     String fullEventReturn = r'''
       name        	
                  _id  
                  type                  
                  archived
                  isMainEvent
                  deleted    
                  price{                    
                    _id
                    amount
                    event{
                      _id
                      name                      
                    }
                  }
                  location{
                    data{
                    _id
                    latitude
                    longitude
                    }
                  }
                  userParticipants{     
                    data{
                      _id
                      event{                        
                        _id
                        name
                      }
                      user{
                        _id
                        name
                        userType
                      }
                    }                                        
                                 
                  }
    ''';

    return fullEventReturn;

  }
}