import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:soccermadeeasy/components/Mixins/images_mixin.dart';
import '../../commands/event_command.dart';
import '../../commands/images_command.dart';
import '../../components/Loading/loading_screen.dart';
import '../../components/Mixins/event_mixin.dart';
import '../../components/Mixins/payment_mixin.dart';
import '../../components/headers.dart';
import '../../components/my_map_page.dart';
import '../../components/object_profile_main_image.dart';
import '../../components/update_view_form.dart';
import '../../constants.dart';
import '../../models/pageModels/event_page_model.dart';

class TrainingView extends StatefulWidget with EventMixin, ImagesMixin {
  TrainingView({Key? key, required this.training}) : super(key: key);

  final dynamic training;

  @override
  _TrainingViewState createState() => _TrainingViewState();
}

class _TrainingViewState extends State<TrainingView> {
  final nameController = TextEditingController();
  final imageController = TextEditingController();
  final secondaryNameController = TextEditingController();
  final addressController = TextEditingController();
  final surfaceController = TextEditingController();
  final fieldSizeController = TextEditingController();
  final privateController = TextEditingController();

  dynamic userEventDetails;
  String imageUrl = "";
  dynamic objectImageInput = {
    "imageUrl": "",
    "containerType": Constants.IMAGEBANNER,
    "mainEvent": null,
    "isMyEvent": false
  };

  bool _isLoading = true;

  void updateChatsList(dynamic createdChat) {
    setState(() {
      userEventDetails['mainEvent']['chats']['data'].add(createdChat);
    });
  }

  void goBack() {
    Navigator.pop(context);
  }

  dynamic priceObject;

  void loadEventPayment() {
    priceObject = widget.training['price'];
  }

  Future<void> loadInitialData() async {
    print("loadInitialData");
    loadEventPayment();
    widget.setupPlayerList();
    dynamic getEventDetailsResp =
        await EventCommand().getUserEventDetails([widget.training]);
    userEventDetails = getEventDetailsResp;
    print("getEventDetailsResp: " + userEventDetails.toString());
    //setup image
    objectImageInput = await widget.loadEventMainImage(userEventDetails);
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
    print("training: " + widget.training.toString());
    loadInitialData();
  }

  @override
  Widget build(BuildContext context) {
    dynamic mainEvent =
        context.select<EventPageModel, dynamic>((value) => value.mainEvent);
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
    List chats = context.watch<EventPageModel>().chats;


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
                !userEventDetails['isMine']
                    ? Container(
                        height: 20,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: GestureDetector(
                              onTap: () async {
                                print("onTap: ");
                                List<int>? requestIndexes =
                                    await showAnimatedDialog<dynamic>(
                                  context: context,
                                  barrierDismissible: true,
                                  builder: (BuildContext context) {
                                    return ClassicListDialogWidget<dynamic>(
                                        selectedIndexes:
                                            widget.selectedRequestTypeIndexes,
                                        titleText: 'Choose User Type',
                                        positiveText: "Send Request",
                                        listType: ListType.multiSelect,
                                        activeColor: Colors.green,
                                        dataList: widget.requestUserTypes);
                                  },
                                  animationType: DialogTransitionType.size,
                                  curve: Curves.linear,
                                );

                                widget.selectedRequestTypeIndexes =
                                    requestIndexes ??
                                        widget.selectedRequestTypeIndexes;
                                print(
                                    'selectedIndex:${widget.selectedRequestTypeIndexes?.toString()}');
                                await widget.requestTypeSelected(
                                    widget.selectedRequestTypeIndexes);
                                await widget.sendEventRequest(widget.training,
                                    {0: {}}, widget.requestUserTypes, []);
                              },
                              child: Text("Send Request")),
                        ),
                      )
                    : Container(),

                // UpdateViewForm(userObjectDetails: userEventDetails)
                //    Row(
                //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //       children: [
                //         widget.getPriceWidget(widget.userEventDetails),
                //         // Text(
                //         //     "Price: \$${(double.parse(priceObject['amount']) / 100).toStringAsFixed(2)}"),
                //         widget.userEventDetails['isMine']
                //             ? ElevatedButton(
                //                 onPressed: () {
                //                   // Add button onPressed logic here
                //                 },
                //                 child: Text('Update Payment'),
                //               )
                //             : Container(),
                //       ],
                //     ),
                //     widget.getJoinGameWidget(context, widget.userEventDetails, widget.training['event'], widget.userObject),
                //     widget.getChatWidget(context, true, false, widget.userEventDetails, updateChatsList),

                //     widget.userEventDetails['isMine']
                // ? widget.sendPlayersRequestWidget(context, widget.userEventDetails)
                // : widget.sendOrganizerPlayerEventRequest(context, widget.userEventDetails),
              ]));
  }
}
