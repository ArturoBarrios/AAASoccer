import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:provider/provider.dart';
import 'package:soccermadeeasy/components/Mixins/event_mixin.dart';
import 'package:soccermadeeasy/extensions/share_image_text.dart';
import '../../commands/base_command.dart';
import '../../commands/event_command.dart';
import '../../commands/images_command.dart';
import '../../commands/requests_command.dart';
import '../../commands/user_command.dart';
import '../../components/Loading/loading_screen.dart';
import '../../components/Mixins/images_mixin.dart';
import '../../components/Mixins/payment_mixin.dart';
import '../../components/Mixins/event_mixin.dart';
import '../../components/chats_list_widget.dart';
import '../../components/image_header.dart';
import '../../components/location_search_bar.dart';
import '../../components/my_map_page.dart';
import '../../components/object_profile_main_image.dart';
import '../../components/players_list_widget.dart';
import '../profile/profile.dart';
import '../../components/payment_screen.dart';
import '../../commands/location_command.dart';
import '../../components/card_form_screen.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../components/headers.dart';
import 'dart:async';
import 'package:url_launcher/url_launcher.dart';

import '../../components/update_view_form.dart';
import '../../constants.dart';
import '../../models/app_model.dart';
import '../social_media_cards_view/social_media_cards_view.dart';

class PickupView extends StatefulWidget with EventMixin, ImagesMixin {
  PickupView({Key? key, required this.game}) : super(key: key);

  final dynamic game;

  @override
  _PickupViewState createState() => _PickupViewState();
}

class _PickupViewState extends State<PickupView> {
  final nameController = TextEditingController();
  final imageController = TextEditingController();
  final secondaryNameController = TextEditingController();
  final addressController = TextEditingController();
  final surfaceController = TextEditingController();
  final fieldSizeController = TextEditingController();
  final privateController = TextEditingController();

  bool _isLoading = true;
  late LatLng _center = LatLng(45.521563, -122.677433);
  dynamic priceObject;
  dynamic objectImageInput = {
    "imageUrl": "",
    "containerType": Constants.IMAGEBANNER,
    "mainEvent": null,
    "isMine": false
  };
  String imageUrl = "";

  LocationSearchBar locationSearchBar = new LocationSearchBar();

  LatLng latLng(lat, lon) {
    return LatLng(lat, lon);
  }

  void goBack() {
    Navigator.pop(context);
  }

  void loadEventPayment() {
    priceObject = widget.game['price'];
  }

  Future<void> loadInitialData() async {
    print("loadInitialData() in GameView");
    dynamic getEventDetailsResp =
        await EventCommand().getUserEventDetails([widget.game]);
    widget.setupPlayerList();
    //wait for 3 seconds
    await Future.delayed(const Duration(seconds: 2));
    dynamic userEventDetails = getEventDetailsResp;
    BaseCommand().updateUserEventDetailsModel(userEventDetails);
    //setup image
    objectImageInput = await widget.loadEventMainImage(userEventDetails);

    setState(() {
      _isLoading = false;
    });
    print("loadInitialData() finished!");
    print("loadEventPayment() in loadInitialData()");
    loadEventPayment();
    print("loadEventPayment() finished in loadInitialData()");
  }

  void updateChatsList(dynamic createdChat) {
    print("updateChatsList");
    print("createdChat: " + createdChat.toString());
    setState(() {
      dynamic userEventDetails = BaseCommand().getUserEventDetailsModel();
      userEventDetails['mainEvent']['chats']['data'].add(createdChat);
      BaseCommand().updateUserEventDetailsModel(userEventDetails);
    });
  }

  @override
  void initState() {
    super.initState();

    print("initState");
    print("game: " + widget.game.toString());
    loadInitialData();
    // _isLoading = false;
  }

  Future<void> onTapShare() async {
    await 'Hey there, check out this event'
        .share(imageKey: widget.game['mainImageKey']);
  }

  Future<void> onTapSocialMediaApp() async {
    Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (BuildContext context) => SocialMediaCardsView(
            // object: widget.game,
            ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print("build()");
    print("game: " + widget.game.toString());

    dynamic userEventDetails =
        context.select<AppModel, dynamic>((value) => value.userEventDetails);

    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(
            200.0), // You can adjust the height value as per your requirement.
        child: ObjectProfileMainImage(objectImageInput: objectImageInput),
      ),
      body: _isLoading
          ? SizedBox(
              height: 120,
              width: MediaQuery.of(context).size.width,
              child: const Align(
                alignment: Alignment.center,
                child:
                    // BottomNav()//for times when user deleted in cognito but still signed into app
                    LoadingScreen(
                        currentDotColor: Colors.white,
                        defaultDotColor: Colors.black,
                        numDots: 10),
              ),
            )
          : SingleChildScrollView(
              child: Center(
                child: Expanded(
                  child: Column(
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.share,
                          color: Colors.blue,
                        ),
                        onPressed: onTapShare,
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.social_distance,
                          color: Colors.red,
                        ),
                        onPressed: onTapSocialMediaApp,
                      ),
                      UpdateViewForm(userObjectDetails: userEventDetails),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
