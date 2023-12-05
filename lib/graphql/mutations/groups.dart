import '../fragments/group_fragments.dart';

class GroupMutations {
  String createGroup(
      Map<String, dynamic> groupInput, Map<String, dynamic> locationInput) {
    print("groupInput: $groupInput");
    print("locationInput: $locationInput");
    String createGroup = """
      mutation {
        createGroup(data: {
          name: "${groupInput['name']}",
          description: "${groupInput['description']}",          
          status: "ACTIVE",          
          createdAt: "${groupInput['createdAt']}",
          updatedAt: "${groupInput['updatedAt']}",
          chats: {
                create: [
                  {
                    name: "General",
                    isPrivate: false,
                    users: {
                      connect: [
                        "${groupInput['user_id']}"
                      ]
                    }


                  }
                ]
              }    
          price: {
                create: {
                  amount: "${groupInput['price']}",                                
                }
              },
          joinConditions: {
            create: {
              withRequest: ${groupInput['withRequest']},
              withPayment: ${groupInput['withPayment']},              

            }
          },
          userParticipants: {
                create:
                  {
                    user: {
                      connect:                   
                          "${groupInput['user_id']}"    
                      }                                         
                      roles: "${groupInput['roles']}"
                                       
                  }                                     
              },  
          groupLocations: {
                create: [
                  {                                 
                    location: {    
                      create: {
                        name: "${locationInput['name']}",
                        latitude: ${locationInput['latitude']},
                        longitude: ${locationInput ['longitude']},
                      }            
                    }
                  }
                ]
              }   
          }) {
           ${GroupFragments().fullGroup()}
          }   
        }
        """;

    return createGroup;
  }

}
