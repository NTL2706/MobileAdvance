import 'dart:convert';
import 'dart:io';

import 'package:final_project_advanced_mobile/feature/auth/constants/auth_result.dart';
import 'package:final_project_advanced_mobile/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class AuthenRepository {
  String? _username;
  int? _id;
  String? _token;
  String? get token => sharedPreferences.getString('token');
  String? get role => sharedPreferences.getString('role');
  String? get username => _username;
  int? get id => _id;
  bool isLoading = false;
  AuthenRepository();
  AuthenRepository.unknown() : _username = null;

  Future<Map<dynamic, dynamic>> signInWithPassword(
      {required String email,
      required String password,
      required String role}) async {
    try {
      final response = await http.post(
          Uri.parse("http://34.16.137.128/api/auth/sign-in"),
          body: {"email": email, "password": password});
      final body = json.decode(response.body);
      if (response.statusCode == 201) {
        await sharedPreferences.setString(
            'token', body['result']['token'].toString().trim());
        await sharedPreferences.setString('role', role);
      }

      if (response.statusCode >= 400) {
        print(response.statusCode);
        throw Exception(body['errorDetails']);
      }
      return {
        "result": AuthResult.success,
      };
    } on Exception catch (e) {
      return {"result": AuthResult.failure, "message": e.toString()};
    }
  }

  Future<Map<dynamic, dynamic>> signUpWithPassword(
      {required String email,
      required String password,
      required String fullname,
      required int role}) async {
    try {
      print(role);
      print(email);
      print(password);
      print(fullname);
      final response = await http.post(Uri.parse("http://34.16.137.128/api/auth/sign-up"), body: {
        "email": email,
        "password": password,
        "fullname": fullname,
        "role": role.toString()
      });
      final body = json.decode(response.body);
      print(body);
      if (response.statusCode >= 400) {
        throw Exception(body['errorDetails']);
      }
      return {
        "result": AuthResult.success,
        "message": body['result']['message']
      };
    } on Exception catch (e) {
      return {"result": AuthResult.failure, "message": e.toString()};
    }
  }

  Future<AuthResult> getUserInf() async {
    try {
      final response = await http.get(
          Uri.parse("http://34.16.137.128/api/auth/me"),
          headers: {HttpHeaders.authorizationHeader: "Bearer $token"});
      final body = json.decode(response.body);

      _id = body['result']['id'];
      _username = body['result']['fullname'];
      print(body);
      return AuthResult.success;
    } on Exception catch (e) {
      return AuthResult.failure;
    }
  }

  void switchAccount({required String role}) {}

  void logOut() {}
}
