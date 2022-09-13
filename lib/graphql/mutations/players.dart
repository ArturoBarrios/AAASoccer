class PlayerMutations {

  String createPlayer(Map<String, dynamic> userInput,Map<String,dynamic> playerInput){
    String createPlayer = """
      mutation {
        createPlayer(data: {
          user: {
            create: 
            {
              name: "${userInput['name']}",
              phone: "${userInput['phone']}",
              email: "${userInput['email']}",
              username: "${userInput['username']}",
              birthdate: "${userInput['birthdate']}"
            }
          } 
          }) {
            _id
            user{
              name,
              phone
            }      
          }   
        }
        """;

    return createPlayer;
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
