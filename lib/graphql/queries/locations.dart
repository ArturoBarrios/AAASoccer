import 'package:soccermadeeasy/models/enums/LocationType.dart';

import '../fragments/location_fragments.dart';

class LocationQueries {
  String getFieldLocations(String fieldLocationFragment) {
      String getFieldLocations = """
          query getFieldLocations {
            allFieldLocations {
              data  {                      
                ${fieldLocationFragment}                
              }
            }
          }
        """;

      return getFieldLocations;
  }  
  
  String getFieldLocationsNearby(dynamic input, String fieldLocationFragment) {
      String getFieldLocationsNearbyString = """
          query getFieldLocationsNearby {
            getFieldLocationsNearby(
              latitude: ${input['latitude']}
              longitude: ${input['longitude']}
              radius: ${input['radius']}
            ) {
              message
              success
              code
              fieldLocations{
                ${fieldLocationFragment}       

              }                  
              
            }
          }
        """;

      return getFieldLocationsNearbyString;
  }  
}


