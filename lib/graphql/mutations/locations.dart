class LocationMutations {
  String createLocation(Map<String, dynamic> locationInput) {
    List<String> fields = [];

    if (locationInput['name'] != null) {
      fields.add('name: "${locationInput['name']}"');
    }

    if (locationInput['latitude'] != null) {
      fields.add('latitude: ${locationInput['latitude']}');
    }

    if (locationInput['longitude'] != null) {
      fields.add('longitude: ${locationInput['longitude']}');
    }
    if (locationInput['url'] != null) {
      fields.add('longitude: ${locationInput['longitude']}');
    }

    String createLocation = """
      mutation {
        createLocation(data: {            
              ${fields.join(',')}                               
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
