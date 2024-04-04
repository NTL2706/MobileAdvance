import 'package:flutter/material.dart';

class Project {
  String name;
  DateTime startDate;
  DateTime endDate;
  String description;
  List<String> skillSet;

  Project({
    required this.name,
    required this.startDate,
    required this.endDate,
    required this.description,
    required this.skillSet,
  });
}

class MyApp extends StatelessWidget {
  final List<Project> projects = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Project List',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Project List'),
        ),
        body: ListView.builder(
          itemCount: projects.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(projects[index].name),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Start Date: ${projects[index].startDate.toString()}',
                  ),
                  Text(
                    'End Date: ${projects[index].endDate.toString()}',
                  ),
                  Text(
                    'Description: ${projects[index].description}',
                  ),
                  Text(
                    'Skill Set: ${projects[index].skillSet.join(", ")}',
                  ),
                ],
              ),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _addProject(context);
          },
          child: Icon(Icons.add),
        ),
      ),
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

  void _navigateToProjectForm(BuildContext context, Project project) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProjectFormScreen(project: project),
      ),
    );
  }
}

class ProjectFormScreen extends StatefulWidget {
  final Project project;

  ProjectFormScreen({required this.project});

  @override
  _ProjectFormScreenState createState() => _ProjectFormScreenState();
}

class _ProjectFormScreenState extends State<ProjectFormScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController skillSetController = TextEditingController();

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
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: skillSetController,
                    decoration: InputDecoration(labelText: 'Skill Set'),
                  ),
                ),
                IconButton(
                  onPressed: _addSkillSet,
                  icon: Icon(Icons.add),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                _saveProject(context);
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  void _addSkillSet() {
    setState(() {
      widget.project.skillSet.add(skillSetController.text);
      skillSetController.clear();
    });
  }

  void _saveProject(BuildContext context) {
    widget.project.name = nameController.text;
    widget.project.description = descriptionController.text;

    Navigator.pop(context);
  }
}
