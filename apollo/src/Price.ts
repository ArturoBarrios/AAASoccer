import mongoose from 'mongoose';
const Schema = mongoose.Schema;


const priceSchema = new mongoose.Schema({
    amount: String,
    event: { type: Schema.Types.ObjectId, ref: 'Event' },
    teamAmount: String,     
});

const Price = mongoose.model('Price', priceSchema);

export default Price;