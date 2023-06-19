import 'package:flutter/material.dart';

import '../../components/headers.dart';
import '../constants.dart';
import 'Dialogues/animated_dialogu.dart';
import 'Mixins/images_mixin.dart';

class ImagesListWidget extends StatefulWidget with ImagesMixin {
  ImagesListWidget({Key? key, required this.details})
      : super(key: key);

      final dynamic images;
      final dynamic details;



  @override
  _ImagesListWidgetState createState() => _ImagesListWidgetState();
}

class _ImagesListWidgetState extends State<ImagesListWidget> {
  bool _isLoading = true;
  dynamic images;

  void getImage() async{
    print("getImage");
    // Map<String, dynamic> imageResp = await ImagesCommand().getImages();
  }

  void goBack() {
    Navigator.pop(context);
  }

  void loadInitialData() {
    print("loadInitialData");
  }

  addImage(){

  }

  removeImage(){
    
  }

  @override
  void initState() {
    super.initState();
    print("initState");        
    _isLoading = false;
  }

  @override
Widget build(BuildContext context) {
  print("build()");
  return _isLoading
      ? Text("Loading...")
      : Center(
          child: Column(
            children: [
              GestureDetector(
      onTap: () async {
        List<dynamic> primaryList =
              widget.imageChoices.map((choice) => choice.values.first).toList();

          List<dynamic> secondaryList = [];
          Map<int, dynamic> result = await showDialog(
            context: context,
            builder: (BuildContext context) {
              return AnimatedDialog(
                  items: primaryList,
                  singleSelect: true,
                  secondaryItems: secondaryList);
            },
          );
          if (result.isNotEmpty) {
            print("result: " + result.toString());
            if(widget.details['mainEvent'] != null)
              widget.chooseImage({"for": Constants.EVENT, },result, primaryList, secondaryList);
            else if(widget.details['mainTeam'] != null)
              widget.chooseImage({"for": Constants.TEAM},result, primaryList, secondaryList);
            else
              widget.chooseImage({"for": Constants.USER},result, primaryList, secondaryList);
          }
        
      },
      child: Container(
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            'Add Image',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
        ),
      ),
    ),
              Container(
                height: 500, // specify the height as per your requirement
                child: GridView.builder(
                  itemCount: 16,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    mainAxisSpacing: 2.0,
                    crossAxisSpacing: 2.0,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        getImage();
                      },
                      child: Container(
                        margin: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color: Colors.amber[600],
                          image: DecorationImage(
                            image: NetworkImage('https://via.placeholder.com/150'), // Update this URL with your image url
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
}

}
