import mongoose from 'mongoose';
import { FieldPlayerOccupancySize, SurfaceType } from './enums.js';

const Schema = mongoose.Schema;


const fieldLocationSchema = new mongoose.Schema({
    isMainField: Boolean,
    location: { type: Schema.Types.ObjectId, ref: 'Location' },    
    events: [{ type: Schema.Types.ObjectId, ref: 'Event' }],
    fieldSize: Object.values(FieldPlayerOccupancySize),  
    indoor: Boolean,
    surface: { 
        type: String, 
        enum: Object.values(SurfaceType) 
    },
    private: Boolean,    
    socialMediaApps: [{ type: Schema.Types.ObjectId, ref: 'SocialMediaApp' }],                    
    eventRatings: [{ type: Schema.Types.ObjectId, ref: 'EventRating' }],
    fieldLocationRating: Number,
    fieldAmenities: String,
});

const FieldLocation = mongoose.model('FieldLocation', fieldLocationSchema);

export default FieldLocation;