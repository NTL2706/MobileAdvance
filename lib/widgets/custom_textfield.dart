import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.hintText
  }); 

  final String hintText;
  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          borderSide: BorderSide(color: Colors.black, style: BorderStyle.solid)
        ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15))
        ),
        hintText: hintText
      ),
    );
  }
}