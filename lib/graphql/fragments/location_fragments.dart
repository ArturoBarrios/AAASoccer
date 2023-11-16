class LocationFragments{

  String FieldLocationFull(){
     String fieldLocationFullReturn = """                  
         _id         
         location{
          ${LocationFull()}    

         }
         eventRatings{
        data{
          _id          
          fieldLocationRating          
          user{
            _id
          }
        }
      }

    """;

    return fieldLocationFullReturn;

  }

  String LocationFull() {
    String locationFullReturn = r'''                  
         _id
         name
         address
         latitude
         longitude
         locationType
    ''';

    return locationFullReturn;

  }
}