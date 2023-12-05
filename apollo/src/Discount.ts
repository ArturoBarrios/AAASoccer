import mongoose from 'mongoose';
const Schema = mongoose.Schema;


const discountSchema = new mongoose.Schema({
    percentage: Number, 
    amount: String    
});

const Discount = mongoose.model('Discount', discountSchema);

export default Discount;