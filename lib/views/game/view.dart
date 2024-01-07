import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:soccermadeeasy/commands/event_command.dart';
import 'package:soccermadeeasy/components/Buttons/basic_elevated_button.dart';
import 'package:soccermadeeasy/components/Dialogues/alert_dialogue.dart';
import 'package:soccermadeeasy/components/Mixins/event_mixin.dart';
import 'package:soccermadeeasy/models/pageModels/app_model.dart';

import '../../commands/base_command.dart';
import '../../components/Mixins/images_mixin.dart';
import '../../components/image_selection_widget.dart';
import '../../components/create_event_payment.dart';
import '../../components/create_event_request.dart';
import '../../components/create_team_payment.dart';
import '../../components/create_team_request.dart';
import '../../components/get_join_event_widget.dart';
import '../../components/list_notes_widget.dart';
import '../../components/location_search_bar.dart';
import '../../components/models/button_model.dart';
import '../../components/my_map_page.dart';
import '../../components/payment_list_widget.dart';
import '../../components/players_list_widget.dart';
import '../../components/price_widget.dart';
import '../../models/pageModels/event_page.dart';
import '../../styles/colors.dart';
import '../../styles/font_sizes.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../components/headers.dart';
import 'dart:async';
import '../splash_screen.dart';

class PickupView extends StatefulWidget with EventMixin, ImagesMixin {
  PickupView({Key? key, required this.game, required this.eventPageInstance})
      : super(key: key);

  final dynamic game;
  EventPage eventPageInstance;

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

  String imageUrl = "";

  LocationSearchBar locationSearchBar = new LocationSearchBar();

  LatLng latLng(lat, lon) {
    return LatLng(lat, lon);
  }

  void goBack() {
    Navigator.pop(context);
  }

  Future<void> loadInitialData() async {
    print("loadInitialData() in GameView");

    // await EventCommand().getUserEventDetails([widget.game], true);
    widget.setupPlayerList();
    //wait for 3 seconds
    // await Future.delayed(const Duration(seconds: 2));
    // eventPageInstance = widget.eventPageInstance;

    setState(() {
      _isLoading = false;
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

  dynamic updateGeneralChatList(
      List<dynamic> generalChatList, String? chatId, dynamic updatedUsers) {
    for (var chat in generalChatList) {
      if (chat['_id'] == chatId) {
        chat['users']['data'] = updatedUsers;
      }
    }

    return generalChatList;
  }

  @override
  Widget build(BuildContext context) {
    print("build()");
    double paddingValue = 16;

    bool isSuperUser =
        context.select<AppModel, bool>((value) => value.isSuperUser);

    // PreferredSize(
    //   preferredSize: const Size.fromHeight(
    //       200.0), // You can adjust the height value as per your requirement.
    //   child: ObjectProfileMainImage(objectImageInput: objectImageInput),
    // ),

    return ChangeNotifierProvider<EventPage>.value(
      value: widget.eventPageInstance!,
      child: Consumer<EventPage>(
        builder: (context, event, child) {
          return _isLoading
              ? SplashScreen()
              : Scaffold(
                  extendBody: true,
                  appBar: Headers(
                    playerStepperButton: ButtonModel(
                      prefixIconData: Icons.play_circle_fill_rounded,
                      onTap: () {},
                    ),
                  ).getMainHeader(context),
                  body: SingleChildScrollView(
                    child: Center(
                      child: Column(
                        children: [
                          Container(
                            color: AppColors.tsnAlmostBlack,
                            child: Column(
                              children: [],
                            ),
                          ),

                          //name
                          Padding(
                            padding: EdgeInsets.fromLTRB(paddingValue,
                                paddingValue, paddingValue, paddingValue / 2),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                event.mainEvent['name'],
                                style: TextStyle(
                                    fontSize: FontSizes.xl(context),
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.tsnBlack),
                              ),
                            ),
                          ),
                          Padding(
                              padding: EdgeInsets.fromLTRB(paddingValue, 0,
                                  paddingValue, paddingValue / 2),
                              child: Row(children: [
                                Icon(Icons.av_timer, color: AppColors.tsnBlack),
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(event.formattedEventTime,
                                        style: TextStyle(
                                          color: AppColors.tsnBlack,
                                          fontSize: FontSizes.s(context),
                                        )))
                              ])),
                          Padding(
                              padding: EdgeInsets.fromLTRB(paddingValue, 0,
                                  paddingValue, paddingValue / 2),
                              child: Row(children: [
                                Icon(Icons.monetization_on,
                                    color: AppColors.tsnGreen),
                                Expanded(
                                    child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                            (double.parse(event.price[
                                                                'amount']) /
                                                            100)
                                                        .toStringAsFixed(2) !=
                                                    '0.00'
                                                ? (double.parse(event
                                                            .price['amount']) /
                                                        100)
                                                    .toStringAsFixed(2)
                                                : 'FREE',
                                            style: TextStyle(
                                              color: AppColors.tsnBlack,
                                              fontSize: FontSizes.s(context),
                                            ))))
                              ])),
                          Padding(
                              padding: EdgeInsets.fromLTRB(paddingValue, 0,
                                  paddingValue, paddingValue / 2),
                              child: Row(children: [
                                Icon(Icons.location_on,
                                    color: AppColors.tsnGreen),
                                Expanded(
                                    child: GestureDetector(
                                        onTap: () => BaseCommand()
                                            .launchLocationInBrowser(
                                                event.fieldLocations[0]
                                                    ['location']['latitude'],
                                                event.fieldLocations[0]
                                                    ['location']['longitude']),
                                        child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                                event.fieldLocations[0]
                                                    ['location']['address'],
                                                style: TextStyle(
                                                  color: AppColors.tsnGreen,
                                                  fontSize:
                                                      FontSizes.s(context),
                                                )))))
                              ])),
                          Padding(
                              padding: EdgeInsets.fromLTRB(paddingValue, 0,
                                  paddingValue, paddingValue / 2),
                              child: Row(children: [
                                Icon(Icons.grass_rounded,
                                    color: AppColors.tsnBlack),
                                Text("Field: "),
                                Expanded(
                                    child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                            event.fieldLocations[0]
                                                ['fieldLocationName'],
                                            style: TextStyle(
                                              color: AppColors.tsnBlack,
                                              fontSize: FontSizes.s(context),
                                            ))))
                              ])),
                          Padding(
                              padding: EdgeInsets.fromLTRB(paddingValue, 0,
                                  paddingValue, paddingValue / 2),
                              child: Row(children: [
                                Icon(Icons.person, color: AppColors.tsnBlack),
                                Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        0, 0, paddingValue, paddingValue / 2),
                                    child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                            "Host: " +
                                                event.organizers[0]['name']
                                                    .toString(),
                                            style: TextStyle(
                                              color: AppColors.tsnBlack,
                                              fontSize: FontSizes.s(context),
                                            )))),
                              ])),
                          Padding(
                              padding: EdgeInsets.fromLTRB(paddingValue, 0,
                                  paddingValue, paddingValue / 2),
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                      "Game Capacity: " +
                                          event.capacity.toString(),
                                      style: TextStyle(
                                        color: AppColors.tsnBlack,
                                        fontSize: FontSizes.m(context),
                                      )))),

                          if (event.isMine || isSuperUser)
                            Padding(
                                padding: EdgeInsets.fromLTRB(
                                    paddingValue,
                                    paddingValue,
                                    paddingValue,
                                    paddingValue / 2),
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        
                                        PriceWidget(
                                            price: event.price,
                                            teamPrice: false,
                                            eventPrice: true,
                                            amountPaid: event.amountPaid,
                                            amountRemaining:
                                                event.amountRemaining,
                                            isMine: event.isMine,
                                            isMember: event.isMember)
                                      ],
                                    ))),
                                    if (event.isMine || isSuperUser)
                                    BasicElevatedButton(
                                            backgroundColor: AppColors.tsnRed,
                                            text: "DELETE",
                                            fontSize: FontSizes.xxs(context),
                                            onPressed: () async {
                                              showDialog(
                                                context: context, 
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialogueWidget(
                                                    title: 'Confirmation',
                                                    body:
                                                        "Are you Sure you want to delete this Event??????",
                                                    onConfirmCallback:
                                                        () async {
                                                      // Logic for confirmation action
                                                      await EventCommand()
                                                          .deleteEvent({
                                                        "eventId": event
                                                            .mainEvent['_id']
                                                      });
                                                    },
                                                    onCancelCallback: () {
                                                      // Logic for cancel action
                                                    },
                                                  );
                                                },
                                              );
                                            }),

                          if (((event.isMine || isSuperUser) && event.payments.length > 0))
                            Padding(
                                padding: EdgeInsets.fromLTRB(
                                    paddingValue,
                                    paddingValue,
                                    paddingValue,
                                    paddingValue / 2),
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: PaymentListWidget(
                                      payments: event.payments,
                                    ))),

                          // Container(
                          //   margin: const EdgeInsets.all(10.0),
                          //   color: Colors.amber[600],
                          //   width: MediaQuery.of(context).size.width -
                          //       (MediaQuery.of(context).size.width *
                          //           .1), //10% padding
                          //   height: 200.0,
                          //   child: MyMapPage(
                          //     latitude: event.fieldLocations.length > 0
                          //         ? event.fieldLocations[0]['location']['latitude']
                          //         : 0.0,
                          //     longitude: event.fieldLocations.length > 0
                          //         ? event.fieldLocations[0]['location']['longitude']
                          //         : 0.0,
                          //   ),
                          // ),
                          // eventRequestJoin,
                          // eventPaymentJoin,
                          // teamRequestJoin,
                          // teamPaymentJoin,
                          // IconButton(
                          //   icon: const Icon(
                          //     Icons.share,
                          //     color: Colors.blue,
                          //   ),
                          //   onPressed:() async{
                          //     await EventCommand().onTapShare(mainEvent['mainImageKey']);
                          //   },
                          // ),
                          // IconButton(
                          //   icon: const Icon(
                          //     Icons.social_distance,
                          //     color: Colors.red,
                          //   ),
                          //   onPressed: () async {
                          //     await EventCommand().onTapSocialMediaApp(context);
                          //   },
                          // ),
                          //date
                          // EventDateWidget(
                          //     canEdit: isMine,
                          //     startTime: mainEvent['startTime'],
                          //     endTime: mainEvent['endTime']),
                          //Requests widget
                          // RequestsList(objectDetails: {
                          //   "requests": mainEvent['requests']['data']
                          // }),
                          //RSVP
                          // RSVPWidget(
                          //   event: mainEvent,
                          //   userParticipants: userParticipants,
                          // ),
                          //location search bar
                          // locationSearchBar = LocationSearchBar(
                          //     initialValue: mainEvent['location']['data'][0]
                          //         ['name']),
                          //player list
                          // if (event.hostAmenities.length > 0)
                          //   ConstrainedBox(
                          //     constraints: BoxConstraints(
                          //       maxHeight: 300, // You can adjust this height
                          //     ),
                          //     child:
                          //     ImageSelectionWidget(
                          //       viewMode: true,
                          //       selectionList: event.hostAmenities,
                          //       onSelectionChanged: (newSelection) {
                          //         setState(() {
                          //           // selectedAmenities = newSelection;
                          //         });
                          //       },
                          //     ),
                          //   ),
                          // if (event.fieldAmenities.length > 0)
                          // ConstrainedBox(
                          //   constraints: BoxConstraints(
                          //     maxHeight: 300, // You can adjust this height
                          //   ),
                          //   child: ImageSelectionWidget(
                          //     viewMode: true,
                          //     selectionList: event.fieldAmenities,
                          //     onSelectionChanged: (newSelection) {
                          //       setState(() {
                          //         // selectedAmenities = newSelection;
                          //       });
                          //     },
                          //   ),
                          // ),
                          PlayerList(
                            event: event.mainEvent,
                            team: null,
                            userParticipants: widget.modifiedParticipantList(
                                event.userParticipants,
                                event.payments,
                                event.price['amount']),
                            inviteUserToChat: (final userId) async =>
                                widget.onTapShowChatBottomSheet(
                                    context: context,
                                    chatList: event.chats,
                                    userId: userId),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(paddingValue,
                                paddingValue, paddingValue, paddingValue / 2),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: ListNotes(
                                title: 'Play Steps',
                                notes: [
                                  'Register for the game to secure your participation',
                                  'Upon arrival, the coordinator will welcome you and provide you with a pinnie.',
                                  'Teams may be adjusted for balanced gameplay.',
                                  'Each player will have a turn as the goalkeeper.'
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(paddingValue,
                                paddingValue, paddingValue, paddingValue / 2),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: ListNotes(
                                title: 'Important Info',
                                notes: [
                                  'Ensure to withdraw your participation at least 24 hours prior to the game for a full refund.',
                                  'In the event of game cancellation, all participants will receive a refund.',
                                  'Games will be called off in case of hazardous weather conditions, such as extreme storms.',
                                  'Please note that The Soccer Network does not offer player insurance. Participation in events is at your own risk.',
                                  'We accept only card payments for registrations.'
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(paddingValue,
                                paddingValue, paddingValue, paddingValue / 2),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: ListNotes(
                                title: 'What is The Soccer Network',
                                notes: [
                                  'The Soccer Network is a platform that connects soccer players and organizers.',
                                  "We're dedicated to making soccer more accessible and enjoyable for everyone."
                                      "Encouraging active participation in soccer, fostering health, and community engagement"
                                ],
                              ),
                            ),
                          ),

                          //team list
                          // TeamsListWidget(
                          //     user: null, mainEvent: mainEvent, teams: teams),
                          //player request widget
                          //maybe add this????
                          // SendPlayersRequestWidget(
                          //     mainEvent: mainEvent,
                          //     team: null,
                          //     players: players,
                          //     isMine: isMine),
                          //team request widget
                          // SendTeamsRequestWidget(
                          //   mainEvent: mainEvent,
                          //   isMine: isMine,
                          //   teams: teams,
                          //   addTeamCallback: EventCommand().addTeamCallback,
                          // ),
                          //chat widget
                          // GetChatWidget(
                          //     mainEvent: mainEvent,
                          //     team: null,
                          //     players: players,
                          //     isMine: isMine,
                          //     updatechatsList: updateChatsList),
                          // ChatsListWidget(
                          //   chats: chats,
                          // ),
                          // Player price widget

                          //Team price widget
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //   children: [
                          //     PriceWidget(
                          //         price: price,
                          //         teamPrice: true,
                          //         eventPrice: false,
                          //         amountPaid: teamAmountPaid,
                          //         amountRemaining: teamAmountRemaining,
                          //         isMine: isMine,
                          //         isMember: isMember)
                          //   ],
                          // ),

                          // const SizedBox(height: 60),
                          // ImagesListWidget(
                          //     mainEvent: mainEvent,
                          //     team: null,
                          //     imageFor: Constants.EVENT),
                          const SizedBox(height: 100),
                        ],
                      ),
                    ),
                  ),
                  bottomNavigationBar: Padding(
                    padding: const EdgeInsets.only(
                        top: 26.0, bottom: 16.0, left: 16.0, right: 16.0),
                    child: //join widget
                        GetJoinEventWidget(
                      mainEvent: event.mainEvent,
                      roles: event.roles,
                      isMine: event.isMine,
                      price: event.price,
                      amountRemaining: event.amountRemaining,
                      eventRequestJoin: event.eventRequestJoin,
                      eventPaymentJoin: event.eventPaymentJoin,
                      teamRequestJoin: event.teamRequestJoin,
                      teamPaymentJoin: event.teamPaymentJoin,
                      capacity: event.capacity,
                      numberOfPlayers: event.numberOfParticipants,
                      fieldRating: event.fieldRating,
                      hostRating: event.hostRating,
                    ),
                  ),
                );
        },
      ),
    );
  }
}
