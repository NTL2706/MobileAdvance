// ignore_for_file: prefer_final_fields, non_constant_identifier_names, avoid_print, unrelated_type_equality_checks

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class NotiProvider extends ChangeNotifier {
  List<dynamic> _notiList = [];

  List<dynamic> get notiList => _notiList;

  Future<List<dynamic>> fetchDataAllNoti(
      {required String token, required userId}) async {
    String apiUrl =
        "${dotenv.env['API_URL']!}api/notification/getByReceiverId/$userId";

    try {
      http.Response response = await http.get(Uri.parse(apiUrl),
          headers: {HttpHeaders.authorizationHeader: 'Bearer $token'});

      var parsedJson = jsonDecode(response.body);
      _notiList = parsedJson['result'];
      return parsedJson['result'];
    } catch (error) {
      throw Exception('Failed to fetch data: $error');
    }
  }

  Future<void> markNotificationAsRead(String id) async {
    // Retrieve the base URL from the environment variable
    final String baseUrl = dotenv.env['BASE_URL'] ?? '';
    final String apiUrl = '$baseUrl/api/notification/readNoti/$id';

    try {
      // Perform a PATCH request
      final response = await http.patch(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization':
              'Bearer yourAuthToken', // Add any required authorization here
        },
        body: jsonEncode({'read': true}), // Adjust the request body as needed
      );

      // Check the response status
      if (response.statusCode == 200) {
        print('Notification marked as read');
      } else {
        print('Failed to mark notification as read: ${response.statusCode}');
      }
    } catch (error) {
      print('Error occurred: $error');
    }
  }

  Future<void> readNoti(int id, String token) async {
    final String? baseUrl = dotenv.env['API_URL'];
    final String path = 'api/notification/readNoti/$id';
    final String apiUrl = '$baseUrl$path';

    try {
      // Perform a PATCH request
      final response = await http.patch(Uri.parse(apiUrl), headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      });

      if (response.statusCode == 200) {
        print('Notification marked as read');
      } else {
        print('Failed to mark notification as read: ${response.statusCode}');
      }
    } catch (error) {
      print('Error occurred: $error');
    }

    for (var i = 0; i < _notiList.length; i++) {
      if (_notiList[i]['id'] == id) {
        _notiList[i]['notifyFlag'] = '1';
        break;
      }
    }
    notifyListeners();
  }

  Future<void> reload() async {
    notifyListeners();
  }
}
