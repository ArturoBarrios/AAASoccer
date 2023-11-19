import mongoose from 'mongoose';
const Schema = mongoose.Schema;


const gameSchema = new mongoose.Schema({
    pickup: Boolean
    // ... other fields ...
});

const Game = mongoose.model('Game', gameSchema);

export default Game;