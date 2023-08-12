import 'package:flutter/material.dart';
import 'package:soccermadeeasy/extensions/check_string_if_url.dart';

class ChatBuble extends StatelessWidget {
  const ChatBuble({
    Key? key,
    this.imageUrl,
    this.text,
    this.isOwner = true,
  }) : super(key: key);

  final String? imageUrl;
  final String? text;
  final bool isOwner;

  static const double _messageSize = 1.5;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: isOwner ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin:
            EdgeInsets.only(right: isOwner ? 10 : 0, left: isOwner ? 0 : 10),
        padding: const EdgeInsets.all(10),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width / _messageSize,
        ),
        decoration: BoxDecoration(
          color: isOwner ? Colors.blue[200] : Colors.grey.shade200,
          borderRadius: BorderRadius.only(
            bottomLeft: isOwner
                ? const Radius.circular(
                    10,
                  )
                : Radius.zero,
            bottomRight: isOwner
                ? Radius.zero
                : const Radius.circular(
                    10,
                  ),
            topLeft: const Radius.circular(
              10,
            ),
            topRight: const Radius.circular(
              10,
            ),
          ),
        ),
        child: Column(
          children: [
            if (imageUrl.isValidUrl())
              Image.network(
                imageUrl ?? '',
                height: 100,
                width: 100,
                fit: BoxFit.cover,
              ),
            if (text != null && (text?.isNotEmpty ?? false))
              Text(
                text ?? '',
                style: const TextStyle(fontSize: 15),
              ),
          ],
        ),
      ),
    );
  }
}
