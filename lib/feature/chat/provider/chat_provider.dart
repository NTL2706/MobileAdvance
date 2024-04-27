// ignore_for_file: prefer_final_fields, non_constant_identifier_names

import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;
import 'package:flutter/material.dart';
import '../constants/chat_type.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class SocketManager {
  IO.Socket? socket;

  SocketManager({
    required String token,
    required String projectId,
    void addMessage,
  }) {
    initSocket(token: token, projectId: projectId);
  }

  void initSocket(
      {required String token, required String projectId, void addMessage}) {
    int projectID =
        int.tryParse(projectId) ?? 0; // Đảm bảo rằng projectID là một số nguyên

    socket = IO.io(
      dotenv.env['API_URL'], // Server url
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect()
          .build(),
    );

    socket!.io.options?['extraHeaders'] = {
      'Authorization': 'Bearer $token',
    };

    socket!.io.options?['query'] = {
      'project_id': projectId,
    };

    socket!.connect();

    socket!.onConnect((_) {
      print('Connected');
    });

    socket!.onDisconnect((_) {
      print('Disconnected');
    });

    socket!.onConnectError((data) {
      print('Connect error: $data');
    });

    socket!.onError((data) {
      print('Error: $data');
    });

    socket!.on('RECEIVE_MESSAGE', (data) {
      
    });

    socket!.on("ERROR", (data) {
      print('Socket error: $data');
    });
  }

  void sendMessage({
    required String content,
    required int projectId,
    required int senderId,
    required int receiverId,
    int messageFlag = 0,
  }) {
    if (socket != null) {
      socket!.emit("SEND_MESSAGE", {
        "content": content,
        "projectId": projectId,
        "senderId": senderId,
        "receiverId": receiverId,
        "messageFlag": messageFlag,
      });
    } else {
      print('Socket is not initialized, cannot send message');
    }
  }

  void dispose() {
    if (socket != null && socket!.connected) {
      socket!.disconnect();
    }
  }
}

class ChatProvider extends ChangeNotifier {
  List<Message>? _messages;
  List<Message>? get messages => _messages;
  Future<List<Message>>? _cachedDataIdUser;
  List<dynamic> _chatmessage = [];
  String? prevId;

  final TextEditingController _textController =
      TextEditingController(); // Thêm controller này
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _startTimeController = TextEditingController();
  final TextEditingController _endTimeController = TextEditingController();

  List<dynamic> get chatmessage => _chatmessage;
  TextEditingController get textController => _textController;
  TextEditingController get titleController => _titleController;
  TextEditingController get startTimeController => _startTimeController;
  TextEditingController get endTimeController => _endTimeController;

  Future<List<MessageUser>> fetchDataAllChat({required String token}) async {
    String apiUrl = "${DotEnv.dotenv.env['API_URL']!}api/message";
    try {
      http.Response response = await http.get(Uri.parse(apiUrl),
          headers: {HttpHeaders.authorizationHeader: 'Bearer $token'});
      if (response.statusCode == 200) {
        var parsedJson = jsonDecode(response.body);
        List<MessageUser> messages = List<MessageUser>.from(
            parsedJson['result'].map((i) => MessageUser.fromJson(i)));
        return messages;
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      throw Exception('Failed to fetch data: $error');
    }
  }

  Future<List<Message>> fetchDataIdUser({
    required String token,
    required int projectid,
    required int userid,
  }) async {
    String apiUrl =
        "${DotEnv.dotenv.env['API_URL']!}api/message/$projectid/user/$userid";
    try {
      http.Response response = await http.get(Uri.parse(apiUrl),
          headers: {HttpHeaders.authorizationHeader: 'Bearer $token'});
      if (response.statusCode == 200) {
        var parsedJson = jsonDecode(response.body);
        List<Message> messages = List<Message>.from(
            parsedJson['result'].map((i) => Message.fromJson(i)));
        _messages = messages;
        return messages;
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      throw Exception('Failed to fetch data: $error');
    }
  }

  void addMessage(
      {required message,
      required DateTime createdAt,
      required User sender,
      required User receiver,
      int? interview}) {
    _messages!.add(Message(
        id: 1,
        createdAt: createdAt,
        content: message,
        sender: sender,
        receiver: receiver,
        interview: interview));
    notifyListeners();
  }

  SocketManager initSocket({
    required String token,
    required String projectId,
  }) {
    return SocketManager(
        // ignore: void_checks
        token: token,
        projectId: projectId);
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
