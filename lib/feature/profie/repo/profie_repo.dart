import 'dart:convert';
import 'dart:io';

import 'package:final_project_advanced_mobile/feature/auth/constants/auth_result.dart';
import 'package:final_project_advanced_mobile/feature/auth/constants/auth_state.dart';
import 'package:final_project_advanced_mobile/feature/profie/models/company_profile.dart';
import 'package:final_project_advanced_mobile/feature/profie/models/profile.dart';
import 'package:final_project_advanced_mobile/main.dart';
import 'package:http/http.dart' as http;

class ProfileRepository {
  String baseUrl = '';
  String? get token => sharedPreferences.getString('token');
  var baseHeaders = <String, String>{};

  List<Map<String, dynamic>>? _techStackList;
  List<Map<String, dynamic>>? get techStackList => _techStackList;
  List<Map<String, dynamic>>? _skillSetList;
  List<Map<String, dynamic>>? get skillSetList => _skillSetList;

  ProfileRepository() {
    baseHeaders = {
      'Content-Type': 'application/json',
      'accept': '*/*',
    };
    baseUrl = env.apiURL!;
  }

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

  Future<Profile> getProfileUser() async {
    final String url = '${baseUrl}api/auth/me';
    Map<String, String> modifiedHeaders = Map.from(baseHeaders);
    modifiedHeaders['Authorization'] = 'Bearer $token';

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: modifiedHeaders,
      );

      print(response.body);

      if (response.statusCode == 200) {
        var res = json.decode(response.body);
        res = res['result'];

        var studentProfile = null;
        var companyProfile = null;
        if (res['company'] != null) {
          var companyData = res['company'];
          companyProfile = Company(
              id: companyData['id'],
              name: companyData['companyName'],
              numberOfEmployees: companyData['size'],
              website: companyData['website'],
              description: companyData['description'],
              address: "");
        }

        if (res['student'] != null) {
          var studentData = res['student'];
          var techStackData = studentData['techStack'];
          var skillSetsData = studentData['skillSets'];

          List<Skill> skills = [];
          for (var skillData in skillSetsData) {
            skills.add(Skill(
              id: skillData['id'],
              name: skillData['name'],
            ));
          }

          TechStack techStack = TechStack(
            id: techStackData['id'],
            name: techStackData['name'],
          );

          List<EducationInfo> educationInfo = [];
          for (var educationData in studentData['educations']) {
            educationInfo.add(EducationInfo(
              id: educationData['id'],
              schoolName: educationData['schoolName'],
              startYear: educationData['startYear'],
              endYear: educationData['endYear'],
            ));
          }

          studentProfile = StudentProfile(
            id: studentData['id'],
            techStack: techStack,
            skill: skills,
            educationInfo: educationInfo,
          );
        }

        var result = Profile(
          id: res['id'],
          name: res['fullname'],
          roles: List<int>.from(res['roles']),
          studentProfile: studentProfile,
          company: companyProfile,
        );
        return result;
      } else {
        throw Exception('Failed to get profile user');
      }
    } catch (e) {
      throw Exception('Failed to get profile user: $e');
    }
  }

  Future<List<TechStack>> getTechStackDefault() async {
    final String url = '${baseUrl}api/techstack/getAllTechStack';

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: baseHeaders,
      );

      if (response.statusCode == 200) {
        var res = json.decode(response.body);
        return List<TechStack>.from(res['result']
            .map((item) => TechStack(name: item['name'], id: item['id'])));
      } else {
        throw Exception('Failed to get tech stack default');
      }
    } catch (e) {
      throw Exception('Failed to get tech stack default: $e');
    }
  }

  Future<List<Skill>> getSkillDefault() async {
    final String url = '${baseUrl}api/skillset/getAllSkillSet';

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: baseHeaders,
      );

      if (response.statusCode == 200) {
        var res = json.decode(response.body);
        return List<Skill>.from(res['result']
            .map((item) => Skill(id: item['id'], name: item['name'])));
      } else {
        throw Exception('Failed to get tech stack default');
      }
    } catch (e) {
      throw Exception('Failed to get tech stack default: $e');
    }
  }

  Future<AuthResult> updateProfileUser(int studentId, data) async {
    final String url = '${baseUrl}api/profile/student/$studentId';

    Map<String, String> modifiedHeaders = {
      ...baseHeaders,
      'Authorization': 'Bearer $token'
    };

    try {
      final response = await http.put(Uri.parse(url),
          headers: modifiedHeaders, body: json.encode(data));

      if (response.statusCode != 200) {
        throw Exception('Failed to update profile user');
      }

      return AuthResult.success;
    } catch (e) {
      return AuthResult.failure;
    }
  }

  Future<AuthResult> updateEducationStudent(
      List<EducationInfo> data, int studentId) async {
    final String url = '${baseUrl}api/education/updateByStudentId/$studentId';

    Map<String, String> modifiedHeaders = {
      ...baseHeaders,
      'Authorization': 'Bearer $token',
    };

    List<Map<String, dynamic>> formattedData = data
        .map((item) => {
              'id': item.id,
              'schoolName': item.schoolName,
              'startYear': item.startYear,
              'endYear': item.endYear,
            })
        .toList();

    try {
      final response = await http.put(
        Uri.parse(url),
        headers: modifiedHeaders,
        body: json.encode({'education': formattedData}),
      );

      if (response.statusCode != 200) {
        return AuthResult.failure;
      }

      return AuthResult.success;
    } catch (e) {
      return AuthResult.failure;
    }
  }

  Future<List<Project>> getProjectByStudentId(int studentId) async {
    final String url = '${baseUrl}api/experience/getByStudentId/$studentId';

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: baseHeaders,
      );

      if (response.statusCode == 200) {
        var res = json.decode(response.body);

        return List<Project>.from(res['result'].map((item) {
          List<String> startMonth = item['startMonth'].split('-');
          List<String> endMonth = item['endMonth'].split('-');

          DateTime startDate =
              DateTime.parse('${startMonth[1]}-${startMonth[0]}-01');
          DateTime endDate = DateTime.parse('${endMonth[1]}-${endMonth[0]}-01');

          List<Skill> skills = [];
          for (var skillData in item['skillSets']) {
            skills.add(Skill(
              id: skillData['id'],
              name: skillData['name'],
            ));
          }

          return Project(
            name: item['title'],
            description: item['description'],
            startDate: startDate,
            endDate: endDate,
            skillSet: skills,
          );
        }));
      } else {
        throw Exception('Failed to get project by student id');
      }
    } catch (e) {
      throw Exception('Failed to get project by student id: $e');
    }
  }

  Future<AuthResult> updatedProjectStudent(int studentId, data) async {
    final String url = '${baseUrl}api/experience/updateByStudentId/$studentId';

    Map<String, String> modifiedHeaders = {
      ...baseHeaders,
      'Authorization': 'Bearer $token',
    };

    try {
      final response = await http.put(
        Uri.parse(url),
        headers: modifiedHeaders,
        body: json.encode(data),
      );

      print(response.body);
      if (response.statusCode != 200) {
        throw Exception('Failed to update project student');
      }
      return AuthResult.success;
    } catch (e) {
      print(e);
      return AuthResult.failure;
    }
  }

  Future<AuthResult> updateProfileCompany(int companyId, data) async {
    final String url = '${baseUrl}api/profile/company/$companyId';

    Map<String, String> modifiedHeaders = {
      ...baseHeaders,
      'Authorization': 'Bearer $token',
    };

    try {
      final response = await http.put(
        Uri.parse(url),
        headers: modifiedHeaders,
        body: json.encode(data),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to update profile company');
      }

      return AuthResult.success;
    } catch (e) {
      return AuthResult.failure;
    }
  }
}
