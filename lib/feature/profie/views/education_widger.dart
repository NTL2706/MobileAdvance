import 'package:final_project_advanced_mobile/constants/text_style.dart';
import 'package:final_project_advanced_mobile/feature/profie/models/profile.dart';
import 'package:final_project_advanced_mobile/languages/language.dart';
import 'package:flutter/material.dart';

class EducationWidget extends StatelessWidget {
  final List<EducationInfo> educationList;
  final Function addEducationInfo;
  final Function deleteEducationInfo;
  final Function editEducationInfo;

  const EducationWidget({
    Key? key,
    required this.educationList,
    required this.addEducationInfo,
    required this.deleteEducationInfo,
    required this.editEducationInfo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    Languages.of(context)!.education,
                    style: AppTextStyles.headerStyle,
                  )
                ],
              ),
            ),
            IconButton(
              onPressed: () {
                _addEducationInfo();
              },
              icon: Icon(Icons.add),
            ),
          ],
        ),
        ListView.builder(
          itemCount: educationList.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(educationList[index].schoolName),
              subtitle: Text(
                  'Academic Year: ${educationList[index].startYear} - ${educationList[index].endYear}'),
              onTap: () {
                _editSchoolInfo(index, context: context);
              },
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  _deleteSchoolInfo(index);
                },
              ),
            );
          },
        ),
      ],
    );
  }

  void _addEducationInfo() {
    addEducationInfo();
  }

  void _editSchoolInfo(int index, {required BuildContext context}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String schoolName = educationList[index].schoolName;
        int startAcademicYear = educationList[index].startYear;
        int endAcademicYear = educationList[index].endYear;
        TextEditingController nameController =
            TextEditingController(text: schoolName);
        TextEditingController startYearController =
            TextEditingController(text: startAcademicYear.toString());
        TextEditingController endYearController =
            TextEditingController(text: endAcademicYear.toString());

        return AlertDialog(
          title: Text(Languages.of(context)!.editEducation),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                    labelText: Languages.of(context)!.schoolName),
              ),
              TextField(
                controller: startYearController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: Languages.of(context)!.startYear),
              ),
              TextField(
                controller: endYearController,
                keyboardType: TextInputType.number,
                decoration:
                    InputDecoration(labelText: Languages.of(context)!.endYear),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(Languages.of(context)!.cancel),
            ),
            TextButton(
              onPressed: () {
                editEducationInfo(index, nameController.text,
                    startYearController.text, endYearController.text);
              },
              child: Text(Languages.of(context)!.save),
            ),
          ],
        );
      },
    );
  }

  void _deleteSchoolInfo(int index) {
    deleteEducationInfo(index);
  }
}
