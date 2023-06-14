import 'package:flutter/material.dart';

import '../../components/headers.dart';

class MyImagesView extends StatefulWidget {
  const MyImagesView({Key? key})
      : super(key: key);

  @override
  _MyImagesViewState createState() => _MyImagesViewState();
}

class _MyImagesViewState extends State<MyImagesView> {
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
    return Scaffold(
      appBar: Headers().getBackHeader(context, "Images"),
      body: _isLoading
          ? Text("Loading...")
          : GridView.builder(
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
    );
  }
}
