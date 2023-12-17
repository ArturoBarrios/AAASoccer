import mongoose from 'mongoose';
const Schema = mongoose.Schema;


const followRelationSchema = new mongoose.Schema({
    follower: { type: Schema.Types.ObjectId, ref: 'User' },
    following: { type: Schema.Types.ObjectId, ref: 'User' }
});

const FollowRelation = mongoose.model('FollowRelation', followRelationSchema);

export default FollowRelation;