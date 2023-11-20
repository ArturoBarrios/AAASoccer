import mongoose from 'mongoose';
import { LocationType } from './enums';

const Schema = mongoose.Schema;


const locationSchema = new mongoose.Schema({
    name: String,
    secondaryName: String,
    address: String,
    latitude: Float64Array!,
    longitude: Float64Array!, 
    locationType: LocationType 
});

const Location = mongoose.model('Location', locationSchema);

export default Location;