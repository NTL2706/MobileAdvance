import 'package:final_project_advanced_mobile/constants/text_style.dart';
import 'package:final_project_advanced_mobile/feature/profie/models/profile.dart';
import 'package:flutter/material.dart';

class SkillWidget extends StatelessWidget {
  final List<Skill> selectedSkills;
  final List<Skill> skills;
  final Function(Skill) onSkillSelected;
  final Function(Skill) onSkillRemoved;

  const SkillWidget({
    Key? key,
    required this.selectedSkills,
    required this.skills,
    required this.onSkillSelected,
    required this.onSkillRemoved,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start, // Căn lề văn bản sang bên trái
                children: [
                  Text(
                    'Skill',
                    style: AppTextStyles.headerStyle, // Style cho label
                  ),
                ],
              ),
            ),
            PopupMenuButton<Skill>(
              onSelected: onSkillSelected,
              itemBuilder: (BuildContext context) {
                return skills.map((Skill skill) {
                  return PopupMenuItem<Skill>(
                    value: skill,
                    child: Text(skill.name),
                  );
                }).toList();
              },
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
                label: Text(skill.name ?? ''),
                onDeleted: () {
                  onSkillRemoved(skill);
                },
              );
            }).toList(),
          ],
        ),
      ],
    );
  }
}
