import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/pageModels/chat_page_model.dart';

class ChatGalleryView extends StatefulWidget {
  const ChatGalleryView({Key? key}) : super(key: key);

  @override
  State<ChatGalleryView> createState() => _ChatGalleryViewState();
}

class _ChatGalleryViewState extends State<ChatGalleryView> {
  @override
  Widget build(BuildContext context) {
    final images = context
        .select<ChatPageModel, List>((value) => value.messages)
        .where((e) => e['imageObject'] != null)
        .map((e) => e['imageObject']['url'])
        .toList()
        .reversed
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Gallery'),
      ),
      body: ListView.separated(
        itemCount: images.length,
        padding: const EdgeInsets.only(top: 16),
        separatorBuilder: (context, index) => const SizedBox(height: 10),
        itemBuilder: (context, index) {
          return Align(
            alignment: Alignment.centerLeft,
            child: Column(
              children: [
                Image.network(
                  images[index] ?? '',
                  height: 200,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
