import mongoose from 'mongoose';
import {EventType} from './enums.js'; 

const Schema = mongoose.Schema;


const eventSchema = new mongoose.Schema({
    name: String,
    games: [{ type: Schema.Types.ObjectId, ref: 'Game' }],
    joinConditions: [{ type: Schema.Types.ObjectId, ref: 'JoinConditions' }],
    isMainEvent: Boolean,
    amenities: String,
    userParticipants: [{ type: Schema.Types.ObjectId, ref: 'EventUserParticipant' }],
    price: { type: Schema.Types.ObjectId, ref: 'Price' },
    requests: [{ type: Schema.Types.ObjectId, ref: 'Request' }],
    images: [{ type: Schema.Types.ObjectId, ref: 'Image' }],
    fieldLocations: [{ type: Schema.Types.ObjectId, ref: 'FieldLocation' }],
    type: {
        type: String,
        enum: ['TRYOUT', 'GAME', 'LEAGUE', 'TOURNAMENT', 'TRAINING'],
        required: true
    },
    payments: [{ type: Schema.Types.ObjectId, ref: 'Payment' }],
    chats: [{ type: Schema.Types.ObjectId, ref: 'Chat' }],
    users: [{ type: Schema.Types.ObjectId, ref: 'User' }],
    rsvp: [{ type: Schema.Types.ObjectId, ref: 'RSVP' }],
    archived: Boolean,
    deleted: Boolean,
    createdAt: String,
    startTime: String,
    endTime: String,
    capacity: Number,
    mainImageKey: String,
    coupons: [{ type: Schema.Types.ObjectId, ref: 'Coupon' }],
    eventRatings: [{ type: Schema.Types.ObjectId, ref: 'EventRating' }],    
    hostAmenities: String


    // ... other fields ...
});

const Event = mongoose.model('Event', eventSchema);

export default Event;