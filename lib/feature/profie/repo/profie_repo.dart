import 'dart:convert';
import 'dart:io';

import 'package:final_project_advanced_mobile/feature/auth/constants/auth_result.dart';
import 'package:final_project_advanced_mobile/feature/auth/constants/auth_state.dart';
import 'package:final_project_advanced_mobile/main.dart';
import 'package:http/http.dart' as http;

class ProfileRepository {
  List<Map<String, dynamic>>? _techStackList;
  List<Map<String, dynamic>>? get techStackList => _techStackList;
  List<Map<String, dynamic>>? _skillSetList;
  List<Map<String, dynamic>>? get skillSetList => _skillSetList;

  Future<AuthResult> getAllTechStack() async {
    try {
      final result = await http
          .get(Uri.parse("${env.apiURL}api/techstack/getAllTechStack"));
      final body = json.decode(result.body);
      _techStackList = List<Map<String, dynamic>>.from(body['result']);
      return AuthResult.success;
    } on Exception catch (e) {
      return AuthResult.failure;
    }
  }

  Future<AuthResult> getAllSkillSet() async {
    try {
      final result =
          await http.get(Uri.parse("${env.apiURL}api/skillset/getAllSkillSet"));
      final body = json.decode(result.body);

      _skillSetList = List<Map<String, dynamic>>.from(body['result']);

      return AuthResult.success;
    } on Exception catch (e) {
      return AuthResult.failure;
    }
  }

  Future<AuthResult> createProfieForStudent(
      {required String token,
      required List<String> skillSets,
      required String techStackId}) async {
    try {
      final Map<String, dynamic> data = new Map<String, dynamic>();
      data['techStackId'] = techStackId;
      data['skillSets'] = skillSets;
      final result =
          await http.post(Uri.parse("${env.apiURL}api/profile/student"),
              headers: {
                'Content-type': 'application/json',
                'Accept': 'application/json',
                HttpHeaders.authorizationHeader: "Bearer $token"
              },
              body: json.encode(data));
      final body = json.decode(result.body);
      if (result.statusCode >= 400) {
        throw Exception(body['errorDetails']);
      }

      return AuthResult.success;
    } on Exception catch (e) {
      return AuthResult.failure;
    }
  }

  Future<AuthResult> createProfieForCompany(
      {required String companyName,
      required int size,
      required String website,
      required String description,
      required String token}) async {
    try {
      final Map<String, dynamic> data = new Map<String, dynamic>();
      data['companyName'] = companyName;
      data['size'] = size;
      data['website'] = website;
      data['description'] = description;
      final result =
          await http.post(Uri.parse("${env.apiURL}api/profile/company"),
              headers: {
                'Content-type': 'application/json',
                'Accept': 'application/json',
                HttpHeaders.authorizationHeader: "Bearer $token"
              },
              body: json.encode(data));
      final body = json.decode(result.body);
      print(body);

      return AuthResult.success;
    } on Exception catch (e) {
      return AuthResult.failure;
    }
  }
}
