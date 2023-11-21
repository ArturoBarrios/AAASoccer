import mongoose from 'mongoose';
import { AmenityType } from './enums.js';

const Schema = mongoose.Schema;


const amenitySchema = new mongoose.Schema({
    type: Object.values(AmenityType),    
    fieldLocations: [{ type: Schema.Types.ObjectId, ref: 'FieldLocation' }],
});

const Amenity = mongoose.model('Amenity', amenitySchema);

export default Amenity;