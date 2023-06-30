import '../fragments/organization_fragments.dart';

class OrganizationMutations {
  String createOrganization(
      Map<String, dynamic> organizationInput) {
    String createLocation = """
      mutation {
        createLocation(data: {            
              name: "${organizationInput['name']}",
              latitude: ${organizationInput['location']['latitude']},
              longitude: ${organizationInput['location']['longitude']},                                    
          }) {
            ${OrganizationFragments().fullOrganization()}}  
          }   
        }
        """;

    return createLocation;
  }
}
