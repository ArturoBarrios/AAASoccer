import mongoose from 'mongoose';
import {EventUserParticipantAttendingOptions} from './enums'; 

const Schema = mongoose.Schema;


const eventUserParticipantSchema = new mongoose.Schema({
    event: Event,
    user: { type: Schema.Types.ObjectId, ref: 'User' },
    roles: String,    
    isAttending: EventUserParticipantAttendingOptions
});

const EventUserParticipant = mongoose.model('EventUserParticipant', eventUserParticipantSchema);

export default EventUserParticipant;