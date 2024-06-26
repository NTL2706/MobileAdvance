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
  final List<Project> _filteredProjects = [];

  int _selectedProjectLength = 4;
  final TextEditingController _numberOfStudentsController =
      TextEditingController();
  final TextEditingController _numberOfProposalsController =
      TextEditingController();
  final TextEditingController _searchController = TextEditingController();

  List<Project> get projects => _filteredProjects;

  int get selectedProjectLength => _selectedProjectLength;
  TextEditingController get numberOfStudentsController =>
      _numberOfStudentsController;
  TextEditingController get numberOfProposalsController =>
      _numberOfProposalsController;
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
    hasMore = true;
    notifyListeners();
  }

  void filterSearch() {
    hasMore = true;
    _filteredProjects.clear();
    notifyListeners();
  }

  void setSelectedProjectLength(int value) {
    _selectedProjectLength = value;
    notifyListeners();
  }

  void resetFilter() {
    hasMore = true;
    _selectedProjectLength = 4;
    _numberOfStudentsController.clear();
    _numberOfProposalsController.clear();
    notifyListeners();
  }

  Future<HttpResponse<List<Map<String, dynamic>>>?> getAllProjectForStudent(
      {required String token,
      required int studentId,
      int? page,
      int? perPage,
      String? title,
      String? projectScopeFlag,
      String? numberOfStudents,
      String? proposalsLessThan}) async {
    if (hasMore == false) {
      return null;
    }
    try {
      responseHttp = HttpResponse<List<Map<String, dynamic>>>.unknown();

      final Map<String, String> queryParameters = {};

      if (title != '') {
        queryParameters['title'] = title!;
      }
      if (numberOfStudents != '') {
        queryParameters['numberOfStudents'] = numberOfStudents!;
      }
      if (projectScopeFlag != '4') {
        queryParameters['projectScopeFlag'] = projectScopeFlag!;
      }
      if (proposalsLessThan != '') {
        queryParameters['proposalsLessThan'] = proposalsLessThan!;
      }
      if (title == '' &&
          numberOfStudents == '' &&
          projectScopeFlag == '4' &&
          proposalsLessThan == '') {
        queryParameters['page'] = page.toString();
        queryParameters['perPage'] = perPage.toString();
      }

      final uri = Uri(
        scheme: 'https',
        host: env.apiURL?.replaceAll("https://", "").replaceAll("/", ""),
        path: 'api/project',
        queryParameters: queryParameters,
      );

      final rs = await http.get(
          headers: {HttpHeaders.authorizationHeader: 'Bearer $token'}, uri);
      final favoriteProjectResponse = await http.get(
          headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
          Uri.parse("${env.apiURL}api/favoriteProject/$studentId"));

      final bodyFavourite = json.decode(favoriteProjectResponse.body);
      final body = json.decode(rs.body);

      if (rs.statusCode >= 400) {
        throw Exception(body['errorDetails']);
      }

      final result = List<Map<String, dynamic>>.from(body['result']);
      _projects = result.map((e) {
        return Project.fromJson(e);
      }).toList();

      if (_projects.length < perPage!) {
        hasMore = false;
      }

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
    } on Exception catch (e) {
      print(e);
    }
  }

  Future<void> applyProposal(

      {required String token,
      required int projectId,
      required int studentId,
      required String coverLetter,
      }) async {
    try {
      responseHttp = HttpResponse<Map<String, dynamic>>.unknown();
      Map<String, dynamic> data = Map();
      data['projectId'] = projectId;
      data['studentId'] = studentId;
      data['coverLetter'] = coverLetter;

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

  Future<void> updateProject({
    required String token,
    required int projectId,
    int? projectScopeFlag,
    String? title,
    String? description,
    int? numberOfStudents,
    int? typeFlag,
    int? status,
  })async{
    try{
    responseHttp = HttpResponse<Map<String, dynamic>>.unknown();
      Map<String, dynamic> data = Map();
      
      final rs1 = await http.get(Uri.parse("${env.apiURL}api/project/$projectId"),headers: {
            HttpHeaders.authorizationHeader: "Bearer $token",
            'Content-type': 'application/json',
            'Accept': 'application/json',
          },);

      final body1 = json.decode(rs1.body);
      if (rs1.statusCode >= 400){
        throw Exception(body1);
      }
      final projectResult = Map<String, dynamic>.from(body1['result']);

      data['projectScopeFlag'] = projectScopeFlag ?? projectResult['projectScopeFlag'];
      data['title'] = title ?? projectResult['title'];
      data['description'] = description ?? projectResult['description'];
      data['numberOfStudents'] = numberOfStudents ?? projectResult['numberOfStudents'];
      data['typeFlag'] = typeFlag ?? projectResult['typeFlag'];
      data['status'] = status ?? projectResult['status'];

      final rs2 = await http.patch(Uri.parse("${env.apiURL}api/project/$projectId"),
          headers: {
            HttpHeaders.authorizationHeader: "Bearer $token",
            'Content-type': 'application/json',
            'Accept': 'application/json',
          },
          body: json.encode(data));

      final body = json.decode(rs2.body);
      if (body["errorDetails"] != null) {
        throw Exception(body);
      }

      final result = Map<String, dynamic>.from(body['result']);
      responseHttp.updateResponse({"result": result, "status": rs2.statusCode});
    } on Exception catch (e) {
      Map<String,dynamic> error = json.decode(e.toString());
      print(error);
      responseHttp.updateResponse({"message": error});
    }
  }
}
