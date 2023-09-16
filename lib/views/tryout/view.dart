import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:soccermadeeasy/components/price_widget.dart';

import '../../commands/event_command.dart';
import '../../components/Loading/loading_screen.dart';
import '../../components/Mixins/event_mixin.dart';
import '../../components/Mixins/images_mixin.dart';
import '../../components/headers.dart';
import '../../components/my_map_page.dart';
import '../../components/object_profile_main_image.dart';
import '../../components/update_view_form.dart';
import '../../constants.dart';

class TryoutView extends StatefulWidget with EventMixin, ImagesMixin {
  TryoutView({Key? key, required this.tryout}) : super(key: key);

  final dynamic tryout;

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

  dynamic userEventDetails;

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
    priceObject = widget.tryout['price'];
  }

  List<int>? selectedRequestTypeIndexes;
  List requestUserTypes = [
    Constants.PLAYER.toString(),
    Constants.ORGANIZER.toString(),
    Constants.MANAGER.toString(),
    Constants.MAINCOACH.toString(),
    Constants.ASSISTANTCOACH.toString(),
    Constants.REF.toString(),
  ];
  List<String> selectedRequestTypeObjects = [];

  Future<void> loadInitialData() async {
    print("loadInitialData");
    dynamic getEventDetailsResp =
        await EventCommand().getUserEventDetails([widget.tryout]);
    userEventDetails = getEventDetailsResp;
    widget.setupPlayerList();
    print("getEventDetailsResp: " + getEventDetailsResp.toString());
    //setup image
    objectImageInput = await widget.loadEventMainImage(userEventDetails);
    //wait for 3 seconds
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      _isLoading = false;
      print("setState finished");
    });
    loadEventPayment();
    print("loadInitialData finished");
  }

  @override
  void initState() {
    super.initState();
    print("initState");
    print("training: " + widget.tryout.toString());
    loadInitialData();
  }

  @override
  Widget build(BuildContext context) {
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
                                await widget.sendEventRequest(widget.tryout,
                                    {0: {}}, widget.requestUserTypes, []);
                              },
                              child: Text("Send Request")),
                        ),
                      )
                    : Container(),
                UpdateViewForm(userObjectDetails: userEventDetails)
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
                //     widget.getJoinGameWidget(context, widget.userEventDetails, widget.tryout['event'], widget.userObject),
                //     widget.getChatWidget(context, true, false, widget.userEventDetails, updateChatsList),

                //     widget.userEventDetails['isMine']
                // ? widget.sendPlayersRequestWidget(context, widget.userEventDetails)
                // : widget.sendOrganizerPlayerEventRequest(context, widget.userEventDetails),
              ]));
  }
}
