// ignore_for_file: prefer_final_fields, non_constant_identifier_names, avoid_print, unrelated_type_equality_checks

import 'dart:convert';
import 'dart:io';
import 'package:final_project_advanced_mobile/main.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class NotiProvider extends ChangeNotifier {
  Future<List<dynamic>> fetchDataAllNoti(
      {required String token, required userId}) async {
    String apiUrl =
        "${dotenv.env['API_URL']!}api/notification/getByReceiverId/$userId";

    try {
      http.Response response = await http.get(Uri.parse(apiUrl),
          headers: {HttpHeaders.authorizationHeader: 'Bearer $token'});

      var parsedJson = jsonDecode(response.body);

      return parsedJson['result'];
    } catch (error) {
      throw Exception('Failed to fetch data: $error');
    }
  }
}
