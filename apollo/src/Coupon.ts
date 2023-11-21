import mongoose from 'mongoose';
const Schema = mongoose.Schema;


const couponSchema = new mongoose.Schema({
    code: String,
    discount: { type: Schema.Types.ObjectId, ref: 'Discount' },
    event: [{ type: Schema.Types.ObjectId, ref: 'Event' }],    
    users: [{ type: Schema.Types.ObjectId, ref: 'User' }],        
    accessCoupon: Boolean,
    capacity: BigInt,
});

const Coupon = mongoose.model('Coupon', couponSchema);

export default Coupon;