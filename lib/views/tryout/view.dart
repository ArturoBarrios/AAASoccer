import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:provider/provider.dart';
import 'package:soccermadeeasy/components/price_widget.dart';

import '../../commands/event_command.dart';
import '../../components/Loading/loading_screen.dart';
import '../../components/Mixins/event_mixin.dart';
import '../../components/Mixins/images_mixin.dart';
import '../../components/chats_list_widget.dart';
import '../../components/event_date_widget.dart';
import '../../components/get_join_event_widget.dart';
import '../../components/headers.dart';
import '../../components/images_list_widget.dart';
import '../../components/join_condition.dart';
import '../../components/location_search_bar.dart';
import '../../components/my_map_page.dart';
import '../../components/object_profile_main_image.dart';
import '../../components/payment_list_widget.dart';
import '../../components/players_list_widget.dart';
import '../../components/requests_list.dart';
import '../../components/rsvp_widget.dart';
import '../../components/send_players_request_widget.dart';
import '../../components/send_teams_request_widget.dart';
import '../../components/teams_list_widget.dart';
import '../../components/update_view_form.dart';
import '../../constants.dart';
import '../../models/pageModels/event_page_model.dart';

class TryoutView extends StatefulWidget with EventMixin, ImagesMixin {
  TryoutView({Key? key, required this.event}) : super(key: key);

  final dynamic event;

  @override
  _TryoutViewState createState() => _TryoutViewState();
}

class _TryoutViewState extends State<TryoutView> {
  final nameController = TextEditingController();
  final imageController = TextEditingController();
  final secondaryNameController = TextEditingController();
  final addressController = TextEditingController();
  final surfaceController = TextEditingController();
  final fieldSizeController = TextEditingController();
  final privateController = TextEditingController();
  
LocationSearchBar locationSearchBar = new LocationSearchBar();
  

  bool _isLoading = true;

  void goBack() {
    Navigator.pop(context);
  }

  dynamic priceObject;

  void loadEventPayment() {
    priceObject = widget.event['price'];
  }

  List<int>? selectedRequestTypeIndexes;
  
  List<String> selectedRequestTypeObjects = [];

  Future<void> loadInitialData() async {
    print("loadInitialData");
    await EventCommand().getUserEventDetails([widget.event], true);
    
    widget.setupPlayerList();        
    
    //wait for 3 seconds
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      _isLoading = false;
      print("setState finished");
    });    
    print("loadInitialData finished");
  }

  @override
  void initState() {
    super.initState();
    print("initState");
    print("training: " + widget.event.toString());
    loadInitialData();
  }

  @override
  Widget build(BuildContext context) {
    dynamic mainEvent =
        context.select<EventPageModel, dynamic>((value) => value.mainEvent);
    dynamic objectImageInput = context.watch<EventPageModel>().objectImageInput;
    List<dynamic> roles =
        context.select<EventPageModel, List<dynamic>>((value) => value.roles);
    bool isMine = context.select<EventPageModel, bool>((value) => value.isMine);
    bool isMember =
        context.select<EventPageModel, bool>((value) => value.isMember);
    dynamic price =
        context.select<EventPageModel, dynamic>((value) => value.price);
    String amountRemaining = context
        .select<EventPageModel, String>((value) => value.amountRemaining);
    String amountPaid =
        context.select<EventPageModel, String>((value) => value.amountPaid);
    String teamAmountRemaining = context
        .select<EventPageModel, String>((value) => value.amountRemaining);
    String teamAmountPaid =
        context.select<EventPageModel, String>((value) => value.teamAmountPaid);
    List userParticipants =
        context.select<EventPageModel, List>((value) => value.userParticipants);
    List teams = context.select<EventPageModel, List>((value) => value.teams);
    List players =
        context.select<EventPageModel, List>((value) => value.players);
    List fieldLocations = context.watch<EventPageModel>().fieldLocations;
    List chats = context.watch<EventPageModel>().chats;
    List payments = context.watch<EventPageModel>().payments;
    JoinCondition eventRequestJoin = context.watch<EventPageModel>().eventRequestJoin;
    JoinCondition eventPaymentJoin = context.watch<EventPageModel>().eventPaymentJoin;
    JoinCondition teamRequestJoin = context.watch<EventPageModel>().teamRequestJoin;
    JoinCondition teamPaymentJoin = context.watch<EventPageModel>().teamPaymentJoin;
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(
              200.0), // You can adjust the height value as per your requirement.
          child: ObjectProfileMainImage(objectImageInput: objectImageInput),
        ),
        body: _isLoading
            ? Container(
                height: double.infinity,
                width: double.infinity,
                child: Align(
                  alignment: Alignment.center,
                  child:
                      // BottomNav()//for times when user deleted in cognito but still signed into app
                      LoadingScreen(
                          currentDotColor: Colors.white,
                          defaultDotColor: Colors.black,
                          numDots: 10),
                ),
              )
            : ListView(padding: EdgeInsets.all(16), children: [
              IconButton(
                  icon: const Icon(
                    Icons.share,
                    color: Colors.blue,
                  ),
                  onPressed: () async {
                    await EventCommand().onTapShare(mainEvent['mainImageKey']);
                  }
                ),
                IconButton(
                  icon: const Icon(
                    Icons.social_distance,
                    color: Colors.red,
                  ),
                  onPressed: () async {
                    await EventCommand().onTapSocialMediaApp(context); 
                  } 
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
                      (MediaQuery.of(context).size.width * .1), //10% padding
                  height: 200.0,
                  child: MyMapPage(
                       latitude: fieldLocations.length>0 ? 
                              fieldLocations[0]['location']['latitude']
                              : 0.0,
                            longitude: fieldLocations.length>0 ? 
                              fieldLocations[0]['location']['longitude']
                              : 0.0,)
                ),
                //join widget
                // GetJoinEventWidget(
                //     mainEvent: mainEvent,
                //     roles: roles,
                //     isMine: isMine,
                //     price: price,
                //     amountRemaining: amountRemaining,
                //     capacity: 10,
                //     numberOfPlayers: 5,
                //     ),
                //Requests widget
                RequestsList(
                    objectDetails: {"requests": mainEvent['requests']['data']}),
                //RSP
                RSVPWidget(
                  event: mainEvent,
                  userParticipants: userParticipants,
                ),
                //location search bar
                // locationSearchBar = LocationSearchBar(
                //     initialValue: mainEvent['location']['data'][0]['name']),
                //player list
                PlayerList(
                  event: mainEvent,
                  team: null,
                  userParticipants: widget.modifiedParticipantList(
                      userParticipants, payments, price['amount']),
                  inviteUserToChat: (final userId) async =>
                      widget.onTapShowChatBottomSheet(
                          context: context, chatList: chats, userId: userId),
                ),
                //team list
                TeamsListWidget(user: null, mainEvent: mainEvent, teams: teams),
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
                  addTeamCallback: EventCommand().addTeamCallback,
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
                        isMember: isMember)
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
                        isMember: isMember)
                  ],
                ),
                const SizedBox(height: 20),
                // PaymentListWidget(
                //   paidUsers: widget.getPaidUsers(userParticipants, payments),                
                // ),
                const SizedBox(height: 60),
                ImagesListWidget(
                    mainEvent: mainEvent,
                    team: null,
                    imageFor: Constants.EVENT),
                
              ]));
  }
}
