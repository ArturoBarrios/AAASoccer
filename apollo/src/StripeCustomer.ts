import mongoose from 'mongoose';
const Schema = mongoose.Schema;


const stripeCustomerSchema = new mongoose.Schema({
    customerId: String,
    user: { type: Schema.Types.ObjectId, ref: 'User' },
});

const StripeCustomer = mongoose.model('StripeCustomer', stripeCustomerSchema);

export default StripeCustomer;