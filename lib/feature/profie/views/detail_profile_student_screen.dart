import 'package:final_project_advanced_mobile/constants/colors.dart';
import 'package:final_project_advanced_mobile/constants/text_style.dart';
import 'package:final_project_advanced_mobile/feature/profie/views/test.dart';
import 'package:flutter/material.dart';

class DetailProfileStudentScreen extends StatefulWidget {
  const DetailProfileStudentScreen({super.key});

  @override
  State<DetailProfileStudentScreen> createState() =>
      _DetailProfileStudentScreenState();
}

class _DetailProfileStudentScreenState
    extends State<DetailProfileStudentScreen> {
  final TextEditingController _controller =
      TextEditingController(text: 'DevOps');

  String? selectedExpertise = 'Fullstack';

  List<String> skills = [
    'Flutter',
    'Dart',
    'Firebase',
    'UI/UX Design',
    'Backend Development',
    'Frontend Development',
    'Mobile Development',
    'Web Development',
    'Database Management'
  ];

  List<String> selectedSkills = [];

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
        child: ListView(
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    // builder: (context) => const DetailProfileCompanyScreen(),
                    builder: (context) => SchoolListScreen(),
                  ),
                );
              },
              child: Text('Update'),
            ),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: TextEditingController(text: selectedExpertise),
                    enabled: false,
                    decoration: const InputDecoration(
                      labelText: 'Tech stack',
                      labelStyle: AppTextStyles.headerStyle,
                      disabledBorder: InputBorder.none,
                    ),
                  ),
                ),
                PopupMenuButton<String>(
                  onSelected: (String value) {
                    setState(() {
                      setState(() {
                        selectedExpertise = value;
                      });
                    });
                  },
                  itemBuilder: (BuildContext context) => [
                    'Fullstack',
                    'Mobile',
                    'Backend',
                    'Frontend',
                    'DevOps',
                    'QA',
                    'Other'
                  ].map<PopupMenuItem<String>>((String value) {
                    return PopupMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  icon: Icon(Icons.edit),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: null, // Tạo một TextEditingController mới
                        enabled: false,
                        decoration: const InputDecoration(
                          labelText: 'Skill',
                          labelStyle: AppTextStyles.bodyStyle,
                          disabledBorder: InputBorder.none,
                        ),
                      ),
                    ),
                    PopupMenuButton<String>(
                      onSelected: (String value) {
                        setState(() {
                          setState(() {
                            selectedSkills.add(value);
                          });
                        });
                      },
                      itemBuilder: (BuildContext context) =>
                          skills.map((String skill) {
                        return PopupMenuItem<String>(
                          value: skill,
                          child: Text(skill),
                        );
                      }).toList(),
                      icon: Icon(Icons.add),
                    ),
                  ],
                ),
                // Wrap widget to display selected skills
                Wrap(
                  spacing: 8.0,
                  runSpacing: 8.0,
                  children: [
                    ...selectedSkills.map((skill) {
                      return Chip(
                        label: Text(skill),
                        onDeleted: () {
                          setState(() {
                            selectedSkills.remove(skill);
                          });
                        },
                      );
                    }).toList(),
                  ],
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller:
                        TextEditingController(), // Tạo một TextEditingController mới
                    enabled: false,
                    decoration: const InputDecoration(
                      labelText: 'Skill',
                      labelStyle: AppTextStyles.bodyStyle,
                      disabledBorder: InputBorder.none,
                    ),
                  ),
                ),
                PopupMenuButton<String>(
                  onSelected: (String value) {
                    setState(() {
                      setState(() {
                        selectedSkills.add(value);
                      });
                    });
                  },
                  itemBuilder: (BuildContext context) =>
                      skills.map((String skill) {
                    return PopupMenuItem<String>(
                      value: skill,
                      child: Text(skill),
                    );
                  }).toList(),
                  icon: Icon(Icons.add),
                ),
              ],
            ),
            // Wrap widget to display selected skills
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: [
                ...selectedSkills.map((skill) {
                  return Chip(
                    label: Text(skill),
                    onDeleted: () {
                      setState(() {
                        selectedSkills.remove(skill);
                      });
                    },
                  );
                }).toList(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
