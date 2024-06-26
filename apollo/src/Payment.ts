import mongoose from 'mongoose';
import {PaymentType} from './enums.js';

const Schema = mongoose.Schema;


const paymentSchema = new mongoose.Schema({
    amount: String,
    event: { type: Schema.Types.ObjectId, ref: 'Event' },        
    paidAt: String,
    user: { type: Schema.Types.ObjectId, ref: 'User' },    
    isPlayerPayment: Boolean,
    isTeamPayment: Boolean,
    refunded: Boolean,
    charge: String,
    // paymentType: Object.values(PaymentType)
});

const Payment = mongoose.model('Payment', paymentSchema);

export default Payment;