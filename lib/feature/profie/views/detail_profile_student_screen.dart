import 'package:final_project_advanced_mobile/constants/colors.dart';
import 'package:final_project_advanced_mobile/constants/text_style.dart';
import 'package:final_project_advanced_mobile/feature/profie/models/education_info.dart';
import 'package:final_project_advanced_mobile/feature/profie/views/experience_screen.dart';
import 'package:final_project_advanced_mobile/feature/profie/views/test.dart';
import 'package:final_project_advanced_mobile/feature/profie/widgets/education_widger.dart';
import 'package:final_project_advanced_mobile/feature/profie/widgets/profile_list_title_widget.dart';
import 'package:final_project_advanced_mobile/feature/profie/widgets/skill_widget.dart';
import 'package:final_project_advanced_mobile/feature/profie/widgets/teckstack_widget.dart';
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

  String selectedTech = 'Fullstack';

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

  List<EducationInfo> educationList = [
    EducationInfo('School A', 2021, 2002),
    EducationInfo('School B', 2022, 2002),
    EducationInfo('School C', 2023, 2002),
    EducationInfo('School D', 2024, 2002),
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
            // ElevatedButton(
            //   onPressed: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //         // builder: (context) => const DetailProfileCompanyScreen(),
            //         builder: (context) => MyApp(),
            //       ),
            //     );
            //   },
            //   child: Text('Update'),
            // ),
            ProfileListTile(
              icon: Icons.work_outlined,
              title: "Experience",
              onTap: () {
                // move to profile screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ExperienceScreen(),
                  ),
                );
              },
            ),

            // Tech stack
            TechstackWidget(
                selectedTech: selectedTech,
                onExpertiseSelected: (String value) {
                  setState(() {
                    selectedTech = value;
                  });
                }),
            // Skills
            SkillWidget(
              selectedSkills: selectedSkills,
              skills: skills,
              onSkillSelected: (String value) {
                setState(() {
                  selectedSkills.add(value);
                });
              },
            ),
            // Education history
            EducationWidget(
              educationList: educationList,
              addEducationInfo: () {
                setState(() {
                  educationList.add(EducationInfo(
                      'New School', DateTime.now().year, DateTime.now().year));
                });
              },
              deleteEducationInfo: (index) {
                setState(() {
                  educationList.removeAt(index);
                });
              },
              editEducationInfo: (index, schoolName, startYear, endYear) {
                setState(() {
                  educationList[index].schoolName = schoolName;
                  educationList[index].startYear = int.parse(startYear);
                  educationList[index].endYear = int.parse(endYear);
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}
