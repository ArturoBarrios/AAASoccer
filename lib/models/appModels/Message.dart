import '../enums/MessageType.dart';
import 'Chat.dart';
import 'TextContent.dart';
import 'GifContent.dart';
import 'Image.dart';
import 'User.dart';

class Message {
  Chat? chatObject;
  TextContent? textObject;
  GifContent? gifObject;
  Image? imageObject;
  User? sender;
  MessageType? messageType;
  List<User>? forUsers;

  Message({
    this.chatObject,
    this.textObject,
    this.gifObject,
    this.imageObject,
    this.sender,
    this.messageType,
    this.forUsers,
  });
}
