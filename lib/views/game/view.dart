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
import '../../components/create_event_payment.dart';
import '../../components/create_event_request.dart';
import '../../components/create_team_payment.dart';
import '../../components/create_team_request.dart';
import '../../components/event_date_widget.dart';
import '../../components/get_chat_widget.dart';
import '../../components/get_join_event_widget.dart';
import '../../components/image_header.dart';
import '../../components/images_list_widget.dart';
import '../../components/location_search_bar.dart';
import '../../components/my_map_page.dart';
import '../../components/object_profile_main_image.dart';
import '../../components/players_list_widget.dart';
import '../../components/price_widget.dart';
import '../../components/requests_list.dart';
import '../../components/rsvp_widget.dart';
import '../../components/send_players_request_widget.dart';
import '../../components/send_teams_request_widget.dart';
import '../../components/teams_list_widget.dart';
import '../../models/enums/RsvpStatus.dart';
import '../../models/pageModels/event_page_model.dart';
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
import '../../models/pageModels/app_model.dart';
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

  CreateEventRequest createEventRequestWidget = CreateEventRequest();
  CreateEventPayment createEventPaymentWidget = CreateEventPayment();
  CreateTeamPayment createTeamPaymentWidget = CreateTeamPayment();
  CreateTeamRequest createTeamRequestWidget = CreateTeamRequest();

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

  void addTeamCallback(dynamic team) {
    setState(() {
      // widget.userObjectDetails['mainEvent']['teams']['data'].add(team);
      // BaseCommand().updateUserEventDetailsModel(widget.userObjectDetails);
    });
  }

 

  @override
  Widget build(BuildContext context) {
    print("build()");
    print("game: " + widget.game.toString());

    dynamic mainEvent =
        context.select<EventPageModel, dynamic>((value) => value.mainEvent);
    List<dynamic> roles =
        context.select<EventPageModel, List<dynamic>>((value) => value.roles);
    bool isMine = context.select<EventPageModel, bool>((value) => value.isMine);
    bool isMember = context.select<EventPageModel, bool>((value) => value.isMember);
    dynamic price =
        context.select<EventPageModel, dynamic>((value) => value.price);
    String amountRemaining = context
        .select<EventPageModel, String>((value) => value.amountRemaining);
    String amountPaid = context.select<EventPageModel, String>((value) => value.amountPaid);
    String teamAmountRemaining = context
        .select<EventPageModel, String>((value) => value.amountRemaining);
    String teamAmountPaid = context.select<EventPageModel, String>((value) => value.teamAmountPaid);
    List userParticipants =
        context.select<EventPageModel, List>((value) => value.userParticipants);
    List teams = context.select<EventPageModel, List>((value) => value.teams);
    List players =
        context.select<EventPageModel, List>((value) => value.players);
    List chats = context.select<EventPageModel, List>((value) => value.chats);

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
                      //date
                      EventDateWidget(
                          canEdit: isMine,
                          startTime: mainEvent['startTime'],
                          endTime: mainEvent['endTime']),
                      //map
                      Container(
                        margin: const EdgeInsets.all(10.0),
                        color: Colors.amber[600],
                        width: MediaQuery.of(context).size.width -
                            (MediaQuery.of(context).size.width *
                                .1), //10% padding
                        height: 200.0,
                        child: MyMapPage(
                            latitude: mainEvent['location']['data'][0]
                                ['latitude'],
                            longitude: mainEvent['location']['data'][0]
                                ['longitude']),
                      ),
                      //join widget
                      GetJoinEventWidget(
                          mainEvent: mainEvent,
                          roles: roles,
                          isMine: isMine,
                          price: price,
                          amountRemaining: amountRemaining),
                      //Requests widget
                      RequestsList(objectDetails: {
                        "requests": mainEvent['requests']['data']
                      }),
                      //RSP
                      RSVPWidget(                                                
                        event: mainEvent,
                        userParticipants: userParticipants,
                      ),
                      //location search bar
                      locationSearchBar = LocationSearchBar(
                          initialValue: mainEvent['location']['data'][0]
                              ['name']),
                      //player list
                      PlayerList(event: mainEvent, team: null , userParticipants: userParticipants),
                      //team list
                      TeamsListWidget(mainEvent: mainEvent, teams: teams),
                      //player request widget
                      SendPlayersRequestWidget(
                          mainEvent: mainEvent,
                          team: null,
                          players: players,
                          isMine: isMine),
                      //team request widget
                      SendTeamsRequestWidget(
                        mainEvent: mainEvent,
                        isMine: isMine,
                        teams: teams,
                        addTeamCallback: addTeamCallback,
                      ),
                      //chat widget
                      // GetChatWidget(
                      //     mainEvent: mainEvent,
                      //     team: null,
                      //     players: players,
                      //     isMine: isMine,
                      //     updatechatsList: updateChatsList),
                      ChatsListWidget(
                        chats: chats,
                      ),
                      // Player price widget
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          PriceWidget(
                              price: price,
                              teamPrice: false,
                              eventPrice: true,
                              amountPaid: amountPaid,
                              amountRemaining: amountRemaining,
                              isMine: isMine,
                              isMember: isMember
                            )
                        ],
                      ),
                      //Team price widget
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          PriceWidget(
                            price: price,
                            teamPrice: true,
                            eventPrice: false,
                            amountPaid: teamAmountPaid,
                            amountRemaining: teamAmountRemaining,
                            isMine: isMine,
                            isMember: isMember
                          )
                        ],
                      ),
                      ImagesListWidget(mainEvent: mainEvent, team: null, imageFor: Constants.EVENT ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
