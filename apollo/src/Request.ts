import mongoose from 'mongoose';
import { RequestType, RequestStatus } from './enums.js';

const Schema = mongoose.Schema;


const requestSchema = new mongoose.Schema({
    type: Object.values(RequestType), 
    sender: { type: Schema.Types.ObjectId, ref: 'User' },
    receivers: [{ type: Schema.Types.ObjectId, ref: 'User' }],
    acceptedBy: { type: Schema.Types.ObjectId, ref: 'User' },
    status: Object.values(RequestStatus),
    requestAttempts: BigInt,
    fromOrganizer: Boolean,
    event: { type: Schema.Types.ObjectId, ref: 'Event' },
    team: { type: Schema.Types.ObjectId, ref: 'Team' },    
    forRole: String,
    sentAt: String,
    acceptedAt: String,
});

const Request = mongoose.model('Request', requestSchema);

export default Request;