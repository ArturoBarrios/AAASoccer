import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';

import '../../commands/event_command.dart';
import '../../components/Mixins/event_mixin.dart';
import '../../components/headers.dart';
import '../../components/my_map_page.dart';
import '../../constants.dart';

class TryoutView extends StatefulWidget with EventMixin {
   TryoutView(
    { Key? key, required this.userEventDetails, required this.tryout })
    : super(key: key);

    final dynamic userEventDetails;
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
  


  bool _isLoading = false;

  void goBack(){
    Navigator.pop(context);
  }

  dynamic priceObject;


  void loadEventPayment() {
    priceObject = widget.tryout['event']['price'];
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

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Headers().getBackHeader(context, widget.tryout['event']['name']),
      body: _isLoading 
      ? Text("Loading...")
      : ListView(
        padding: EdgeInsets.all(16),
        children: [
          Container(
                  margin: const EdgeInsets.all(10.0),
                  color: Colors.amber[600],
                  width: MediaQuery.of(context).size.width -
                      (MediaQuery.of(context).size.width * .1), //10% padding
                  height: 200.0,
                  child: MyMapPage(
                      latitude: widget.tryout['event']['location']['data'][0]
                          ['latitude'],
                      longitude: widget.tryout['event']['location']['data'][0]
                          ['longitude']),
                ),









          
          
            !widget.userEventDetails['isMyEvent'] ? 
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
                        await widget.sendEventRequest(widget.tryout);
                      },
                      child: Text("Send Request")),
                ),
              ) :
              Container(),
               Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    widget.getPriceWidget(widget.userEventDetails),
                    // Text(
                    //     "Price: \$${(double.parse(priceObject['amount']) / 100).toStringAsFixed(2)}"),
                    widget.userEventDetails['isMyEvent']
                        ? ElevatedButton(
                            onPressed: () {
                              // Add button onPressed logic here
                            },
                            child: Text('Update Payment'),
                          )
                        : Container(),
                  ],
                ),
                widget.getJoinGameWidget(context, widget.userEventDetails, widget.tryout['event'], widget.userObject),
                widget.getChatWidget(context, true, false),
        
     




        ]
      )
      
    );
  }
}
