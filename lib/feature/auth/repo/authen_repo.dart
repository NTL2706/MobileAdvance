import 'dart:convert';
import 'dart:io';

import 'package:final_project_advanced_mobile/feature/auth/constants/auth_result.dart';
import 'package:final_project_advanced_mobile/main.dart';
import 'package:http/http.dart' as http;

class AuthenRepository {
  String? _username;
  int? _id;
  Map<String, dynamic>? _student;
  Map<String, dynamic>? _company;
  Map<String, dynamic>? get student => _student;
  Map<String, dynamic>? get company => _company;
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
          Uri.parse("${env.apiURL}api/auth/sign-in"),
          body: {"email": email, "password": password});
      final body = json.decode(response.body);
      if (response.statusCode == 201) {
        await sharedPreferences.setString(
            'token', body['result']['token'].toString().trim());
        await sharedPreferences.setString('role', role);
      }

      if (response.statusCode >= 400) {
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
      final response = await http.post(Uri.parse("${env.apiURL}api/auth/sign-up"), body: {
        "email": email,
        "password": password,
        "fullname": fullname,
        "role": role.toString()
      });
      final body = json.decode(response.body);
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
          Uri.parse("${env.apiURL}api/auth/me"),
          headers: {HttpHeaders.authorizationHeader: "Bearer $token"});
      final body = json.decode(response.body);

      _id = body['result']['id'];
      _username =  body['result']['fullname'];
      if ( body['result']['student'] != null){
        _student =Map<String, dynamic>.from(body['result']['student']);
      }
      if ( body['result']['company'] != null){
      _company = Map<String, dynamic>.from(body['result']['company']);
      }
     
      return AuthResult.success;
    } on Exception catch (e) {
      return AuthResult.failure;
    }
  }

  Future<AuthResult> switchAccount({required String role})async {
    try{
      await sharedPreferences.setString('role', role);
      return AuthResult.success;
    }on Exception catch(e){
      return AuthResult.failure;
    }
  }

  void logOut() {}
}
