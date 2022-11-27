
class TryoutQueries {
   String getTryouts()
   {
      String getTryouts = """
        query GetTryouts {
          allTryouts {
            data {      
              _id              
              event{
                  name        	
                  _id                  
              } 
            }
          }
        }
      """;

      return getTryouts;
   }

}