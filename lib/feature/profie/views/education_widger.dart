import 'package:final_project_advanced_mobile/constants/text_style.dart';
import 'package:final_project_advanced_mobile/feature/profie/models/profile.dart';
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
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Education",
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
          title: Text('Edit School Info'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'School Name'),
              ),
              TextField(
                controller: startYearController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Start Academic Year'),
              ),
              TextField(
                controller: endYearController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'End Academic Year'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                editEducationInfo(index, nameController.text,
                    startYearController.text, endYearController.text);
              },
              child: Text('Save'),
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
