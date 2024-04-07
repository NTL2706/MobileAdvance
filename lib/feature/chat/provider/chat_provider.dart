// ignore_for_file: prefer_final_fields

import 'package:flutter/material.dart';
import '../constants/chat_type.dart';
import 'dart:math';

class ChatProvider extends ChangeNotifier {
  List<ChatUser> _chatusers = [
    ChatUser('1', 'Khân Đồi', 'Senior Data Analyist',
        ['Hello', 'Hi', 'How are you?'], false, null),
    ChatUser('2', 'Quang Tú', 'Junior Data Analyist',
        ['Hello', 'Hi', 'How are you?'], true, null),
    ChatUser('3', '17 lúi', 'Senior Data Analyist',
        ['Hello', 'Hi', 'How are you?'], false, null),
    ChatUser('4', 'Ngài Morgan', 'Junior Data Analyist',
        ['Hello', 'Hi', 'How are you?'], false, null),
    ChatUser(
        '5',
        'Hần Đoài',
        'Senior Data Analyist',
        ['Hello', 'Hi', 'How are you?'],
        true,
        'https://scontent.fsgn5-10.fna.fbcdn.net/v/t39.30808-6/232991495_2936758473209297_7122906719741291747_n.jpg?_nc_cat=107&ccb=1-7&_nc_sid=5f2048&_nc_eui2=AeEeu1ofd2v9zW2nx1f98eKiL8qzVUaE10kvyrNVRoTXSbCwEp0wYXqt6P04MD5agItuDWdM2WLXg5szjm9Zq7nI&_nc_ohc=KZ2qS9CwwDsAb6eGqq1&_nc_ht=scontent.fsgn5-10.fna&oh=00_AfDNvuudIFStmUW0p_-AKybJDyheWNVWyjvqg772wMbXPw&oe=66174FF1'),
    ChatUser('6', 'Natulo', 'Nô Lệ Da Đen', ['Hello', 'Hi', 'How are you?'],
        false, null),
    ChatUser('7', 'Natulo', 'Nô Lệ Da Đen', ['Hello', 'Hi', 'How are you?'],
        false, null),
    ChatUser('8', 'Natulo', 'Nô Lệ Da Đen', ['Hello', 'Hi', 'How are you?'],
        true, null),
    ChatUser('9', 'Natulo', 'Nô Lệ Da Đen', ['Hello', 'Hi', 'How are you?'],
        false, null)
  ];
  List<dynamic> _chatmessage = [
    ShecduleMeeting(
        id: 'test',
        author: 'Me',
        title: 'Meeting',
        timeStart: DateTime.now(),
        timeEnd: DateTime.now(),
        isMeeting: 1),
    ChatMessage(sender: 'Me', text: 'Hello!', time: DateTime.now()),
    ChatMessage(sender: 'You', text: 'Hi there!', time: DateTime.now()),
    ChatMessage(sender: 'Me', text: 'Are you oke!', time: DateTime.now()),
    ChatMessage(sender: 'You', text: 'Haha!', time: DateTime.now()),
  ];
  String?
      prevId; // dùng để tránh việc get lại default data liên tục của modalbottomsheet

  final TextEditingController _textController =
      TextEditingController(); // Thêm controller này
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _startTimeController = TextEditingController();
  final TextEditingController _endTimeController = TextEditingController();

  List<ChatUser> get chatusers => _chatusers;
  List<dynamic> get chatmessage => _chatmessage;
  TextEditingController get textController => _textController;
  TextEditingController get titleController => _titleController;
  TextEditingController get startTimeController => _startTimeController;
  TextEditingController get endTimeController => _endTimeController;

  void handleSubmitted(String text) {
    _textController.value.text.isNotEmpty
        ? _chatmessage.insert(
            0,
            ChatMessage(sender: 'Me', text: text, time: DateTime.now()),
          )
        : null;

    _textController.clear();
    notifyListeners();
  }

  void handleScheduleMeeting() async {
    final title = _titleController.text;
    final startTime = _startTimeController.text;
    final endTime = _endTimeController.text;

    if (title.isNotEmpty && startTime.isNotEmpty && endTime.isNotEmpty) {
      _chatmessage.insert(
        0,
        ShecduleMeeting(
          id: Random().nextInt(1000).toString(),
          author: 'Me',
          title: title,
          timeStart: DateTime.parse(startTime),
          timeEnd: DateTime.parse(endTime),
          isMeeting: 1,
        ),
      );
    }

    _titleController.clear();
    _startTimeController.clear();
    _endTimeController.clear();
    notifyListeners();
  }

  void handleChangeStartTime(context) async {
    final DateTime endTime = _endTimeController.text.isEmpty
        ? DateTime(3000)
        : DateTime.parse(_endTimeController.text);

    final DateTime? pickedDateTime = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: endTime,
    );
    if (pickedDateTime != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      if (pickedTime != null) {
        final DateTime selectedDateTime = DateTime(
          pickedDateTime.year,
          pickedDateTime.month,
          pickedDateTime.day,
          pickedTime.hour,
          pickedTime.minute,
        );
        _startTimeController.text = selectedDateTime.toString();
        // Thực hiện hành động khi chọn ngày và giờ
      }
    }
    notifyListeners();
  }

  void handleChangeEndTime(context) async {
    final DateTime startTime = _startTimeController.text.isEmpty
        ? DateTime.now()
        : DateTime.parse(_startTimeController.text);

    final DateTime? pickedDateTime = await showDatePicker(
      context: context,
      initialDate: startTime,
      firstDate: startTime,
      lastDate: DateTime(3000),
    );
    if (pickedDateTime != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      if (pickedTime != null) {
        final DateTime selectedDateTime = DateTime(
          pickedDateTime.year,
          pickedDateTime.month,
          pickedDateTime.day,
          pickedTime.hour,
          pickedTime.minute,
        );
        _endTimeController.text = selectedDateTime.toString();
        // Thực hiện hành động khi chọn ngày và giờ
      }
    }

    notifyListeners();
  }

  void handleLoadScheduleMeeting(String? id) {
    if (prevId != id) {
      if (id == null) {
        _titleController.clear();
        _startTimeController.clear();
        _endTimeController.clear();
      } else {
        int index = chatmessage.indexWhere((element) =>
            element.runtimeType == ShecduleMeeting && element.id == id);
        if (index != -1) {
          _titleController.text = chatmessage[index].title;
          _startTimeController.text = chatmessage[index].timeStart.toString();
          _endTimeController.text = chatmessage[index].timeEnd.toString();
        }
      }
      prevId = id;
    }
  }

  void updateScheduleMeeting(String id) {
    final title = _titleController.text;
    final startTime = _startTimeController.text;
    final endTime = _endTimeController.text;

    int index = chatmessage.indexWhere((element) =>
        element.runtimeType == ShecduleMeeting && element.id == id);
    chatmessage[index] = ShecduleMeeting(
      id: id,
      title: title,
      timeStart: DateTime.parse(startTime),
      timeEnd: DateTime.parse(endTime),
      author: chatmessage[index].author,
      isMeeting: chatmessage[index].isMeeting,
    );

    notifyListeners();
  }

  void handleCancelScheduleMeeting(String id) {
    int index = chatmessage.indexWhere((element) =>
        element.runtimeType == ShecduleMeeting && element.id == id);

    chatmessage[index] = ShecduleMeeting(
      id: id,
      title: chatmessage[index].title,
      timeStart: chatmessage[index].timeStart,
      timeEnd: chatmessage[index].timeEnd,
      author: chatmessage[index].author,
      isMeeting: 2,
    );

    notifyListeners();
  }
}
