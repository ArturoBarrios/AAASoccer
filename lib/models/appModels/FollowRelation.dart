import 'User.dart';

class FollowRelation {
  User? follower;
  User? following;

  FollowRelation({
    this.follower,
    this.following,
  });
}
