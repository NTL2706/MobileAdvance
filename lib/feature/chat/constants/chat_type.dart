class ChatUser {
  String id;
  String name;
  String role; // Đã sửa từ role, xóa dấu phẩy ở cuối
  List<String> message;
  bool seen;
  String? avatar; // Thêm avatar

  ChatUser(this.id, this.name, this.role, this.message, this.seen,
      this.avatar); // Sửa tên lớp thành ChatUser
}

class ChatMessage {
  final String sender;
  final String text;
  final DateTime time;

  ChatMessage({required this.sender, required this.text, required this.time});
}

class ShecduleMeeting {
  final String id;
  final String author;
  final String title;
  final DateTime timeEnd;
  final DateTime timeStart;
  final int isMeeting;

  ShecduleMeeting(
      {required this.id,
      required this.author,
      required this.title,
      required this.timeEnd,
      required this.timeStart,
      required this.isMeeting});
}
