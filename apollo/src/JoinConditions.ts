import mongoose from 'mongoose';



const Schema = mongoose.Schema;


const joinConditionsSchema = new mongoose.Schema({
    withRequest: Boolean,
    withPayment: Boolean,
    forTeam: Boolean,
    forEvent: Boolean,
    event: { type: Schema.Types.ObjectId, ref: 'Event' },
});

const JoinConditions = mongoose.model('JoinConditions', joinConditionsSchema);

export default JoinConditions;