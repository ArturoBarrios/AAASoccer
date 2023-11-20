import Game from "./Game.js";
import Event from "./Event.js";

const resolvers = {
    Mutation: {
      createGame: async (parent, args, context, info) => {
        console.log("createGame args: ", args.input.eventInput);        
                
            const createdEvent = new Event({
                name: args.input.eventInput.name 
            });
            await createdEvent.save();
            console.log("createdEvent: ", createdEvent._id);
        
        const createdGame = new Game({
            pickup: args.input.pickup,
            event: createdEvent._id,            
        });

        const res = await createdGame.save();
        await res.populate('event'); 


        console.log("createdGame res: ", res);
  
        return {
          code: "200", 
          success: true, 
          message: "User email was successfully updated", 
          game: res          
        };
      },
    },
    Query: {
      allGames: async (parent, args, context, info) => {        
        const games = await Game.find();

        console.log("games: ", games);
  
        return {
          code: "200", 
          success: true,
          message: "User email was successfully updated", 
          games: games          
        };
      },
    },
  };
  
  

  export default resolvers; 
  