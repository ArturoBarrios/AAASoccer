import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../commands/event_command.dart';
import '../../components/Loading/loading_screen.dart';
import '../../components/Mixins/event_mixin.dart';
import '../../components/Mixins/payment_mixin.dart';
import '../../components/headers.dart';
import '../../components/my_map_page.dart';
import '../../components/update_view_form.dart';
import '../../constants.dart';

class TrainingView extends StatefulWidget with EventMixin {
  TrainingView(
    {Key? key, required this.training })
    : super(key: key);
    
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


  bool _isLoading = true;

  void updateChatsList(dynamic createdChat){
    setState(() {
      userEventDetails['mainEvent']['chats']['data'].add(createdChat);      
    });
  }

  void goBack(){
    Navigator.pop(context);
  }

  dynamic priceObject;


  void loadEventPayment() {
    priceObject = widget.training['event']['price'];
  }

  
  Future<void> loadInitialData() async{
    print("loadInitialData");
    loadEventPayment();    
    widget.setupPlayerList();    
    dynamic getEventDetailsResp = await EventCommand().getUserEventDetails([widget.training['event']]);
    print("getEventDetailsResp: " + getEventDetailsResp.toString());
    //wait for 3 seconds
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      userEventDetails = getEventDetailsResp;
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
    print("TrainingView build() widget.training: "+ widget.training.toString());

    return Scaffold(
      appBar: Headers().getBackHeader(context, widget.training['event']['name']),
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
      : ListView(
        padding: EdgeInsets.all(16),
        children: [
          // Container(
          //         margin: const EdgeInsets.all(10.0),
          //         color: Colors.amber[600],
          //         width: MediaQuery.of(context).size.width -
          //             (MediaQuery.of(context).size.width * .1), //10% padding
          //         height: 200.0,
          //         child: MyMapPage(
          //             latitude: widget.training['event']['location']['data'][0]
          //                 ['latitude'],
          //             longitude: widget.training['event']['location']['data'][0]
          //                 ['longitude']),
          //       ),









          
          
            !userEventDetails['isMine'] ? 
            Container(
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
                                selectedIndexes: widget.selectedRequestTypeIndexes,
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
                            requestIndexes ?? widget.selectedRequestTypeIndexes;
                        print(
                            'selectedIndex:${widget.selectedRequestTypeIndexes?.toString()}');
                        await widget.requestTypeSelected(widget.selectedRequestTypeIndexes);
                        await widget.sendEventRequest(widget.training, {0: {}}, widget.requestUserTypes, []);
                      },
                      child: Text("Send Request")),
                ),
              ) :
              Container(),

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
            //     widget.getJoinGameWidget(context, widget.userEventDetails, widget.training['event'], widget.userObject),
            //     widget.getChatWidget(context, true, false, widget.userEventDetails, updateChatsList),

            //     widget.userEventDetails['isMine']
            // ? widget.sendPlayersRequestWidget(context, widget.userEventDetails)
            // : widget.sendOrganizerPlayerEventRequest(context, widget.userEventDetails),
        
     




        ]
      )
      
    );
  }
}
