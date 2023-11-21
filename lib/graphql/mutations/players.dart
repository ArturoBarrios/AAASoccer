class PlayerMutations {
  String createPlayer(Map<String, dynamic> userInput,
      Map<String, dynamic> playerInput, Map<String, dynamic> locationInput) {
    String createPlayer = """
      mutation {
        createPlayer(input: {                    
          user: {                        
            name: "${userInput['name']}",
            phone: "${userInput['phone']}",
            email: "${userInput['email']}",
            username: "${userInput['username']}",
            birthdate: "${userInput['birthdate']}"
            location: {              
              latitude: ${locationInput['latitude']}
              longitude: ${locationInput['longitude']}              
            }
          }          
          }) {
            player{
              user{                
                name
                email
                phone
                location{                  
                  latitude
                  longitude
                } 
              }     
            }
          }   
        }
        """;

    return createPlayer;
  }
  

  String updatePlayerWithTeam(
      Map<String, dynamic> playerInput, Map<String, dynamic> teamInput) {
    String updatePlayerWithTeam = """      
      mutation {
        updatePlayer(id: "${playerInput['_id']}",
  				data: {
            showRating:"true"
            teams:{
              connect:[
                "${teamInput['_id']}"
              ]
              
            }
          }
                      
        ){
            _id
    				showRating
            user{
              _id
              name,
              phone
              location{
                _id
                latitude
                longitude
              } 
            }  
    				teams{	
              data{
                  	_id
                    
              }
            }
            
                  
            
            
  }
}
        """;

    return updatePlayerWithTeam;
  }

  static String createPlayerString = r'''
   mutation {
		  createPlayer(data: {		    
		    user: {          
		      create: 
		        { 
              name: "Arturo Barrios",
              phone:"a phone number",
              email:"test@gmail.com",
              username:"ArturoBarrios357",
              birthdate:"some day"
            }              
		    }
		  }) {
		    _id		    
		    user {      
		        name,
            phone
		    }
		  }
}
  ''';


}
