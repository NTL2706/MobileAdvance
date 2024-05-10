import 'package:final_project_advanced_mobile/constants/colors.dart';
import 'package:final_project_advanced_mobile/constants/text_style.dart';
import 'package:final_project_advanced_mobile/feature/profie/models/profile.dart';
import 'package:final_project_advanced_mobile/feature/profie/provider/profile_provider.dart';
import 'package:final_project_advanced_mobile/feature/profie/widgets/input.dart';
import 'package:final_project_advanced_mobile/feature/profie/widgets/skill_widget.dart';
import 'package:final_project_advanced_mobile/languages/language.dart';
import 'package:final_project_advanced_mobile/services/language_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class ExperienceScreen extends StatefulWidget {
  List<Skill> selectedSkills = [];
  int studentId;

  ExperienceScreen(
      {super.key, this.selectedSkills = const [], required this.studentId});

  @override
  State<ExperienceScreen> createState() => _ExperienceScreenState();
}

class _ExperienceScreenState extends State<ExperienceScreen> {
  List<Project> projects = [];
  final profileStudentProvider = ProfileProvider();

  void _loadSkillsDefault() async {
    await profileStudentProvider.getProjectByStudentId(widget.studentId);

    setState(() {
      projects = profileStudentProvider.projects;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadSkillsDefault();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(""),
        elevation: 0,
      ),
      body: Column(
        children: [_appDetailProfileBar(), _appDetailProfile()],
      ),
    );
  }

  Widget _appDetailProfileBar() {
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 80,
            height: 80,
            child: CircleAvatar(
              backgroundImage: AssetImage("assets/images/logo.png"),
              radius: 40,
            ),
          ),
          SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Nguyen Van A",
                style: AppTextStyles.headerStyle,
              ),
              Text("HCMUS", style: AppTextStyles.bodyStyle),
              Text(Languages.of(context)!.student,
                  style: AppTextStyles.bodyStyle),
            ],
          ),
        ],
      ),
    );
  }

  Widget _appDetailProfile() {
    return Expanded(
      child: Container(
          padding: const EdgeInsets.all(20.0),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
            ),
            color: AppColors.backgroundColor,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: null,
                      enabled: false,
                      decoration: InputDecoration(
                        labelText: Languages.of(context)!.experience,
                        labelStyle: AppTextStyles.headerStyle,
                        disabledBorder: InputBorder.none,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      _addProject(context);
                    },
                    icon: Icon(Icons.add),
                  ),
                ],
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: projects.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 8.0),
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Color.fromARGB(255, 84, 68, 68),
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: ListTile(
                              title: Text(projects[index].name,
                                  style: AppTextStyles.titleStyle),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${Languages.of(context)!.startTime}: ${DateFormat('dd/MM/yyyy').format(projects[index].startDate)}',
                                    style: AppTextStyles.bodyStyle,
                                  ),
                                  Text(
                                    '${Languages.of(context)!.endTime}: ${DateFormat('dd/MM/yyyy').format(projects[index].endDate)}',
                                    style: AppTextStyles.bodyStyle,
                                  ),
                                  Text(
                                    '${Languages.of(context)!.description}: ${projects[index].description}',
                                    style: AppTextStyles.bodyStyle,
                                  ),
                                  SizedBox(height: 8.0),
                                  Wrap(
                                    spacing: 8.0,
                                    runSpacing: 8.0,
                                    children: [
                                      ...projects[index].skillSet.map((skill) {
                                        return Chip(
                                          label: Text(skill.name),
                                        );
                                      }).toList(),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            top: 0,
                            right: 0,
                            child: IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                setState(() {
                                  projects.removeAt(index);
                                });
                                profileStudentProvider.updatedProjectStudent(
                                    studentId: widget.studentId,
                                    projects: projects);
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          )),
    );
  }

  void _addProject(BuildContext context) {
    Project newProject = Project(
      name: 'New Project',
      startDate: DateTime.now(),
      endDate: DateTime.now(),
      description: '',
      skillSet: [],
    );

    _navigateToProjectForm(context, newProject);
  }

  void _navigateToProjectForm(BuildContext context, Project project) async {
    final updatedProject = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProjectFormScreen(
          project: project,
          onSave: (Project? editedProject) {
            if (editedProject != null) {
              setState(() {
                projects.add(editedProject);
              });
              profileStudentProvider.updatedProjectStudent(
                  studentId: widget.studentId, projects: projects);
            }
          },
          skills: widget.selectedSkills,
        ),
      ),
    );

    if (updatedProject != null) {
      setState(() {
        projects.add(updatedProject);
      });

      profileStudentProvider.updatedProjectStudent(
          studentId: widget.studentId, projects: projects);
    }
  }
}

class ProjectFormScreen extends StatefulWidget {
  final Project project;
  final Function(Project) onSave;

  List<Skill> skills = [];

  ProjectFormScreen(
      {super.key,
      required this.project,
      required this.onSave,
      this.skills = const []});

  @override
  _ProjectFormScreenState createState() => _ProjectFormScreenState();
}

class _ProjectFormScreenState extends State<ProjectFormScreen> {
  List<Skill> selectedSkills = [];

  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController skillSetController = TextEditingController();

  DateTime _selectedEndDate = DateTime.now();
  DateTime _selectedStartDate = DateTime.now();

  final profileStudentProvider = ProfileProvider();

  @override
  void initState() {
    super.initState();
    nameController.text = widget.project.name;
    descriptionController.text = widget.project.description;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Languages.of(context)!.projects),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: nameController,
              decoration:
                  InputDecoration(labelText: Languages.of(context)!.name),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(
                  labelText: Languages.of(context)!.description),
            ),
            SizedBox(height: 16.0),
            SkillWidget(
              selectedSkills: selectedSkills
                  .map((skill) => Skill(id: skill.id, name: skill.name))
                  .toList(),
              skills: widget.skills,
              onSkillSelected: (Skill value) {
                setState(() {
                  selectedSkills.add(value);
                });
              },
              onSkillRemoved: (Skill value) {
                setState(() {
                  selectedSkills.remove(value);
                });
              },
            ),
            SizedBox(height: 16.0),
            MyInput(
              title: Languages.of(context)!.startTime,
              hint: DateFormat.yMd().format(_selectedStartDate),
              widget: IconButton(
                icon: const Icon(Icons.calendar_today_outlined),
                onPressed: () {
                  _getDateFromUser(true);
                },
              ),
            ),
            MyInput(
              title: Languages.of(context)!.endTime,
              hint: DateFormat.yMd().format(_selectedEndDate),
              widget: IconButton(
                icon: const Icon(Icons.calendar_today_outlined),
                onPressed: () {
                  _getDateFromUser(false);
                },
              ),
            ),
            SizedBox(height: 16.0),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    _saveProject(context);
                  },
                  child: Text(Languages.of(context)!.save),
                ),
                SizedBox(width: 20.0),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(Languages.of(context)!.cancel),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void _saveProject(BuildContext context) {
    widget.project.name = nameController.text;
    widget.project.description = descriptionController.text;
    widget.project.skillSet = selectedSkills;
    widget.project.startDate = _selectedStartDate;
    widget.project.endDate = _selectedEndDate;

    widget.onSave(widget.project);

    Navigator.pop(context);
  }

  _getDateFromUser(bool check) async {
    DateTime? _pickedDate = await showDatePicker(
        context: context,
        initialDate: _selectedEndDate,
        firstDate: DateTime(2016),
        lastDate: DateTime(2125));

    if (_pickedDate != null) {
      if (check) {
        setState(() {
          _selectedStartDate = _pickedDate;
        });
      } else {
        setState(() {
          _selectedEndDate = _pickedDate;
        });
      }
    } else {
      print("It`s null or something error");
    }
  }
}
