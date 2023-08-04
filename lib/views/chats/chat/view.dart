import 'package:flutter/material.dart';
import 'package:soccermadeeasy/components/chat_buble.dart';
import 'package:soccermadeeasy/models/chat_item.dart';
import '../../../commands/chat_command.dart';
import '../../../commands/images_command.dart';
import '../../../components/Loading/loading_screen.dart';
import 'package:soccermadeeasy/extensions/snackbar_dialogue.dart';
import '../../../components/image_preview_for_upload.dart';
import '../../../constants.dart';
// import '../../components/payment_screen.dart';
// import '../../components/card_form_screen.dart';
import '../../../commands/user_command.dart';
import '../../../models/chat_page_model.dart';
import 'package:provider/provider.dart';
import '../../../components/headers.dart';
import '../../../components/bottom_text_box.dart';
// import 'create.dart';

class ChatView extends StatefulWidget {
  const ChatView({Key? key, required this.chatObject}) : super(key: key);
  final Map<String, dynamic> chatObject;

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  final nameController = TextEditingController();
  final imageController = TextEditingController();
  final secondaryNameController = TextEditingController();
  final addressController = TextEditingController();
  final surfaceController = TextEditingController();
  final fieldSizeController = TextEditingController();
  final privateController = TextEditingController();
  final messageController = TextEditingController();
  String? selectedImagePath;

  dynamic user = {};

  List<Map<String, dynamic>> chatUsers = [
    {"messageContent": "Hello, Will", "messageType": "receiver"},
    {"messageContent": "How have you been?", "messageType": "sender"},
  ];

  bool _isLoading = true;
  bool _isLoadingImage = false;
  late ScrollController scrollController = ScrollController();

  dynamic chatMessages = [];

  @override
  void initState() {
    print("chats/chat/view.dart init state");
    print("widget.chatObject: ${widget.chatObject}");
    super.initState();
    loadInitialData();
  }

  void goBack() {
    Navigator.pop(context);
  }

  Future<void> loadInitialData() async {
    print("first load for chat data");
    dynamic findMyUserByIdResp = await UserCommand().findMyUserById();
    print("findMyUserByIdResp: $findMyUserByIdResp");
    dynamic newUser = findMyUserByIdResp['data'];

    setState(() {
      user = newUser;
      _isLoading = false;
    });
  }

  void sendMessage() async {
    String? signedUrl;
    if (selectedImagePath != null) {
      signedUrl = await uploadImageForChat();
    }

    dynamic currentUser = UserCommand().getAppModelUser();
    dynamic messageInput = {
      "content": messageController.text.toString(),
      "chat_id": widget.chatObject['_id'],
      "sender_id": currentUser['_id'],
      "image_url": signedUrl,
    };
    Map<String, dynamic> sendMessageResp =
        await ChatCommand().createText(messageInput);
    if (sendMessageResp['success']) {
      dynamic chat = sendMessageResp['data'];
      ChatCommand().updateChatModel(chat);
      print("createTextResp: $sendMessageResp");
      if (sendMessageResp['success']) {
        setState(() {
          messageController.text = "";
          selectedImagePath = null;
        });
      }
    }
  }

  toggleLoading(final value) {
    setState(() {
      _isLoadingImage = value;
    });
  }

  Future<String?> uploadImageForChat() async {
    toggleLoading(true);
    final uploadResult = await ImagesCommand().uploadImage(selectedImagePath);
    final signedUrl =
        await ImagesCommand().getImage(uploadResult['data']['key']);

    toggleLoading(false);

    return signedUrl['data']['signedUrl'];
  }

  Future pickImageFromDevice({final bool isCamera = true}) async {
    selectedImagePath = await ImagesCommand().pickImageFromDevice(
      isCamera ? Constants.CAMERA : Constants.PHONEGALLERY,
    );
    setState(() {});
  }

  Future _showAttachmentOptions(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera),
              title: const Text('Camera'),
              onTap: () async {
                Navigator.of(context).pop();

                return pickImageFromDevice();
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo),
              title: const Text('Gallery'),
              onTap: () async {
                Navigator.of(context).pop();

                return pickImageFromDevice(isCamera: false);
              },
            ),
          ],
        );
      },
    );
  }

  void onTapCancel() {
    setState(() {
      selectedImagePath = null;
      messageController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final messages = context
        .select<ChatPageModel, List>((value) => value.messages)
        .map((e) => ChatItem(
              text: e['textObject']['content'] ?? '',
              imageUrl: e['imageObject'] != null ? e['imageObject']['url'] : '',
              isOwner: e['sender']['_id'] == user['_id'],
            ))
        .toList()
        .reversed
        .toList();

    return WillPopScope(
      onWillPop: () async {
        if (selectedImagePath != null) {
          ScaffoldMessenger.of(context).show(
            type: SnackBarType.failure,
            message: 'Are you sure?',
            buttonText: 'Yes',
            onTap: () {
              ScaffoldMessenger.of(this.context).hideCurrentSnackBar();

              onTapCancel();
            },
          );

          return false;
        }
        return true;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: selectedImagePath == null,
        appBar: const Headers().getChatDetailHeader(context, widget.chatObject),
        body: _isLoading
            ? const SizedBox(
                height: double.infinity,
                width: double.infinity,
                child: Align(
                    alignment: Alignment.center,
                    child:
                        // BottomNav()//for times when user deleted in cognito but still signed into app
                        LoadingScreen(
                            currentDotColor: Colors.white,
                            defaultDotColor: Colors.black,
                            numDots: 10)))
            : (selectedImagePath != null)
                ? ImagePreviewForUpload(
                    onTapAttachment: () => _showAttachmentOptions(context),
                    isLoading: _isLoadingImage,
                    messageController: messageController,
                    onTapSend: () {
                      sendMessage();
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                    onTapCancel: onTapCancel,
                    imagePath: selectedImagePath,
                  )
                : Column(
                    children: [
                      // Text("messagesLength: $messagesLength"),
                      Expanded(
                        child: ListView.separated(
                            controller: scrollController,
                            itemCount: messages.length,
                            shrinkWrap: true,
                            reverse: true,
                            padding: const EdgeInsets.only(top: 10, bottom: 10),
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 10),
                            itemBuilder: (_, index) {
                              return ChatBuble(
                                text: messages[index].text,
                                imageUrl: messages[index].imageUrl,
                                isOwner: messages[index].isOwner,
                              );
                            }),
                      ),
                      BottomTextBox(
                        onTapAttachment: () => _showAttachmentOptions(context),
                        isLoading: _isLoadingImage,
                        messageController: messageController,
                        onTapSend: () {
                          sendMessage();
                          FocusManager.instance.primaryFocus?.unfocus();
                        },
                      ),
                    ],
                  ),
      ),
    );
  }
}
