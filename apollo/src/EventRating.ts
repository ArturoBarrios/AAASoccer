import mongoose from 'mongoose';
const Schema = mongoose.Schema;


const eventRatingSchema = new mongoose.Schema({
    event: { type: Schema.Types.ObjectId, ref: 'Event'},
    user: { type: Schema.Types.ObjectId, ref: 'User' },
    fieldLocation: { type: Schema.Types.ObjectId, ref: 'FieldLocation'},
    eventRating: Int32Array,
    hostRating: Int32Array,
    fieldLocationRating: Int32Array, 
    eventFeedback: String,
    hostFeedback: String,
    fieldLocationFeedback: String,
});

const EventRating = mongoose.model('EventRating', eventRatingSchema);

export default EventRating;