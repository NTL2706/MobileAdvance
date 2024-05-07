import 'dart:convert';

class ChatMessage {
  final String sender;
  final String text;
  final DateTime time;

  ChatMessage({required this.sender, required this.text, required this.time});
}

class ShecduleMeeting {
  final int id;
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

class MessageUser {
  final int id;
  final String content;
  final User sender;
  final User receiver;
  final Project project;

  MessageUser({
    required this.id,
    required this.content,
    required this.sender,
    required this.receiver,
    required this.project,
  });

  factory MessageUser.fromJson(Map<String, dynamic> json) {
    return MessageUser(
      id: json['id'],
      content: json['content'],
      sender: User.fromJson(json['sender']),
      receiver: User.fromJson(json['receiver']),
      project: Project.fromJson(json['project']),
    );
  }
}

class User {
  final int id;
  final String fullname;

  User({
    required this.id,
    required this.fullname,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      fullname: json['fullname'],
    );
  }
}

class Project {
  final int id;
  final String title;
  final String description;

  Project({
    required this.id,
    required this.title,
    required this.description,
  });

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      id: json['id'],
      title: json['title'],
      description: json['description'],
    );
  }
}

class Interview {
  final int id;
  final DateTime createdAt;
  final DateTime updatedAt;
  late DateTime? deletedAt;
  late final String title;
  late final DateTime startTime;
  late final DateTime endTime;
  final int disableFlag;
  final int meetingRoomId;

  Interview({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.title,
    required this.startTime,
    required this.endTime,
    required this.disableFlag,
    required this.meetingRoomId,
  });

  factory Interview.fromJson(Map<String, dynamic> json) {
    return Interview(
      id: json['id'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      deletedAt:
          json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
      title: json['title'],
      startTime: DateTime.parse(json['startTime']),
      endTime: DateTime.parse(json['endTime']),
      disableFlag: json['disableFlag'],
      meetingRoomId: json['meetingRoomId'],
    );
  }
}

class Message {
  final int id;
  final DateTime createdAt;
  final String content;
  final User sender;
  final User receiver;
  final Interview? interview;

  Message(
      {required this.id,
      required this.createdAt,
      required this.content,
      required this.sender,
      required this.receiver,
      required this.interview});

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'],
      createdAt: DateTime.parse(json['createdAt']),
      content: json['content'],
      sender: User.fromJson(json['sender']),
      receiver: User.fromJson(json['receiver']),
      interview: json['interview'] != null
          ? Interview.fromJson(json['interview'])
          : null,
    );
  }
}
