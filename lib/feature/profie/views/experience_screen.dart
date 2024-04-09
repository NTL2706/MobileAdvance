import 'package:final_project_advanced_mobile/constants/colors.dart';
import 'package:final_project_advanced_mobile/constants/text_style.dart';
import 'package:final_project_advanced_mobile/feature/profie/models/project_experience.dart';
import 'package:final_project_advanced_mobile/feature/profie/models/skill.dart';
import 'package:final_project_advanced_mobile/feature/profie/widgets/input.dart';
import 'package:final_project_advanced_mobile/feature/profie/widgets/skill_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class ExperienceScreen extends StatefulWidget {
  const ExperienceScreen({super.key});

  @override
  State<ExperienceScreen> createState() => _ExperienceScreenState();
}

class _ExperienceScreenState extends State<ExperienceScreen> {
  final TextEditingController _controller =
      TextEditingController(text: 'DevOps');

  List<Skill> selectedSkills = [];

  final List<Project> projects = [];

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
      child: const Row(
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
              Text("Student", style: AppTextStyles.bodyStyle),
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
                      decoration: const InputDecoration(
                        labelText: 'Project experience',
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
                    return ListTile(
                      title: Text(projects[index].name),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Start Date: ${DateFormat('dd/MM/yyyy').format(projects[index].startDate)}',
                            style: AppTextStyles.bodyStyle,
                          ),
                          Text(
                            'End Date: ${DateFormat('dd/MM/yyyy').format(projects[index].endDate)}',
                            style: AppTextStyles.bodyStyle,
                          ),
                          Text(
                            'Description: ${projects[index].description}',
                            style: AppTextStyles.bodyStyle,
                          ),
                          Wrap(
                            spacing: 8.0,
                            runSpacing: 8.0,
                            children: [
                              ...projects[index].skillSet.map((skill) {
                                return Chip(
                                  label: Text(skill.name),
                                  onDeleted: () {},
                                );
                              }).toList(),
                            ],
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
              }
            }),
      ),
    );

    if (updatedProject != null) {
      setState(() {
        projects.add(updatedProject);
      });
    }
  }
}

class ProjectFormScreen extends StatefulWidget {
  final Project project;
  final Function(Project) onSave;

  ProjectFormScreen({super.key, required this.project, required this.onSave});

  @override
  _ProjectFormScreenState createState() => _ProjectFormScreenState();
}

class _ProjectFormScreenState extends State<ProjectFormScreen> {
  List<Skill> skills = [
  ];

  List<Skill> selectedSkills = [];

  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController skillSetController = TextEditingController();

  DateTime _selectedEndDate = DateTime.now();
  DateTime _selectedStartDate = DateTime.now();

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
        title: Text('Project Form'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            SizedBox(height: 16.0),
            SkillWidget(
              selectedSkills: selectedSkills.map((skill) => Skill(id: skill.id, name: skill.name)).toList(),
              skills: skills,
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
              title: "Start Time",
              hint: DateFormat.yMd().format(_selectedStartDate),
              widget: IconButton(
                icon: const Icon(Icons.calendar_today_outlined),
                onPressed: () {
                  _getDateFromUser(true);
                },
              ),
            ),
            MyInput(
              title: "End Time",
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
                  child: Text('Save'),
                ),
                SizedBox(width: 20.0),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancel'),
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
