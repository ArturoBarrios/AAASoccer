import mongoose from 'mongoose';
const Schema = mongoose.Schema;


const joinConditionsSchema = new mongoose.Schema({
    withRequest: Boolean,
    withPayment: Boolean,
    forTeam: Boolean,
    forEvent: Boolean,
    event: Event,
});

const JoinConditions = mongoose.model('JoinConditions', joinConditionsSchema);

export default JoinConditions;