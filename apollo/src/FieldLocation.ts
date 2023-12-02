import mongoose from 'mongoose';
import { FieldPlayerOccupancySize, SurfaceType } from './enums.js';

const Schema = mongoose.Schema;


const fieldLocationSchema = new mongoose.Schema({
    isMainField: Boolean,
    location: { type: Schema.Types.ObjectId, ref: 'Location' },    
    events: [{ type: Schema.Types.ObjectId, ref: 'Event' }],
    fieldSize: Object.values(FieldPlayerOccupancySize),  
    surface: Object.values(SurfaceType),
    private: Boolean,
    amenities: [{ type: Schema.Types.ObjectId, ref: 'Amenity' }],
    socialMediaApps: [{ type: Schema.Types.ObjectId, ref: 'SocialMediaApp' }],                    
    eventRatings: [{ type: Schema.Types.ObjectId, ref: 'EventRating' }],
    fieldLocationRating: Number,
});

const FieldLocation = mongoose.model('FieldLocation', fieldLocationSchema);

export default FieldLocation;