import mongoose from 'mongoose';
import { LocationType } from './enums.js';

const Schema = mongoose.Schema;


const locationSchema = new mongoose.Schema({
    name: String,
    secondaryName: String,
    address: String,
    // latitude: Number!,
    // longitude: Number!, 
    locationType: Object.values(LocationType) 
});

const Location = mongoose.model('Location', locationSchema);

export default Location;