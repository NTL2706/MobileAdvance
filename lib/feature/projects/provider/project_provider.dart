import 'dart:convert';
import 'dart:io';
import 'package:final_project_advanced_mobile/constants/status_flag.dart';
import 'package:final_project_advanced_mobile/main.dart';
import 'package:final_project_advanced_mobile/utils/http_response.dart';
import 'package:flutter/material.dart';
import '../constants/projetcs_type.dart';
import "package:http/http.dart" as http;
import 'package:collection/collection.dart';

class ProjectProvider extends ChangeNotifier {
  HttpResponse responseHttp =
      HttpResponse<List<Map<String, dynamic>>>.unknown();
  List<Map<String, dynamic>>? favouriteProjectList;
  List<Project> _projects = [];
  List<Project> _filteredProjects = [];
  int _selectedProjectLength = 0;
  final TextEditingController _numberOfStudentsController =
      TextEditingController();
  final TextEditingController _searchController = TextEditingController();

  List<Project> get projects => _filteredProjects;
  int get selectedProjectLength => _selectedProjectLength;
  TextEditingController get numberOfStudentsController =>
      _numberOfStudentsController;
  TextEditingController get searchController => _searchController;
  bool? hasMore = true;

  Future<void> toggleFavoriteStatus(
      {required int studentId,
      required int projectId,
      required bool disableFlag,
      required String token}) async {
    try {
      print(studentId);
      print(projectId);
      print(disableFlag);
      Map<String, dynamic> data = Map();
      data['projectId'] = projectId;
      data['disableFlag'] = !disableFlag;
      final rs = await http.patch(
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
            HttpHeaders.authorizationHeader: "Bearer $token"
          },
          Uri.parse("${env.apiURL}api/favoriteProject/$studentId"),
          body: json.encode(data));

      final body = json.decode(rs.body);
      if (rs.statusCode >= 400) {
        throw Exception(body['errorDetails']);
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  void updateSearch() {
    _filteredProjects.clear();
    notifyListeners();
  }

  void filterSearch() {
    _filteredProjects.clear();
    notifyListeners();
  }

  void setSelectedProjectLength(int value) {
    _selectedProjectLength = value;
    notifyListeners();
  }

  void resetFilter() {
    notifyListeners();
  }

  Future<HttpResponse<List<Map<String, dynamic>>>> getAllProjectForStudent(
      {required String token,
      required int studentId,
      int? page,
      int? perPage,
      String? title,
      int? projectScopeFlag,
      int? numberOfStudents,
      int? proposalsLessThan}) async {
    try {
      responseHttp = HttpResponse<List<Map<String, dynamic>>>.unknown();
      hasMore = true;
      final uri = Uri(
        scheme: 'https',
        host: env.apiURL?.replaceAll("https://", "").replaceAll("/", ""),
        path: 'api/project',
        queryParameters: {
          "page":page.toString(),
          "perPage":perPage.toString(),
          "title": title,
        }
      );
      print(uri);
      final rs = await http.get(
          headers: {HttpHeaders.authorizationHeader: 'Bearer $token'}, uri);
      final favoriteProjectResponse = await http.get(
          headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
          Uri.parse("${env.apiURL}api/favoriteProject/$studentId"));

      final bodyFavourite = json.decode(favoriteProjectResponse.body);
      final body = json.decode(rs.body);

     if (rs.statusCode >= 400) {
        throw Exception(body);
      }

     
      final result = List<Map<String, dynamic>>.from(body['result']);
      _projects = result.map((e) {
        return Project.fromJson(e);
      }).toList();

      _filteredProjects.addAll(_projects);

      final favouriteProject =
          List<Map<String, dynamic>>.from(bodyFavourite['result']);
      favouriteProjectList = favouriteProject;
 
      
      
      responseHttp.updateResponse({"result": result, "status": rs.statusCode});
      
      return responseHttp as HttpResponse<List<Map<String, dynamic>>>;
    } on Exception catch (e) {
      print(e);
      hasMore = false;
      return responseHttp as HttpResponse<List<Map<String, dynamic>>>;
    }
  }

  Future<void> checkApply(
      {required String token, required int studentId}) async {
    try {
     
      final rs = await http.get(
          headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
          Uri.parse("${env.apiURL}api/proposal/student/$studentId"));
      final body = json.decode(rs.body);
      if (rs.statusCode >= 400) {
        throw Exception(body);
      }

      final proposals = List<Map<String, dynamic>>.from(body['result']);
      proposals.forEach((proposal) {
        _filteredProjects.removeWhere((element) {
          // print(element.id ==  proposal['projectId']);
          if (proposal['projectId'] == element.id) {
            print(element.title);
          }
          return proposal['projectId'] == element.id;
        });
      });

    }on Exception catch (e) {
      print(e);
    }
  }

  Future<void> applyProposal(
      {required String token,
      required int projectId,
      required int studentId,
      required String coverLetter,
      required bool disableFlag}) async {
    try {
      responseHttp = HttpResponse<Map<String, dynamic>>.unknown();
      Map<String, dynamic> data = Map();
      data['projectId'] = projectId;
      data['studentId'] = studentId;
      data['coverLetter'] = coverLetter;
      data['statusFlag'] = statusFlag;
      data['disableFlag'] = disableFlag == false ? 0 : 1;
      final rs = await http.post(Uri.parse("${env.apiURL}api/proposal"),
          headers: {
            HttpHeaders.authorizationHeader: "Bearer $token",
            'Content-type': 'application/json',
            'Accept': 'application/json',
          },
          body: json.encode(data));

      final body = json.decode(rs.body);
      if (body["errorDetails"] != null) {
        throw Exception(body["errorDetails"]);
      }

      final result = Map<String, dynamic>.from(body['result']);
      responseHttp.updateResponse({"result": result, "status": rs.statusCode});
    } on Exception catch (e) {
      print(e);
      responseHttp.updateResponse({"message": e.toString()});
    }
  }
}
