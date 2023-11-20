import mongoose from 'mongoose';
import { AmenityType } from './enums';

const Schema = mongoose.Schema;


const amenitySchema = new mongoose.Schema({
    type: AmenityType,    
    fieldLocations: [{ type: Schema.Types.ObjectId, ref: 'FieldLocation' }],
});

const Amenity = mongoose.model('Amenity', amenitySchema);

export default Amenity;