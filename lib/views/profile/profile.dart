import 'package:soccermadeeasy/components/events_list_widget.dart';
import 'package:soccermadeeasy/components/teams_list_widget.dart';
import 'package:soccermadeeasy/extensions/share_image_text.dart';
import '../../components/info_detail_list_tile.dart';
import '../../constants.dart';
import '../../enums/view_status.dart';
import 'package:flutter/material.dart';

import '../settings/settings_view.dart';
import '../../components/images_list_widget.dart';
import '../../components/loading_screen2.dart';
import '../../components/object_profile_main_image.dart';
import 'profile_controller.dart';

// // // // // // // // // // // // // // //
class Profile extends StatefulWidget {
  const Profile({Key? key, required this.profileDetails}) : super(key: key);

  final dynamic profileDetails;

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  ViewStatus _viewStatus = ViewStatus.loading;
  final ProfileController _viewController = ProfileController();

  @override
  void initState() {
    super.initState();
    loadInitialData();
  }

  Future<void> loadInitialData() async {
    await _viewController.loadInitialData(widget.profileDetails);

    changeViewStatus(ViewStatus.completed);
  }

  changeViewStatus(final ViewStatus status) {
    setState(() {
      _viewStatus = status;
    });
  }

  Future<void> onTapShare() async {
    await 'Hey theres, my name is ${widget.profileDetails['user']['username']}'
        .share(imageKey: widget.profileDetails['user']['mainImageKey']);
  }

  Future<void> onTapSettings() async => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (BuildContext context) => const SettingsView(),
        ),
      );

  @override
  Widget build(BuildContext context) {
    switch (_viewStatus) {
      case ViewStatus.loading:
        return const LoadingScreen2();
      case ViewStatus.completed:
        return Scaffold(
            body: ListView(
          physics: const ScrollPhysics(),
          children: <Widget>[
            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      tooltip: 'Go back',
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    const Spacer(), // This will take up all available space between the elements
                    IconButton(
                      icon: const Icon(
                        Icons.share,
                        color: Colors.blue,
                      ),
                      onPressed: onTapShare,
                    ),
                    IconButton(
                        icon: const Icon(
                          Icons.settings,
                          color: Colors.blue,
                        ),
                        onPressed: onTapSettings)
                  ],
                ),
                ObjectProfileMainImage(
                    objectImageInput: _viewController.objectImageInput),
                const SizedBox(height: 25.0),
                Text(
                  _viewController.currentUser['email'] ?? '',
                  style: const TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4.0),
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
                            widget.profileDetails['userDetails']['followers']
                                .toString(),
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
                            widget.profileDetails['userDetails']['following']
                                .toString(),
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
                            'Stars',
                            style: TextStyle(
                                fontFamily: 'Montserrat', color: Colors.grey),
                          )
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const <Widget>[
                          Text(
                            '10',
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 5.0),
                          Text(
                            "Level",
                            style: TextStyle(
                                fontFamily: 'Montserrat', color: Colors.grey),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const <Widget>[
                      Text("History")
                      // IconButton(icon: Icon(Icons.table_chart),onPressed: (){},),
                      // IconButton(
                      //   icon: Icon(Icons.menu),
                      //   onPressed: () {},
                      // )
                    ],
                  ),
                ),

                // History(historyDetails: []),
                TeamsListWidget(
                    userObjectDetails: _viewController.teamListDetails),
                EventsListWidget(
                    objectEventsDetails: _viewController.eventListDetails),
                ImagesListWidget(details: {"for": Constants.USER}),

                const InfoDetailListTile(
                    name: "Excellent Perfomance",
                    value: "Top 1%",
                    tooltip: "Today",
                    date: "02/23/2019"),
                const InfoDetailListTile(
                    name: "Amazing value!",
                    value: "😂",
                    tooltip: "Today",
                    date: "02/22/2019"),
                const InfoDetailListTile(
                    name: "Runner-up of Voting Cup",
                    value: "#3",
                    tooltip: "Yesterday",
                    date: "02/22/2019"),
                const InfoDetailListTile(
                    name: "Victory is super close",
                    value: "🔥",
                    tooltip: "Yesterday",
                    date: "02/22/2019"),
                Container(
                  margin: const EdgeInsets.all(25),
                  child: ElevatedButton(
                    onPressed: () => _viewController.signOut(),
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
        ));
    }
  }
}
