class Chat {
  String? name;
  List<Message>? messages;  // You will define this Message class similarly
  List<User>? users;  // You will define this User class similarly
  Event? event;  // You can use the Event class defined earlier
  Team? team;  // You will define this Team class similarly
  bool? archived;
  bool? isPrivate;
  bool? isMainChat;
  String? mainImageKey;
  List<Image>? images;  // You will define this Image class similarly

  Chat({
    this.name,
    this.messages,
    this.users,
    this.event,
    this.team,
    this.archived = false,  // Default value as per GraphQL schema
    this.isPrivate,
    this.isMainChat,
    this.mainImageKey,
    this.images,
  });
}
