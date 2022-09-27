class LocationMutations {
  String createLocation(
      Map<String, dynamic> locationInput) {
    String createLocation = """
      mutation {
        createLocation(data: {            
              name: "${locationInput['name']}",
              latitude: ${locationInput['latitude']},
              longitude: ${locationInput['longitude']},                                    
          }) {
            _id
            name
            latitude
            longitude    
          }   
        }
        """;

    return createLocation;
  }
}
