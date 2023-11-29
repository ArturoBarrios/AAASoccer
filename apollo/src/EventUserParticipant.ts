import mongoose from 'mongoose';
import {EventUserParticipantAttendingOptions} from './enums.js'; 

const Schema = mongoose.Schema;


const eventUserParticipantSchema = new mongoose.Schema({
    event: { type: Schema.Types.ObjectId, ref: 'Event' },
    user: { type: Schema.Types.ObjectId, ref: 'User' },
    roles: String,    
    // isAttending: Object.values(EventUserParticipantAttendingOptions)
});

const EventUserParticipant = mongoose.model('EventUserParticipant', eventUserParticipantSchema);

export default EventUserParticipant;