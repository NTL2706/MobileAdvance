import 'package:flutter/material.dart';

class SkillsetInputView extends StatefulWidget {
  @override
  _SkillsetInputViewState createState() => _SkillsetInputViewState();
}

class _SkillsetInputViewState extends State<SkillsetInputView> {
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

  String? dropdownValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Skillset Input View'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select a skill:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            DropdownButton<String>(
              isExpanded: true,
              value: dropdownValue,
              onChanged: (String? newValue) {
                setState(() {
                  dropdownValue = newValue;
                });
              },
              items: skills.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            Text(
              'Selected skills:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: selectedSkills.map((skill) {
                return Chip(
                  label: Text(skill),
                  onDeleted: () {
                    setState(() {
                      selectedSkills.remove(skill);
                    });
                  },
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (dropdownValue != null &&
                    !selectedSkills.contains(dropdownValue)) {
                  setState(() {
                    selectedSkills.add(dropdownValue!);
                    dropdownValue = null;
                  });
                }
              },
              child: Text('Add Skill'),
            ),
          ],
        ),
      ),
    );
  }
}
