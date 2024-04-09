import 'dart:convert';
import 'dart:math';
import 'package:final_project_advanced_mobile/feature/profie/models/education_info.dart';
import 'package:final_project_advanced_mobile/feature/profie/models/profile.dart';
import 'package:final_project_advanced_mobile/feature/profie/models/skill.dart';
import 'package:final_project_advanced_mobile/feature/profie/models/student_profile.dart';
import 'package:final_project_advanced_mobile/feature/profie/models/techstack.dart';
import 'package:final_project_advanced_mobile/main.dart';
import 'package:http/http.dart' as http;

class ProfileRepository {
  final String baseUrl = 'http://34.16.137.128/api';
  String? get token => sharedPreferences.getString('token');

  var baseHeaders = <String, String>{};

  ProfileRepository() {
    baseHeaders = {
      'Content-Type': 'application/json',
      'accept': '*/*',
    };
  }

  Future<Profile> getProfileUser() async {
    final String url = '$baseUrl/auth/me';
    Map<String, String> modifiedHeaders = Map.from(baseHeaders);
    modifiedHeaders['Authorization'] = 'Bearer $token';

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: modifiedHeaders,
      );

      if (response.statusCode == 200) {
        var res = json.decode(response.body);
        res = res['result'];

        var studentProfile = null;
        if (res['student'] != null) {
          var studentData = res['student'];
          var techStackData = studentData['techStack'];
          var skillSetsData = studentData['skillSets'];

          // Tạo danh sách các đối tượng Skill từ skillSetsData
          List<Skill> skills = [];
          for (var skillData in skillSetsData) {
            skills.add(Skill(
              id: skillData['id'],
              name: skillData['name'],
            ));
          }

          // Khởi tạo đối tượng TechStack từ techStackData
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

          // Khởi tạo StudentProfile từ các thông tin đã có
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
        );
        return result;
      } else {
        throw Exception('Failed to get profile user');
      }
    } catch (e) {
      throw Exception('Failed to get profile user: $e');
    }
  }

  Future<void> updateProfileStudent(int id, List<String> skillSets) async {
    final String url = '$baseUrl$id';

    try {
      final response = await http.put(
        Uri.parse(url),
        headers: baseHeaders,
        body: jsonEncode({
          'techStackId': {},
          'skillSets': skillSets,
        }),
      );

      if (response.statusCode == 200) {
      } else {
        throw Exception('Failed to update profile student');
      }
    } catch (e) {
      throw Exception('Failed to update profile student: $e');
    }
  }

  Future<List<TechStack>> getTechStackDefault() async {
    final String url = '$baseUrl/techstack/getAllTechStack';

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
    final String url = '$baseUrl/skillset/getAllSkillSet';

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
}
