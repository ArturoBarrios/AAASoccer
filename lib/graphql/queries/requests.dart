import '../fragments/request_fragments.dart';

class RequestsQueries {
   String getEventRequests()
   {
      String getEventRequests = """
        query GetRequests {
          allRequests {
            data {      
              ${RequestFragments().fullRequest()}   
            }
          }
        }
      """;

      return getEventRequests;
   }
   
   String getTeamRequests()
   {
      String getTeamRequests = """
        query GetTeamRequests {
          allTeamRequests {
            data {      
              _id
              status
              requestAttempts
              requestType
              organizers{
                data{
                  _id
                  email
                  name
                }
              }
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
              team{
                name        	
                _id  
                teamUserOrganizers{                    
                  users{
                    data{
                      email
                      _id
                      name
                    }
                  }                          
                }
              }                         
            }
          }
        }
      """;

      return getTeamRequests;
   }
   
   String getFriendRequests()
   {
      String getFriendRequests = """
        query GetFriendRequests {
          allFriendRequests {
            data {      
              _id
              status
              requestAttempts       
              requestType       
              receiver{                
                _id
                email
                name 
                OSPID               
              }             
              sender{
                _id
                email
                name
                OSPID
              }                                                  
            }
          }
        }
      """;

      return getFriendRequests;
   }

   String findEventRequest(Map<String, dynamic> eventRequestInput ){
    print("findEventRequest() query called: ${eventRequestInput['_id']}");
    String findEventRequest = """
      query findEventRequest {
            findEventRequestByID(id: ${eventRequestInput['_id']}) {      
              _id      
             organizers{
              data{
              _id
              OSPID
              email
              name
            	phone  
              }            	
            }  
             sender{
                _id
                OSPID
                email
                name
                phone
             }
					}
          }
    """;
  
    return findEventRequest;
  }

  String findTeamRequest(Map<String, dynamic> teamRequestInput ){
    print("findTeamRequest() query called: ${teamRequestInput['_id']}");
    String findTeamRequest = """
      query findTeamRequest {
            findTeamRequestByID(id: ${teamRequestInput['_id']}) {      
              _id      
             organizers{
              data{
              _id
              OSPID
              email
              name
            	phone  
              }            	
            }  
             sender{
                _id
                OSPID
                email
                name
                phone
             }
					}
          }
    """;
  
    return findTeamRequest;
  }
  
   String findFriendRequest(Map<String, dynamic> friendRequestInput ){
    print("findFriendRequest() query called: ${friendRequestInput['_id']}");
    String findFriendRequest = """
      query findFriendRequest {
            findFriendRequestByID(id: ${friendRequestInput['_id']}) {      
              _id      
             receiver{              
              _id
              OSPID
              email
              name
            	phone  
                         	
            }  
             sender{
                _id
                OSPID
                email
                name
                phone
             }
					}
          }
    """;
  
    return findFriendRequest;
  }

}