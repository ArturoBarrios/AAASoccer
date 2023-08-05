import 'dart:io';

import 'package:flutter/material.dart';

import 'bottom_text_box.dart';

class ImagePreviewForUpload extends StatelessWidget {
  const ImagePreviewForUpload({
    Key? key,
    this.imagePath,
    this.onTapSend,
    this.onTapAttachment,
    this.onTapCancel,
    this.messageController,
    this.isLoading = false,
  }) : super(key: key);

  final TextEditingController? messageController;
  final String? imagePath;
  final VoidCallback? onTapSend;
  final VoidCallback? onTapAttachment;
  final VoidCallback? onTapCancel;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          imagePath != null
              ? Image.file(
                  File(imagePath ?? ''),
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.contain,
                )
              : Container(),
          Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: BottomTextBox(
              onTapAttachment: onTapAttachment,
              isLoading: isLoading,
              messageController: messageController,
              onTapSend: onTapSend,
            ),
          ),
          Positioned(
            top: 20,
            right: 0,
            child: GestureDetector(
              onTap: onTapCancel,
              child: const SizedBox(
                height: 40,
                width: 40,
                child: Icon(
                  Icons.cancel,
                  color: Colors.blue,
                  size: 40,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
