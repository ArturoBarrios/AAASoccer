import 'package:flutter/material.dart';
// import '../../components/profile.dart';
// import '../../components/payment_screen.dart';
// import '../../components/card_form_screen.dart';
// import '../../components/Cards/chat_card.dart';
import 'package:soccermadeeasy/components/Mixins/images_mixin.dart';
// import 'create.dart';

class BottomTextBox extends StatefulWidget {
  const BottomTextBox({
    Key? key,
    this.onTapSend,
    this.onTapAttachment,
    this.messageController,
    this.isLoading = false,
  }) : super(key: key);

  final VoidCallback? onTapSend;
  final VoidCallback? onTapAttachment;
  final TextEditingController? messageController;
  final bool isLoading;

  @override
  State<BottomTextBox> createState() => _BottomTextBoxState();
}

class _BottomTextBoxState extends State<BottomTextBox> with ImagesMixin {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Align(
          alignment: Alignment.bottomLeft,
          child: Container(
            padding: const EdgeInsets.only(
              left: 10,
            ),
            width: double.infinity,
            color: Colors.white,
            child: Row(
              children: [
                GestureDetector(
                  onTap: widget.onTapAttachment,
                  child: Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      color: Colors.lightBlue,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: widget.isLoading
                        ? const CircularProgressIndicator(
                            color: Colors.red,
                          )
                        : const Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 20,
                          ),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: TextField(
                    controller: widget.messageController,
                    decoration: const InputDecoration(
                        hintText: "Write message...",
                        hintStyle: TextStyle(color: Colors.black54),
                        border: InputBorder.none),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                SizedBox(
                  height: 60,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: FloatingActionButton(
                      onPressed: widget.onTapSend,
                      backgroundColor: Colors.blue,
                      elevation: 0,
                      child: const Icon(
                        Icons.send,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
