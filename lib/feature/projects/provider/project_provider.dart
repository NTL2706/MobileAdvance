

import 'dart:convert';
import 'dart:io';

import 'package:final_project_advanced_mobile/main.dart';
import 'package:final_project_advanced_mobile/utils/http_response.dart';
import 'package:flutter/material.dart';
import '../constants/projetcs_type.dart';
import "package:http/http.dart" as http;
class ProjectProvider extends ChangeNotifier {
  HttpResponse responseHttp = HttpResponse<List<Map<String,dynamic>>>.unknown();
  List<Map<String,dynamic>>? favouriteProjectList;
  // List<Project> _projects = [ 
  //   Project(
  //       '1',
  //       'Project A',
  //       DateTime(2023, 10, 15),
  //       20,
  //       [1],
  //       [
  //         'Description A1 Description A1 Description A1 Description A1 Description A1 Description A1',
  //         'Description A2',
  //         'Description A3'
  //       ],
  //       false),
  //   Project('2', 'Project B', DateTime(2024, 2, 28), 15, [1, 2],
  //       ['Description B1', 'Description B2'], false),
  //   Project(
  //       '3',
  //       'Project C',
  //       DateTime(2024, 3, 5),
  //       30,
  //       [2, 3],
  //       [
  //         'Description C1',
  //         'Description C2',
  //         'Description C3',
  //         'Description C4'
  //       ],
  //       false),
  //   Project('4', 'Project D', DateTime(2024, 1, 10), 25, [4],
  //       ['Description D1'], false),
  //   Project(
  //       '5',
  //       'Project E',
  //       DateTime(2024, 4, 1),
  //       18,
  //       [5, 9],
  //       [
  //         'Description E1',
  //         'Description E2',
  //         'Description E3',
  //         'Description E4',
  //         'Description E5',
  //         'Description E6'
  //       ],
  //       false),
  // ];
  List<Project> _filteredProjects = [];
  int _selectedProjectLength = 0;
  final TextEditingController _numberOfStudentsController =TextEditingController();
  final TextEditingController _searchController = TextEditingController();

  ProjectProvider() {
    
  }

  List<Project> get projects => _filteredProjects;
  int get selectedProjectLength => _selectedProjectLength;
  TextEditingController get numberOfStudentsController =>
      _numberOfStudentsController;
  TextEditingController get searchController => _searchController;
  
  List<List<int>> projectLengths = [
    [0, 1000],
    [1, 3],
    [4, 6],
    [6, 1000]
  ];

  // Phương thức để cập nhật danh sách dự án
  void updateProjects(List<Project> newProjects) {
    // _projects = newProjects;
    notifyListeners();
  }

  Future<void> toggleFavoriteStatus({
    required int studentId,
    required int projectId,
    required bool disableFlag,
    required String token
    } )async {
    try {
      print(studentId);
      print(projectId);
      print(disableFlag);
      Map<String,dynamic> data = Map();
      data['projectId'] = projectId;
      data['disableFlag'] = !disableFlag;
      final rs = await http.patch(
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          HttpHeaders.authorizationHeader:"Bearer $token"
        },
        Uri.parse("${env.apiURL}api/favoriteProject/$studentId"),body: json.encode(data));

      final body = json.decode(rs.body);
      if(rs.statusCode >= 400){
        throw Exception(body['errorDetails']);
      } 
    }on Exception catch (e) {
      print(e);
    }
    
  }
  
  void updateSearch() {
    // if (_searchController.text.isEmpty) {
    //   _filteredProjects = List.from(_projects);
    // } else {
    //   _filteredProjects = _projects
    //       .where((project) => project.name
    //           .toLowerCase()
    //           .contains(_searchController.text.toLowerCase()))
    //       .toList();
    // }
    notifyListeners();
  }

  void filterSearch() {
    // late bool isFilter = false;
    // updateSearch();
    // _filteredProjects = _filteredProjects.where((project) {
    //   if (_numberOfStudentsController.text.isNotEmpty) {
    //     if (project.numberOfPeople <=
    //         int.parse(_numberOfStudentsController.text)) {
    //       isFilter = true;
    //     } else {
    //       isFilter = false;
    //     }
    //   }

    //   if (project.time.length == 1) {
    //     if (project.time[0] >= projectLengths[_selectedProjectLength][0] &&
    //         project.time[0] <= projectLengths[_selectedProjectLength][1]) {
    //       isFilter = true;
    //     } else {
    //       isFilter = false;
    //     }
    //   } else if (project.time.length == 2) {
    //     if (project.time[0] >= projectLengths[_selectedProjectLength][0] &&
    //             project.time[0] <= projectLengths[_selectedProjectLength][1] ||
    //         project.time[1] >= projectLengths[_selectedProjectLength][0] &&
    //             project.time[1] <= projectLengths[_selectedProjectLength][1]) {
    //       isFilter = true;
    //     } else {
    //       isFilter = false;
    //     }
    //   }

    //   return isFilter;
    // }).toList();

    notifyListeners();
  }

  void setSelectedProjectLength(int value) {
    // _selectedProjectLength = value;
    notifyListeners();
  }

  void resetFilter() {
    _selectedProjectLength = 0;
    _numberOfStudentsController.clear();
    updateSearch();
    notifyListeners();
  }

  Future<HttpResponse<List<Map<String,dynamic>>>> getAllProjectForStudent(
    {
      required String token,
      required int studentId
    }
  )async{
    try{
      responseHttp = HttpResponse<List<Map<String,dynamic>>>.unknown();
      final rs = await http.get(
        headers: {
          HttpHeaders.authorizationHeader:'Bearer $token'
        },
        Uri.parse('${env.apiURL}api/project'));
      final favoriteProjectResponse = await http.get(
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $token'
        },
        Uri.parse("${env.apiURL}api/favoriteProject/$studentId"));
      
      final bodyFavourite = json.decode(favoriteProjectResponse.body);
      final body = json.decode(rs.body);

      final result = List<Map<String,dynamic>>.from(body['result']);
      final favouriteProject = List<Map<String,dynamic>>.from(bodyFavourite['result']);
      favouriteProjectList = favouriteProject;
      
      if (rs.statusCode >= 400){
        throw Exception(body);
      }
      
      responseHttp.updateResponse({
        "result": result,
        "status": rs.statusCode
      });
      return responseHttp as HttpResponse<List<Map<String,dynamic>>>;
    }on Exception catch(e){
      print(e);
      return responseHttp as HttpResponse<List<Map<String,dynamic>>>;
    }
  }

  Future<void> applyProposal({
    required String token,
    required int projectId,
    required int studentId,
    required String coverLetter,
    required bool disableFlag
  })async{
    try{
      responseHttp = HttpResponse<Map<String,dynamic>>.unknown();
      Map<String, dynamic> data = Map();
      data['projectId'] = projectId;
      data['studentId'] = studentId;
      data['coverLetter'] = coverLetter;
      data['statusFlag'] = 0;
      data['disableFlag'] = disableFlag == false ? 0 : 1;
      final rs = await http.post(
        Uri.parse("${env.apiURL}api/proposal"),
        headers: {
          HttpHeaders.authorizationHeader: "Bearer $token",
          'Content-type': 'application/json',
          'Accept': 'application/json',
        },
        body: json.encode(data)
      );

      final body = json.decode(rs.body);
      if (body["errorDetails"] != null){
        throw Exception(body["errorDetails"]);
      }
      
      final result = Map<String,dynamic>.from(body['result']);
      responseHttp.updateResponse({
        "result": result,
        "status": rs.statusCode
      });
    }on Exception catch(e){
      print(e);
      responseHttp.updateResponse({
        "message": e.toString()
      });
    }
  }
}
