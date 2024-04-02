import 'package:flutter/material.dart';

class SchoolInfo {
  String schoolName;
  int academicYear;

  SchoolInfo(this.schoolName, this.academicYear);
}

class SchoolListScreen extends StatefulWidget {
  @override
  _SchoolListScreenState createState() => _SchoolListScreenState();
}

class _SchoolListScreenState extends State<SchoolListScreen> {
  List<SchoolInfo> schoolList = [
    SchoolInfo('School A', 2021),
    SchoolInfo('School B', 2022),
    SchoolInfo('School C', 2023),
    SchoolInfo('School D', 2024),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('School List'),
      ),
      body: ListView.builder(
        itemCount: schoolList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(schoolList[index].schoolName),
            subtitle: Text('Academic Year: ${schoolList[index].academicYear}'),
            onTap: () {
              _editSchoolInfo(index);
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
      floatingActionButton: FloatingActionButton(
        onPressed: _addSchoolInfo,
        tooltip: 'Add School',
        child: Icon(Icons.add),
      ),
    );
  }

  void _addSchoolInfo() {
    setState(() {
      schoolList.add(SchoolInfo('New School', DateTime.now().year));
    });
  }

  void _editSchoolInfo(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String schoolName = schoolList[index].schoolName;
        int academicYear = schoolList[index].academicYear;
        TextEditingController nameController =
            TextEditingController(text: schoolName);
        TextEditingController yearController =
            TextEditingController(text: academicYear.toString());

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
                controller: yearController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Academic Year'),
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
                setState(() {
                  schoolList[index].schoolName = nameController.text;
                  schoolList[index].academicYear =
                      int.parse(yearController.text);
                });
                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _deleteSchoolInfo(int index) {
    setState(() {
      schoolList.removeAt(index);
    });
  }
}
