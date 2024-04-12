import 'dart:convert';
import 'dart:io';

import 'package:final_project_advanced_mobile/feature/auth/constants/auth_result.dart';
import 'package:final_project_advanced_mobile/feature/profie/models/profile.dart';
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

  Profile? profile = null;
  List<Skill> skills = [];
  List<TechStack> techStack = [];
  List<Project> projects = [];

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

  Future<void> getProfileUser() async {
    try {
      var fetchProfile = await profileRepository.getProfileUser();
      profile = fetchProfile;
    } catch (e) {
      print('Failed to get profile user: $e');
    }
  }

  Future<void> getTechStackDefault() async {
    try {
      var fetchedTechStack = await profileRepository.getTechStackDefault();
      techStack = fetchedTechStack;
    } catch (e) {
      print('Failed to get tech stack default: $e');
    }
  }

  Future<void> getSkillsDefault() async {
    try {
      var fetchedSkills = await profileRepository.getSkillDefault();
      skills = fetchedSkills;
    } catch (e) {
      print('Failed to get skills: $e');
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

  Future<void> updateProfileStudent({
    required int studentId,
    required List<String> skillSets,
    required int techStackId,
  }) async {
    var data = {
      'techStackId': techStackId,
      'skillSets': skillSets,
    };

    await profileRepository.updateProfileUser(studentId, data);

    notifyListeners();
  }

  Future<void> updateEducationStudent(
    List<EducationInfo> educationList,
    int studentId,
  ) async {
    educationList = educationList
        .map((educationInfo) => EducationInfo(
              schoolName: educationInfo.schoolName,
              startYear: educationInfo.startYear,
              endYear: educationInfo.endYear,
              id: null,
            ))
        .toList();

    await profileRepository.updateEducationStudent(educationList, studentId);
    notifyListeners();
  }

  Future<void> getProjectByStudentId(int studentId) async {
    projects = await profileRepository.getProjectByStudentId(studentId);
    notifyListeners();
  }

  Future<void> updatedProjectStudent(
      {required int studentId, required List<Project> projects}) async {
    List<Map<String, dynamic>> jsonList = [];

    for (var project in projects) {
      String startMonth =
          "${project.startDate.month.toString().padLeft(2, '0')}-${project.startDate.year}";
      String endMonth =
          "${project.endDate.month.toString().padLeft(2, '0')}-${project.endDate.year}";

      List<String> skillSets =
          project.skillSet.map((skill) => skill.id.toString()).toList();

      jsonList.add({
        'title': project.name,
        'startMonth': startMonth,
        'endMonth': endMonth,
        'description': project.description,
        'skillSets': skillSets,
      });
    }

    Map<String, dynamic> jsonData = {'experience': jsonList};
    await profileRepository.updatedProjectStudent(studentId, jsonData);
    notifyListeners();
  }

  Future<void> updateProfileCompany({required int companyId, data}) async {
    await profileRepository.updateProfileCompany(companyId, data);
    notifyListeners();
  }
}
