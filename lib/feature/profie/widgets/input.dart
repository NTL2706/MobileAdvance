import 'package:final_project_advanced_mobile/constants/text_style.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MyInput extends StatelessWidget {
  final String title;
  final String hint;
  final TextEditingController? controller;
  final Widget? widget;

  const MyInput(
      {super.key,
      required this.title,
      required this.hint,
      this.controller,
      this.widget});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTextStyles.bodyStyle,
          ),
          Container(
            padding: EdgeInsets.only(left: 14),
            height: 52,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Expanded(
                    child: TextFormField(
                  readOnly: widget == null ? false : true,
                  autofocus: false,
                  cursorColor: Colors.amber.shade400,
                  style: AppTextStyles.bodyStyle,
                  controller: controller,
                  decoration: InputDecoration(
                    hintText: hint,
                    hintStyle: AppTextStyles.bodyStyle,
                  ),
                )),
                Container(
                  child: widget,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
