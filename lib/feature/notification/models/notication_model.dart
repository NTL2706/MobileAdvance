// class Notify {
//   final int id;
//   final String title;
//   final String typeNotifyFlag;
//   final String notifyFlag;
//   final User sender;
//   final User receiver;
//   Interview? interview;

//   Notify({
//     required this.id,
//     required this.title,
//     required this.typeNotifyFlag,
//     required this.notifyFlag,
//     required this.sender,
//     required this.receiver,
//     this.interview,
//   });

//   factory Notify.fromJson(Map<String, dynamic> json) {
//     return Notify(
//       id: json['id'],
//       title: json['title'],
//       typeNotifyFlag: json['typeNotifyFlag'],
//       notifyFlag: json['notifyFlag'],
//       sender: User.fromJson(json['message']['sender']),
//       receiver: User.fromJson(json['message']['receiver']),
//       interview: Interview.fromJson(json['message']['interview']),
//     );
//   }
// }

// class User {
//   final int id;
//   final String email;
//   final String fullname;

//   User({
//     required this.id,
//     required this.email,
//     required this.fullname,
//   });

//   factory User.fromJson(Map<String, dynamic> json) {
//     return User(
//       id: json['id'],
//       email: json['email'],
//       fullname: json['fullname'],
//     );
//   }
// }

// class Interview {
//   final int id;
//   final String title;
//   final DateTime startTime;
//   final DateTime endTime;
//   final MeetingRoom meetingRoom;

//   Interview({
//     required this.id,
//     required this.title,
//     required this.startTime,
//     required this.endTime,
//     required this.meetingRoom,
//   });

//   factory Interview.fromJson(Map<String, dynamic> json) {
//     return Interview(
//       id: json['id'],
//       title: json['title'],
//       startTime: DateTime.parse(json['startTime']),
//       endTime: DateTime.parse(json['endTime']),
//       meetingRoom: MeetingRoom.fromJson(json['meetingRoom']),
//     );
//   }
// }

// class MeetingRoom {
//   final int id;
//   final String meetingRoomCode;
//   final String meetingRoomId;
//   final DateTime? expiredAt;

//   MeetingRoom({
//     required this.id,
//     required this.meetingRoomCode,
//     required this.meetingRoomId,
//     required this.expiredAt,
//   });

//   factory MeetingRoom.fromJson(Map<String, dynamic> json) {
//     return MeetingRoom(
//       id: json['id'],
//       meetingRoomCode: json['meeting_room_code'],
//       meetingRoomId: json['meeting_room_id'],
//       expiredAt: json['expired_at'] != null
//           ? DateTime.parse(json['expired_at'])
//           : null,
//     );
//   }
// }
