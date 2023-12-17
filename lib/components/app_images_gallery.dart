import 'package:flutter/material.dart';

class AppImagesGallery extends StatefulWidget {
  const AppImagesGallery({
    Key? key,
    required this.imagesUrls,
  }) : super(key: key);

  final List<String> imagesUrls;

  @override
  State<AppImagesGallery> createState() => _AppImagesGalleryState();
}

class _AppImagesGalleryState extends State<AppImagesGallery> {
  int? indexSelected;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        actions: [
          if (indexSelected != null)
            TextButton(
              style: TextButton.styleFrom(foregroundColor: Colors.black),
              onPressed: () {
                Navigator.pop(context, indexSelected!);
              },
              child: const Text('Confirm'),
            )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
            itemCount: widget.imagesUrls.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              crossAxisCount: 2,
            ),
            itemBuilder: (_, int index) {
              final imageUrl = widget.imagesUrls[index];
              bool selected = index == indexSelected;
              return InkWell(
                onTap: () {
                  setState(() {
                    indexSelected = index;
                  });
                },
                child: GridTile(
                  child: Container(
                    decoration: BoxDecoration(
                      border: selected
                          ? Border.all(
                              color: Colors.blue,
                              width: 3,
                            )
                          : null,
                    ),
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
