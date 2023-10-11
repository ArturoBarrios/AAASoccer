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
}


