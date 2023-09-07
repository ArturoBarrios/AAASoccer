class ChatItem {
  String? text;
  String? imageUrl;
  bool isOwner;

  ChatItem({
    this.text,
    this.imageUrl,
    this.isOwner = true,
  });
}
