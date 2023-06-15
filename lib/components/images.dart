import 'package:flutter/material.dart';

import '../../components/headers.dart';

class ImagesWidget extends StatefulWidget {
  const ImagesWidget({Key? key, dynamic images})
      : super(key: key);



  @override
  _ImagesWidgetState createState() => _ImagesWidgetState();
}

class _ImagesWidgetState extends State<ImagesWidget> {
  bool _isLoading = true;

  void getImage() async{
    print("getImage");
    // Map<String, dynamic> imageResp = await ImagesCommand().getImages();
  }

  void goBack() {
    Navigator.pop(context);
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
    return 
    _isLoading
          ? Text("Loading...") 
          : SingleChildScrollView(
        child: Center(
            child: Expanded(
                child: Column(children: [
          GridView.builder(
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
            )]))));
  }
}
