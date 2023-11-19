import Game from "./Game.js";

const resolvers = {
    Mutation: {
      createGame: async (parent, args, context, info) => {
        // Logic to update user email
        const createdGame = new Game({
            pickup: args.pickup
        });

        const res = await createdGame.save();

        console.log("createdGame res: ", res);
  
        return {
          code: "200", // or appropriate code
          success: true, // or false in case of failure
          message: "User email was successfully updated", // Custom message
          game: createdGame          
        };
      },
    },
  };

  export default resolvers; 
  