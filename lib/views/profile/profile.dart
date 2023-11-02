import 'package:provider/provider.dart';
import 'package:soccermadeeasy/components/events_list_widget.dart';
import 'package:soccermadeeasy/components/follow_container.dart';
import 'package:soccermadeeasy/components/teams_list_widget.dart';
import 'package:soccermadeeasy/extensions/share_image_text.dart';
import 'package:soccermadeeasy/models/pageModels/profile_page_model.dart';
import '../../commands/user_command.dart';
import '../../components/headers.dart';
import '../../components/info_detail_list_tile.dart';
import '../../components/models/button_model.dart';
import '../../components/sideways_pill_widget.dart';
import '../../components/switch_button.dart';
import '../../constants.dart';
import '../../models/enums/view_status.dart';
import 'package:flutter/material.dart';

import '../../styles/colors.dart';
import '../onboarding/onboarding_view.dart';
import '../settings/settings_view.dart';
import '../../components/images_list_widget.dart';
import '../../components/loading_screen2.dart';
import '../../components/object_profile_main_image.dart';

// // // // // // // // // // // // // // //
class Profile extends StatefulWidget {
  const Profile({Key? key, required this.user}) : super(key: key);

  final dynamic user;

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  ViewStatus _viewStatus = ViewStatus.loading;

  @override
  void initState() {
    super.initState();
    loadInitialData();
  }

  Future<void> loadInitialData() async {
    await UserCommand().getUserDetails(widget.user, true);
    changeViewStatus(ViewStatus.completed);
  }

  changeViewStatus(final ViewStatus status) {
    setState(() {
      _viewStatus = status;
    });
  }

  changeSwitchStatus(final bool value) {
    setState(() {
      // _viewController.profilePrivateStatus = value;
    });
  }

  Future<void> onTapShare(dynamic user) async {
    await 'Hey theres, my name is ${user['username']}'
        .share(imageKey: user['mainImageKey']);
  }

  Future<void> onTapSettings() async => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (BuildContext context) => const SettingsView(),
        ),
      );

  Future<void> onTapChangeProfilePrivateStatus(final bool value) async {
    final result = await UserCommand()
        .updateUserProfilePrivateStatus({'isProfilePrivate': value});
    if (result['data'] != null) {
      changeSwitchStatus(result['data']['isProfilePrivate']);
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isMine = context.watch<ProfilePageModel>().isMine;
    dynamic user = context.watch<ProfilePageModel>().user;
    dynamic teamUserParticipants =
        context.watch<ProfilePageModel>().teamUserParticipants;
    dynamic eventUserParticipants =
        context.watch<ProfilePageModel>().eventUserParticipants;
    dynamic objectImageInput =
        context.watch<ProfilePageModel>().objectImageInput;
    bool isProfilePrivate = context.watch<ProfilePageModel>().isProfilePrivate;
    List followers = context.watch<ProfilePageModel>().followers;
    List following = context.watch<ProfilePageModel>().following;

    print("profile details: ");
    print("eventUserParticipants: "+ eventUserParticipants.toString());
    print("teamUserParticipants: "+ teamUserParticipants.toString());
    switch (_viewStatus) {
      case ViewStatus.loading:
        return const LoadingScreen2();
      case ViewStatus.completed:
        return Scaffold(
          appBar: Headers(
            playerStepperButton: ButtonModel(
              prefixIconData: Icons.play_circle_fill_rounded,
              onTap: () {
                Navigator.push(context, MaterialPageRoute<void>(
                  builder: (BuildContext context) {
                    return const OnboardingView();
                  },
                ));
              },
            ),
          ).getMainHeader(context),
          body: ListView(
            physics: const ScrollPhysics(),
            children: <Widget>[
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[

                  ObjectProfileMainImage(objectImageInput: objectImageInput),
                  
                  Center( // Wrap the FollowContainer with a Center widget
  child: Container( // Then, wrap it with a Container to specify width
    width: MediaQuery.of(context).size.width * (2/5), // Set width to 3/5 of screen width
    child: FollowContainer(userObject: widget.user),
  ),
),

                  const SizedBox(height: 10.0),
                  Text(
                    "@" + user['username'] ?? '',
                    style: const TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SidewaysPillWidget(
                        color: AppColors.tsnGreen,
                        text: "Professional",
                      ),
                      const SizedBox(width: 6.0),
                      SidewaysPillWidget(
                        color: AppColors.tsnAlmostBlack,
                        text: "RW",
                      ),
                      const SizedBox(width: 6.0),
                      SidewaysPillWidget(
                        color: AppColors.tsnAlmostBlack,
                        text: "26",
                      ),
                      
                    ],
                  ),
                  const SizedBox(height: 8.0),                  
                  const Text(
                    'Durham, NH',
                    style:
                        TextStyle(fontFamily: 'Montserrat', color: Colors.grey),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              followers.toString(),
                              style: const TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 5.0),
                            const Text(
                              'Followers',
                              style: TextStyle(
                                  fontFamily: 'Montserrat', color: Colors.grey),
                            )
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              following.toString(),
                              style: const TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 5.0),
                            const Text(
                              'Following',
                              style: TextStyle(
                                  fontFamily: 'Montserrat', color: Colors.grey),
                            )
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const <Widget>[
                            Text(
                              '310',
                              style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 5.0),
                            Text(
                              'Games',
                              style: TextStyle(
                                  fontFamily: 'Montserrat', color: Colors.grey),
                            )
                          ],
                        ),
                        
                      ],
                    ),
                  ),                                    
                  TeamsListWidget(
                    user: user,
                    mainEvent: null,
                    teams: teamUserParticipants,
                  ),
                  EventsListWidget(
                    team: null,
                    user: user,
                    events: [],
                    eventUserParticipants: eventUserParticipants,
                  ),
                  ImagesListWidget(
                      mainEvent: null, team: null, imageFor: Constants.USER),

                 
                  Container(
                    margin: const EdgeInsets.all(25),
                    child: ElevatedButton(
                      onPressed: () {},
                      // style: ButtonStyle(elevation: MaterialStateProperty(12.0 )),
                      style: ElevatedButton.styleFrom(
                          elevation: 12.0,
                          textStyle: const TextStyle(color: Colors.white)),
                      child: const Text('Sign Out'),
                    ),
                  ),
                ],
              )
            ],
          ),
        );
    }
  }
}
