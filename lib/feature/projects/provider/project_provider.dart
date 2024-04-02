import 'package:flutter/material.dart';
import '../constants/projetcs_type.dart';

class ProjectProvider extends ChangeNotifier {
  List<Project> _projects = [
    Project(
        '1',
        'Project A',
        DateTime(2023, 10, 15),
        20,
        [1],
        [
          'Description A1 Description A1 Description A1 Description A1 Description A1 Description A1',
          'Description A2',
          'Description A3'
        ],
        false),
    Project('2', 'Project B', DateTime(2024, 2, 28), 15, [1, 2],
        ['Description B1', 'Description B2'], false),
    Project(
        '3',
        'Project C',
        DateTime(2024, 3, 5),
        30,
        [2, 3],
        [
          'Description C1',
          'Description C2',
          'Description C3',
          'Description C4'
        ],
        false),
    Project('4', 'Project D', DateTime(2024, 1, 10), 25, [4],
        ['Description D1'], false),
    Project(
        '5',
        'Project E',
        DateTime(2024, 4, 1),
        18,
        [5, 9],
        [
          'Description E1',
          'Description E2',
          'Description E3',
          'Description E4',
          'Description E5',
          'Description E6'
        ],
        false),
  ];
  List<Project> _filteredProjects = [];
  int _selectedProjectLength = 0;
  final TextEditingController _numberOfStudentsController =TextEditingController();
  final TextEditingController _searchController = TextEditingController();

  ProjectProvider() {
    _filteredProjects = List.from(_projects);
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
    _projects = newProjects;
    notifyListeners();
  }

  void toggleFavoriteStatus(String id) {
    int index = _projects.indexWhere((project) => project.id == id);
    if (index != -1) {
      _projects[index].isFavourite = !_projects[index].isFavourite;
    }
    notifyListeners();
  }

  void updateSearch() {
    if (_searchController.text.isEmpty) {
      _filteredProjects = List.from(_projects);
    } else {
      _filteredProjects = _projects
          .where((project) => project.name
              .toLowerCase()
              .contains(_searchController.text.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  void filterSearch() {
    late bool isFilter = false;
    updateSearch();
    _filteredProjects = _filteredProjects.where((project) {
      if (_numberOfStudentsController.text.isNotEmpty) {
        if (project.numberOfPeople <=
            int.parse(_numberOfStudentsController.text)) {
          isFilter = true;
        } else {
          isFilter = false;
        }
      }

      if (project.time.length == 1) {
        if (project.time[0] >= projectLengths[_selectedProjectLength][0] &&
            project.time[0] <= projectLengths[_selectedProjectLength][1]) {
          isFilter = true;
        } else {
          isFilter = false;
        }
      } else if (project.time.length == 2) {
        if (project.time[0] >= projectLengths[_selectedProjectLength][0] &&
                project.time[0] <= projectLengths[_selectedProjectLength][1] ||
            project.time[1] >= projectLengths[_selectedProjectLength][0] &&
                project.time[1] <= projectLengths[_selectedProjectLength][1]) {
          isFilter = true;
        } else {
          isFilter = false;
        }
      }

      return isFilter;
    }).toList();

    notifyListeners();
  }

  void setSelectedProjectLength(int value) {
    _selectedProjectLength = value;
    notifyListeners();
  }

  void resetFilter() {
    _selectedProjectLength = 0;
    _numberOfStudentsController.clear();
    updateSearch();
    notifyListeners();
  }
}
