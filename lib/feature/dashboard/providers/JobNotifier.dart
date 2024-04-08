import 'dart:convert';
import 'dart:io';
import 'package:final_project_advanced_mobile/feature/dashboard/views/post_a_project/models/job_model.dart';
import 'package:final_project_advanced_mobile/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class JobNotifier extends ChangeNotifier {
  List<JobModel>? _jobList;
  List<JobModel>? get jobList => _jobList;
  List<Map<String, dynamic>>? _proposalListOfStudent;
  List<Map<String, dynamic>>? get proposalListOfStudent => _proposalListOfStudent;
  Future<void>getProjectOfEachStudent({required int studentId, required String token})async{
    try {
      final response = await http.get(headers: {
        HttpHeaders.authorizationHeader: "Bearer $token",
        'Content-type': 'application/json',
        'Accept': 'application/json',
      }, Uri.parse("${env.apiURL}api/proposal/student/$studentId"));
      final body = json.decode(response.body);
    }on Exception catch (e) {
      print(e);
    }
  }

  Future<Map<String, dynamic>> getProposalOfStudent(
      {required int studentId, required String token}) async {
    try {

      final response = await http.get(headers: {
        HttpHeaders.authorizationHeader: "Bearer $token",
        'Content-type': 'application/json',
        'Accept': 'application/json',
      }, Uri.parse("${env.apiURL}api/proposal/student/$studentId"));

      final body = json.decode(response.body);

      List<Map<String, dynamic>> projectList = [];

      if (response.statusCode >= 400) {
        throw Exception(body['errorDetails']);
      }

      final proposalListOfStudent = List<Map<String, dynamic>>.from(body['result']);

      for (int i = 0; i < proposalListOfStudent.length; i++) {
        final project = await http.get(
            headers: {
              HttpHeaders.authorizationHeader: "Bearer $token",
              'Content-type': 'application/json',
              'Accept': 'application/json',
            },
            Uri.parse("${env.apiURL}api/project/${proposalListOfStudent[i]['projectId']}"
        ));

        final bodyProject = json.decode(project.body);

        Map<String, dynamic> convertToProject = Map<String, dynamic>.from(bodyProject['result']['project']);

        convertToProject.addAll(
          {
            'countProposals': bodyProject['result']['countProposals'],
            'countMessages': bodyProject['result']['countProposals'],
            'countHired': bodyProject['result']['countHired'],
          }
        );

        if (project.statusCode >= 400){
          throw Exception(bodyProject['errorDetails']);
        }

        projectList.add(convertToProject);
      }

      return {"result": projectList, "error": null};
    } on Exception catch (e) {
      return {"error": e.toString()};
    }
  }

  Future<Map<String, dynamic>> addJob(
      {
        required String token,
        required String? title,
      String? createAt,
      String? deletedAt,
      String? updateAt,
      required String? description,
      required String? companyId,
      int? numberOfStudents = 0,
      int? projectScopeFlag = 0,
      int? typeFlag = 0,
      int hiredNumber = 0,
      int messagesNumber = 0,
      int proposalNumber = 0}) async {
    try {
      Map<String, dynamic> data = Map();
      data['companyId'] = companyId;
      data['projectScopeFlag'] = projectScopeFlag;
      data['title'] = title;
      data['numberOfStudents'] = numberOfStudents;
      data['description'] = description;
      data['typeFlag'] = typeFlag;
      print(companyId);
      print(projectScopeFlag);
      print(description);

      final response = await http.post(Uri.parse("${env.apiURL}api/project"),
          body: json.encode(data),
          headers: {
            HttpHeaders.authorizationHeader: 'Bearer $token',
            'Content-type': 'application/json',
            'Accept': 'application/json',
          });
      final body = json.decode(response.body);
      if (response.statusCode >= 400) {
        throw Exception(body['errorDetails']);
      }
      notifyListeners();
      return {"result": body['result'], "error": null};
    } on Exception catch (e) {
      print(e);
      return {"result": null, "error": e.toString()};
    }
  }

  Future<void> deleteJob({required int id}) async {
    try {
      print(id);
      final response =
          await http.delete(Uri.parse("${env.apiURL}api/project/$id"));
      final body = json.decode(response.body);

      notifyListeners();
      if (response.statusCode >= 400) {
        throw Exception(body['errorDetails']);
      }
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  Future<Map<String, dynamic>> getDashboardProject(
      {required int companyId, required String token}) async {
    try {
      print("call getDashboardProject");
      final response = await http.get(
          headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
          Uri.parse("${env.apiURL}api/project/company/$companyId"));
      final body = json.decode(response.body);
      if (response.statusCode >= 400) {
        throw Exception(body['errorDetails']);
      }

      final projectList = List<Map<String, dynamic>>.from(body['result']);
      // for (int i = 0; i < projectList.length; i++){
      //   final numberProposal = await getProjectProposal(projectId: projectList[i]['id'], token: token);
      //   projectList[i].addAll({
      //     "numberProposal":numberProposal['result']
      //   });
      // }

      return {
        "result": List<Map<String, dynamic>>.from(body['result']),
        "error": null
      };
    } on Exception catch (e) {
      print(e.toString());
      return {"error": e.toString()};
    }
  }

  Future<Map<String, dynamic>> getProjectProposal(
      {required int projectId, required String token}) async {
    try {
      final response = await http.get(
          headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
          Uri.parse("${env.apiURL}api/proposal/getByProjectId/$projectId"));
      final body = json.decode(response.body);

      if (response.statusCode >= 400) {
        print(response.statusCode);
        throw Exception(body['errorDetails']);
      }

      return {"result": body['result']['total'], "error": null};
    } on Exception catch (e) {
      print(e.toString());
      return {"error": e.toString()};
    }
  }

}
