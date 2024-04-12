import 'package:final_project_advanced_mobile/constants/text_style.dart';
import 'package:final_project_advanced_mobile/feature/profie/models/techstack.dart';
import 'package:flutter/material.dart';

class TechstackWidget extends StatelessWidget {
  final TechStack selectedTech;
  final List<TechStack> techStacks;
  final TextEditingController controller = TextEditingController();
  final Function(TechStack) onExpertiseSelected;

  TechstackWidget({
    Key? key,
    required this.selectedTech,
    required this.onExpertiseSelected,
    required this.techStacks,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start, // Căn lề văn bản sang bên trái
            children: [
              const Text(
                'Tech stack',
                style: AppTextStyles.headerStyle, // Style cho label
              ),
              Text(
                selectedTech.name,
                style: AppTextStyles.bodyStyle,
              ),
            ],
          ),
        ),
        PopupMenuButton<TechStack>(
          onSelected: onExpertiseSelected,
          itemBuilder: (BuildContext context) {
            return techStacks.map((TechStack value) {
              return PopupMenuItem<TechStack>(
                value: value,
                child: Text(value.name),
              );
            }).toList();
          },
          icon: const Icon(Icons.edit),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ],
    );
  }
}
