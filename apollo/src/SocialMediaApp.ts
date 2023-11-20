import { SocialMediaType } from "./enums";

import mongoose from 'mongoose';
const Schema = mongoose.Schema;


const socialMediaAppSchema = new mongoose.Schema({
    type: SocialMediaType,
    url: String,
    user: { type: Schema.Types.ObjectId, ref: 'User' },    
    event: { type: Schema.Types.ObjectId, ref: 'Event' },    
    fieldLocation: { type: Schema.Types.ObjectId, ref: 'FieldLocation' },
});

const SocialMediaApp = mongoose.model('SocialMediaApp', socialMediaAppSchema);

export default SocialMediaApp;