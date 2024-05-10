import 'package:final_project_advanced_mobile/constants/colors.dart';
import 'package:final_project_advanced_mobile/constants/text_style.dart';
import 'package:final_project_advanced_mobile/feature/profie/models/profile.dart';
import 'package:final_project_advanced_mobile/feature/profie/provider/profile_provider.dart';
import 'package:final_project_advanced_mobile/feature/profie/views/cv_transcript_screen.dart';
import 'package:final_project_advanced_mobile/feature/profie/views/education_widger.dart';
import 'package:final_project_advanced_mobile/feature/profie/views/experience_screen.dart';
import 'package:final_project_advanced_mobile/feature/profie/views/test.dart';
import 'package:final_project_advanced_mobile/feature/profie/widgets/profile_list_title_widget.dart';
import 'package:final_project_advanced_mobile/feature/profie/widgets/skill_widget.dart';
import 'package:final_project_advanced_mobile/feature/profie/widgets/teckstack_widget.dart';
import 'package:final_project_advanced_mobile/languages/language.dart';
import 'package:flutter/material.dart';

class DetailProfileStudentScreen extends StatefulWidget {
  Profile? profile;

  DetailProfileStudentScreen({super.key, required this.profile});

  @override
  State<DetailProfileStudentScreen> createState() =>
      _DetailProfileStudentScreenState();
}

class _DetailProfileStudentScreenState
    extends State<DetailProfileStudentScreen> {
  final profileStudentProvider = ProfileProvider();

  TechStack selectedTech = TechStack(name: "", id: 1);
  List<Skill> selectedSkills = [];
  List<Skill> skills = [];
  List<TechStack> techStacks = [];
  List<EducationInfo> educationList = [];

  bool shouldUpdate = false;

  void _loadSkillsDefault() async {
    await profileStudentProvider.getSkillsDefault();
    await profileStudentProvider.getTechStackDefault();

    setState(() {
      skills = profileStudentProvider.skills;
      techStacks = profileStudentProvider.techStack;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadSkillsDefault();
    selectedTech = widget.profile!.studentProfile!.techStack;
    selectedSkills = widget.profile!.studentProfile!.skill ?? [];
    educationList = widget.profile!.studentProfile!.educationInfo ?? [];
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
          const SizedBox(
            width: 80,
            height: 80,
            child: CircleAvatar(
              backgroundImage: AssetImage("assets/images/logo.png"),
              radius: 40,
            ),
          ),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.profile!.name ?? "",
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
        child: ListView(
          children: [
            // ElevatedButton(
            //   onPressed: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //         // builder: (context) => const DetailProfileCompanyScreen(),
            //         builder: (context) => CvTranscriptScreen(
            //           studentId: widget.profile!.studentProfile!.id,
            //           name: widget.profile!.name,
            //         ),
            //       ),
            //     );
            //   },
            //   child: Text('Update'),
            // ),
            ProfileListTile(
              icon: Icons.article,
              title: Languages.of(context)!.cvAndTranscript,
              onTap: () {
                // move to profile screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CvTranscriptScreen(
                      studentId: widget.profile!.studentProfile!.id,
                      name: widget.profile!.name,
                    ),
                  ),
                );
              },
            ),
            ProfileListTile(
              icon: Icons.work_outlined,
              title: Languages.of(context)!.experience,
              onTap: () {
                // move to profile screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ExperienceScreen(
                      selectedSkills: selectedSkills,
                      studentId: widget.profile!.studentProfile!.id,
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            // Tech stack
            TechstackWidget(
              selectedTech: selectedTech,
              onExpertiseSelected: (TechStack value) {
                setState(() {
                  selectedTech = value;
                  shouldUpdate = true;
                });
              },
              techStacks: techStacks,
            ),
            const SizedBox(height: 20),
            // Skills
            SkillWidget(
              selectedSkills: selectedSkills,
              skills: skills,
              onSkillSelected: (Skill value) {
                setState(() {
                  selectedSkills.add(value);
                  shouldUpdate = true;
                });
              },
              onSkillRemoved: (Skill value) {
                setState(() {
                  selectedSkills.remove(value);
                  shouldUpdate = true;
                });
              },
            ),
            const SizedBox(height: 20),

            // Button update tech stack and skills
            shouldUpdate
                ? ElevatedButton(
                    onPressed: _handleUpdate,
                    child: Text(Languages.of(context)!.update),
                  )
                : SizedBox(),

            // Education history
            EducationWidget(
              educationList: educationList,
              addEducationInfo: () {
                setState(() {
                  educationList.add(EducationInfo(
                    schoolName: 'New School',
                    startYear: DateTime.now().year,
                    endYear: DateTime.now().year,
                    id: 21,
                  ));
                });
              },
              deleteEducationInfo: (index) {
                setState(() {
                  educationList.removeAt(index);
                });
                _handleUpdateEducation();
              },
              editEducationInfo: (index, schoolName, startYear, endYear) {
                setState(() {
                  educationList[index].schoolName = schoolName;
                  educationList[index].startYear = int.parse(startYear);
                  educationList[index].endYear = int.parse(endYear);
                  educationList[index].id = null;
                });
                _handleUpdateEducation();
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }

  void _handleUpdate() {
    setState(() {
      shouldUpdate = false;
      var skillsId = selectedSkills.map((e) => e.id.toString()).toList();
      widget.profile!.studentProfile!.techStack = selectedTech;
      widget.profile!.studentProfile!.skill = selectedSkills;

      // call api update student profile
      profileStudentProvider.updateProfileStudent(
        studentId: widget.profile!.studentProfile!.id,
        skillSets: skillsId,
        techStackId: selectedTech.id,
      );
    });
  }

  void _handleUpdateEducation() {
    profileStudentProvider.updateEducationStudent(
      educationList,
      widget.profile!.studentProfile!.id,
    );
  }
}
