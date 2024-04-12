import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField(
      {super.key, required this.hintText, this.controller, this.onChanged});
  final TextEditingController? controller;
  final String hintText;
  Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged!,
      controller: controller,
      decoration: InputDecoration(
          focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              borderSide:
                  BorderSide(color: Colors.black, style: BorderStyle.solid)),
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(15))),
          hintText: hintText),
    );
  }
}
