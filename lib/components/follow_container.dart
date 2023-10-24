import 'package:flutter/material.dart';

import '../commands/user_command.dart';

class FollowContainer extends StatefulWidget {
  const FollowContainer({Key? key, required this.userObject})
      : super(key: key);

  final dynamic userObject;

  @override
  _FollowContainerState createState() => _FollowContainerState();
}

class _FollowContainerState extends State<FollowContainer> {

  void followPlayer() {
    print("Player Clicked");
    dynamic user = UserCommand().getAppModelUser();
    dynamic followUserInput = {
      "followerId": user['_id'],
      "followingId": widget.userObject['_id']
    };
    UserCommand().followUser(followUserInput);
  }
  
  Container followUserContainer() {
    bool isUserFollowingPlayer =
        UserCommand().isCurrentUserFollowingUser(widget.userObject);
    bool isUserFollowedByPlayer =
        UserCommand().isCurrentUserFollowedByUser(widget.userObject);
    print(
        "followUserContainerValues: $isUserFollowingPlayer, $isUserFollowedByPlayer");
    //follow
    if (!isUserFollowingPlayer && !isUserFollowedByPlayer) {
      return Container(
          child: GestureDetector(
        onTap: () {
          //potentially show dialogue
          //with different request options
          followPlayer();
        },
        child: Container(
          child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0), child: Text("Follow")),
        ),
      ));
    }
    //follow back
    else if (isUserFollowedByPlayer && !isUserFollowingPlayer) {
      return Container(
          child: GestureDetector(
        onTap: () {
          //potentially show dialogue
          //with different request options
          followPlayer();
        },
        child: Container(
          child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Text("Follow Back")),
        ),
      ));
    }
    //unfollow
    else if (!isUserFollowedByPlayer && isUserFollowingPlayer) {
      return Container(
          child: GestureDetector(
        onTap: () {
          //potentially show dialogue
          //with different request options
          followPlayer();
        },
        child: Container(
          child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Text("Unfollow")),
        ),
      ));
    }
    //friends
    else {
      return Container(
          child: GestureDetector(
        onTap: () {
          //potentially show dialogue
          //with different request options
          followPlayer();
        },
        child: Container(
          child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Text("Unfollow")),
        ),
      ));
    }
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      child: followUserContainer(),
    );
  }
}


