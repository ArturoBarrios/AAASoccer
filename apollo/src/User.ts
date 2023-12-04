import mongoose from 'mongoose';
import { GenderType, UserAccountStatus } from './enums.js';
const Schema = mongoose.Schema;


const userSchema = new mongoose.Schema({
    isSuperUser: Boolean,    
    stripeCustomers: [{ type: Schema.Types.ObjectId, ref: 'StripeCustomer' }],
    payments: [{ type: Schema.Types.ObjectId, ref: 'Payment' }],    
    OSPID: String,
    name: String,
    phone: String,
    email: String,
    bio: String,
    username: String,
    birthdate: String,
    age: Number,    
    gender: String,
    followers: [{ type: Schema.Types.ObjectId, ref: 'FollowRelation' }],
    following: [{ type: Schema.Types.ObjectId, ref: 'FollowRelation' }],
    location: { type: Schema.Types.ObjectId, ref: 'Location' },
    player: { type: Schema.Types.ObjectId, ref: 'Player' },    
    status: Object.values(UserAccountStatus),
    createdAt: String,
    updatedAt: String,
    images: [{ type: Schema.Types.ObjectId, ref: 'Image' }],
    events: [{ type: Schema.Types.ObjectId, ref: 'Event' }],
    eventUserParticipants: [{ type: Schema.Types.ObjectId, ref: 'EventUserParticipant' }],            
    requestsSent: [{ type: Schema.Types.ObjectId, ref: 'Request' }],
    requestsReceived: [{ type: Schema.Types.ObjectId, ref: 'Request' }],
    requestsAccepted: [{ type: Schema.Types.ObjectId, ref: 'Request' }],        
    onboarded: Boolean,
    mainImageKey: String,
    isProfilePrivate: Boolean,
    socialMediaApps: [{ type: Schema.Types.ObjectId, ref: 'SocialMediaApp' }],    
    coupons: [{ type: Schema.Types.ObjectId, ref: 'Coupon' }],        
    eventRatings: [{ type: Schema.Types.ObjectId, ref: 'EventRating' }],
    hasAcceptedTermsAndConditions: Boolean,
    hasAcceptedPrivacyPolicy: Boolean,
    hostRating: Number,
});

const User = mongoose.model('User', userSchema);

export default User;




