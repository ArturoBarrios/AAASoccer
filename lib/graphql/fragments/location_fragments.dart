class LocationFragments{

  String FieldLocationFull(){
     String fieldLocationFullReturn = """                  
         _id
         url
         location{
          ${LocationFull()}    

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