import 'dart:convert';
import 'dart:io';
import 'package:final_project_advanced_mobile/constants/status_flag.dart';
import 'package:final_project_advanced_mobile/main.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:flutter/material.dart';
import '../constants/chat_type.dart';


class SocketManager {
  IO.Socket? socket;
  String? token;
  ChatProvider? provider;
  String? projectId;
  SocketManager(
    {
      required  this.token,
      this.projectId,
      this.provider
    }) {
    initSocket(token: token!, projectId: projectId,provider: provider);
  }

  void initSocket(
      {required String token, String? projectId,ChatProvider? provider }) {
    
    
     // Đảm bảo rằng projectID là một số nguyên
    
    socket = IO.io(
      'https://api.studenthub.dev/', // Server url
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect()
          .build(),
    );

    socket!.io.options?['extraHeaders'] = {
      'Authorization': 'Bearer $token',
    };

    if (projectId != null){
      print(projectId);
      socket!.io.options?['query'] = {
        'project_id': int.parse(projectId!),
      };
    }
    

    socket!.connect();

    socket!.onConnect((_)async {
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

    socket!.on("ERROR", (data) {
      print('Socket error: $data');
    });
  }

  Future sendMessage({
    required String content,
    required int projectId,
    required int senderId,
    required int receiverId,
    required int messageFlag,
  }) async {
    String? baseUrl = env.apiURL;
    String endpoint = 'api/message/sendMessage';

    final Map<String, dynamic> requestBody = {
      "content": content,
      "projectId": projectId,
      "senderId": senderId,
      "receiverId": receiverId,
      "messageFlag": messageFlag,
    };

    try {
      final response = await http.post(
        Uri.parse('$baseUrl$endpoint'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode(requestBody),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Message sent successfully');
      } else {
        print('Failed to send message. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error while sending message: $e');
    }
  }

  Future startSchedule({
    required String title,
    required String startTime,
    required String endTime,
    required int projectId,
    required int senderId,
    required int receiverId,
    required String meeting_room_code,
    required String meeting_room_id,
  }) async {
    String? baseUrl = env.apiURL;
    String endpoint = 'api/interview';

    final Map<String, dynamic> requestBody = {
      "title": title,
      "content": "Interview created",
      "startTime": startTime,
      "endTime": endTime,
      "projectId": projectId,
      "senderId": senderId,
      "receiverId": receiverId,
      "meeting_room_code": meeting_room_code,
      "meeting_room_id": meeting_room_id
    };

    try {
      final response = await http.post(
        Uri.parse('$baseUrl$endpoint'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode(requestBody),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Message sent successfully');
      } else {
        print('Failed to send message. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error while sending message: $e');
    }
  }

  Future updateSchedule({
    required int interviewId,
    required String title,
    required String startTime,
    required String endTime,
  }) async {
    String? baseUrl = env.apiURL;
    String endpoint = 'api/interview/$interviewId';

    final Map<String, dynamic> requestBody = {
      "title": title,
      "startTime": startTime,
      "endTime": endTime,
    };

    try {
      final response = await http.patch(
        Uri.parse('$baseUrl$endpoint'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode(requestBody),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Message sent successfully');
      } else {
        print('Failed to send message. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error while sending message: $e');
    }
  }

  Future deleteSchedule({
    required int interviewId,
  }) async {
    String? baseUrl = env.apiURL;
    String endpoint = 'api/interview/$interviewId';

    try {
      final response = await http.delete(
        Uri.parse('$baseUrl$endpoint'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        provider?.cancelSchedule(interviewId: interviewId);
        print('Message sent successfully');
      } else {
        print('Failed to send message. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error while sending message: $e');
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
  List<dynamic> _chatmessage = [];
  Interview? prevInterview;

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
    String apiUrl = "${env.apiURL}api/message";
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
        "${env.apiURL}api/message/$projectid/user/$userid";
    try {
      http.Response response = await http.get(Uri.parse(apiUrl),
          headers: {HttpHeaders.authorizationHeader: 'Bearer $token'});
      if (response.statusCode == 200) {
        var parsedJson = jsonDecode(response.body);

        List<Message> messages = List<Message>.from(
            parsedJson['result'].map((i) => Message.fromJson(i)));
        messages.sort((a, b) => b.createdAt.compareTo(a.createdAt));
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
      {required int id,
      required message,
      required DateTime createdAt,
      required User sender,
      required User receiver,
      Interview? interview}) {
    _messages!.insert(
        0,
        Message(
            id: id,
            createdAt: createdAt,
            content: message,
            sender: sender,
            receiver: receiver,
            interview: interview));
    notifyListeners();
  }

  SocketManager initSocket(
      {required String token,
      required String projectId,
      required ChatProvider provider}) {
    return SocketManager(
         token: token, projectId: projectId, provider: provider);
  }

  void handleScheduleMeeting() async {
    final title = _titleController.text;
    final startTime = _startTimeController.text;
    final endTime = _endTimeController.text;

    if (title.isNotEmpty && startTime.isNotEmpty && endTime.isNotEmpty) {}

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

  void handleLoadScheduleMeeting(Interview? interview) {
    if (prevInterview?.id != interview?.id) {
      if (interview?.id == null) {
        _titleController.clear();
        _startTimeController.clear();
        _endTimeController.clear();
      } else {
        _titleController.text = interview!.title;
        _startTimeController.text = interview.startTime.toString();
        _endTimeController.text = interview.endTime.toString();
      }
      prevInterview = interview;
    }
  }

  void updateScheduleMeeting({
    required String title,
    required DateTime startTime,
    required DateTime endTime,
    required int interviewId,
  }) {
    for (Message msg in _messages!) {
      if (msg.interview != null) {
        if (msg.interview?.id == interviewId) {
          msg.interview?.title = title;
          msg.interview?.startTime = startTime;
          msg.interview?.endTime = endTime;
          break;
        }
      }
    }
    notifyListeners();
  }

  void cancelSchedule({
    required int interviewId,
  }) {
    for (Message msg in _messages!) {
      if (msg.interview != null) {
        if (msg.interview?.id == interviewId) {
          print(interviewId);
          print(msg.interview?.id);
          msg.interview?.deletedAt = DateTime.now();
          break;
        }
      }
    }
    notifyListeners();
  }

  Future<void> updateStatusOfStudetnProposal(
      {required int proposalId, required String token, required int statusFlag}) async {
    try {
      Map<String, dynamic> data = Map();
      data['statusFlag'] = statusFlag;
      print("${env.apiURL}api/proposal/$proposalId");
      final rs =
          await http.patch(Uri.parse("${env.apiURL}api/proposal/$proposalId"),
              headers: {
                'Content-type': 'application/json',
                'Accept': 'application/json',
                HttpHeaders.authorizationHeader: "Bearer $token"
              },
              body: json.encode(data));
      final body = json.decode(rs.body);
      print(body);
    } catch (e) {
      print(e);
    }
  }
}
