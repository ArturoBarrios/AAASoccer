import mongoose from 'mongoose';
const Schema = mongoose.Schema;


const playerSchema = new mongoose.Schema({        
    hasRating: Boolean,
    showRating: Boolean,
    user: { type: Schema.Types.ObjectId, ref: 'User' },
    selfRating: Number,        
});

const Player = mongoose.model('Player', playerSchema);

export default Player;