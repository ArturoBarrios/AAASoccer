import '../fragments/group_fragments.dart';

class GroupQueries {

  String getAllGroups() {
    String getAllGroups = """
          query getGroups {
            allGroups {
              data {      
               ${GroupFragments().fullGroup()}  
                    
                  }
                }
              }
          """;

    return getAllGroups;
  }

  String findGroupByID(Map<String, dynamic> groupInput) {
    String getGroup = """
      query getGroup {
            findGroupByID(id: "${groupInput['_id']}") {      
             ${GroupFragments().fullGroup()}                                                                                    
          }
        }
    """;

    return getGroup;
  }  

}