// ignore_for_file: prefer_final_fields

import 'package:flutter/material.dart';
import '../constants/chat_type.dart';

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
        'https://scontent.fsgn5-10.fna.fbcdn.net/v/t39.30808-6/232991495_2936758473209297_7122906719741291747_n.jpg?_nc_cat=107&ccb=1-7&_nc_sid=5f2048&_nc_ohc=ZhKBE6tJlZQAX_9j0XL&_nc_ht=scontent.fsgn5-10.fna&oh=00_AfDxnSK5Gp_h7idJ5AES-OhFFFik8AEJnDqY2dgwFegSeA&oe=6610B871'),
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
    ChatMessage(sender: 'Me', text: 'Hello!', time: DateTime.now()),
    ChatMessage(sender: 'You', text: 'Hi there!', time: DateTime.now()),
    ChatMessage(sender: 'Me', text: 'Are you oke!', time: DateTime.now()),
    ChatMessage(sender: 'You', text: 'Haha!', time: DateTime.now()),
    ShecduleMeeting(
        author: 'Me',
        title: 'Meeting',
        timeStart: DateTime.now(),
        timeEnd: DateTime.now()),
  ];

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
          author: 'Me',
          title: title,
          timeStart: DateTime.parse(startTime),
          timeEnd: DateTime.parse(endTime),
        ),
      );
    }

    _titleController.clear();
    _startTimeController.clear();
    _endTimeController.clear();
    notifyListeners();
  }

  void handleChangeStartTime(context) async {
    final DateTime? pickedDateTime = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
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
    final DateTime? pickedDateTime = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
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
}
