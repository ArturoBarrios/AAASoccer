import mongoose from 'mongoose';
const Schema = mongoose.Schema;


const imageSchema = new mongoose.Schema({
    isMainImage: Boolean,
    public: Boolean,
    url: String,
    key: String,
    user: { type: Schema.Types.ObjectId, ref: 'User' },
    event: { type: Schema.Types.ObjectId, ref: 'Event' },            
    location: { type: Schema.Types.ObjectId, ref: 'Location'},          
    s3bucket: String
});

const Image = mongoose.model('Image', imageSchema);

export default Image;