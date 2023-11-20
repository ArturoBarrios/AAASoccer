import mongoose from 'mongoose';
const Schema = mongoose.Schema;


const discountSchema = new mongoose.Schema({
    percentage: Int32Array, 
    amount: String    
});

const Discount = mongoose.model('Discount', discountSchema);

export default Discount;