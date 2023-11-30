class ViewConversationNeighbours {
  final int? sender;
  final int? reciever;
  final int? chatroomid;
  final String? message;
  final String? lastmessage;
  final String? updated_at;
  final String? created_at;
  final bool? success;

  ViewConversationNeighbours(
      {required this.sender,
      required this.chatroomid,
      required this.message,
      required this.lastmessage,
      required this.updated_at,
      required this.created_at,
      required this.reciever,
      required this.success});
}
