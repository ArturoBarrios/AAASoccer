class EventRequestQueries {
  
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
 

  
}
