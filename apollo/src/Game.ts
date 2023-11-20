import mongoose from 'mongoose';
const Schema = mongoose.Schema;


const gameSchema = new mongoose.Schema({
    pickup: Boolean,
    event: { type: Schema.Types.ObjectId, ref: 'Event' }    
});

const Game = mongoose.model('Game', gameSchema);

export default Game;