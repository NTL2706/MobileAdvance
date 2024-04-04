import 'package:final_project_advanced_mobile/constants/text_style.dart';
import 'package:flutter/material.dart';

class TechstackWidget extends StatelessWidget {
  final String selectedTech;
  final TextEditingController controller = TextEditingController();
  final Function(String) onExpertiseSelected;

  TechstackWidget({
    Key? key,
    required this.selectedTech,
    required this.onExpertiseSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: TextEditingController(text: selectedTech),
            enabled: false,
            decoration: const InputDecoration(
              labelText: 'Tech stack',
              labelStyle: AppTextStyles.headerStyle,
              disabledBorder: InputBorder.none,
            ),
          ),
        ),
        PopupMenuButton<String>(
            onSelected: onExpertiseSelected,
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
            icon: const Icon(Icons.edit),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            )),
      ],
    );
  }
}
