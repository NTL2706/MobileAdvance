import 'package:final_project_advanced_mobile/constants/text_style.dart';
import 'package:flutter/material.dart';

class SkillWidget extends StatelessWidget {
  final List<String> selectedSkills;
  final List<String> skills;
  final Function(String) onSkillSelected;

  const SkillWidget({
    Key? key,
    required this.selectedSkills,
    required this.skills,
    required this.onSkillSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
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
              onSelected: onSkillSelected,
              itemBuilder: (BuildContext context) => skills.map((String skill) {
                return PopupMenuItem<String>(
                  value: skill,
                  child: Text(skill),
                );
              }).toList(),
              icon: Icon(Icons.add),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
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
                  // Remove the skill from the list when the chip is deleted
                  // Notify the parent widget about the change
                  selectedSkills.remove(skill);
                  onSkillSelected(skill);
                },
              );
            }).toList(),
          ],
        ),
      ],
    );
  }
}
