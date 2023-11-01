import 'package:flutter/material.dart';
import 'package:soccermadeeasy/components/Buttons/basic_elevated_button.dart';

import '../commands/user_command.dart';
import '../styles/colors.dart';

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
  
  Widget followUserContainer() {
    bool isUserFollowingPlayer =
        UserCommand().isCurrentUserFollowingUser(widget.userObject);
    bool isUserFollowedByPlayer =
        UserCommand().isCurrentUserFollowedByUser(widget.userObject);
    print(
        "followUserContainerValues: $isUserFollowingPlayer, $isUserFollowedByPlayer");
    //follow
    if (!isUserFollowingPlayer && !isUserFollowedByPlayer) {
      return 
        BasicElevatedButton(
          text: "Follow",
          onPressed: () {
            followPlayer();
          },
        );
        
      
    }
    //follow back
    else if (isUserFollowedByPlayer && !isUserFollowingPlayer) {
      return BasicElevatedButton(
          text: "Follow Back",
          onPressed: () {
            followPlayer();
          },
        );     
    }
    //unfollow
    else if (!isUserFollowedByPlayer && isUserFollowingPlayer) {
      return 
      BasicElevatedButton(
          text: "Unfollow",
          backgroundColor: AppColors.tsnRed,
          onPressed: () {
            // unfollowPlayer();
          },
        );
      
    }
    //friends
    else {
      return 
      BasicElevatedButton(
          text: "Unfollow",
          backgroundColor: AppColors.tsnRed,
          onPressed: () {
            // unfollowPlayer();
          },
        );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      child: followUserContainer(),
    );
  }
}


