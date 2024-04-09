import 'dart:convert';
import 'dart:io';

import 'package:final_project_advanced_mobile/feature/auth/constants/auth_result.dart';
import 'package:final_project_advanced_mobile/feature/profie/repo/profie_repo.dart';
import 'package:final_project_advanced_mobile/main.dart';
import 'package:final_project_advanced_mobile/utils/http_response.dart';
import 'package:flutter/cupertino.dart';
import "package:http/http.dart" as http;

class ProfileProvider extends ChangeNotifier {
  AuthResult? status;
  ProfileRepository profileRepository = ProfileRepository();
  Map<String, dynamic>? _studentProfile;
  Map<String, dynamic>? get studentProfile => _studentProfile;

  HttpResponse responseHttp =
      HttpResponse<List<Map<String, dynamic>>>.unknown();

  Future<void> getAllTechStack() async {
    await profileRepository.getAllTechStack();
    notifyListeners();
  }

  Future<void> getAllSkillSet() async {
    await profileRepository.getAllSkillSet();
    notifyListeners();
  }

  Future<void> getProfileStudent(
      {required int studentId, required String token}) async {
    try {
      final rs = await http.get(
          headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
          Uri.parse("${env.apiURL}api/profile/student/$studentId"));
      final body = json.decode(rs.body);
      if (body['errorDetails'] != null) {
        throw Exception(body['errorDetails']);
      }
      _studentProfile = body['result'];
    } on Exception catch (e) {
      print(e);
    }
  }

  Future<void> createProfieForStudent({
    required String token,
    required List<String> skillSets,
    required String techStackId,
  }) async {
    status = await profileRepository.createProfieForStudent(
        skillSets: skillSets, techStackId: techStackId, token: token);
    notifyListeners();
  }

  Future<void> createProfieForCompany(
      {required String companyName,
      required int size,
      required String website,
      required String description,
      required String token}) async {
    status = await profileRepository.createProfieForCompany(
        companyName: companyName,
        description: description,
        token: token,
        size: size,
        website: website);
    notifyListeners();
  }
}
