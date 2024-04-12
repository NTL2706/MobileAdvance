import 'package:flutter/material.dart';

class PasswordFielddWidget extends StatefulWidget {
  String? title = "Password";

  PasswordFielddWidget(
      {super.key, required this.controller, this.title = "Password"});
  TextEditingController? controller;
  @override
  State<PasswordFielddWidget> createState() => _PasswordFielddWidgetState();
}

class _PasswordFielddWidgetState extends State<PasswordFielddWidget> {
  bool passwordVisible = false;
  @override
  void initState() {
    super.initState();
    passwordVisible = true;
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: passwordVisible,
      decoration: InputDecoration(
        focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            borderSide:
                BorderSide(color: Colors.black, style: BorderStyle.solid)),
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15))),
        hintText: widget.title,
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              passwordVisible = !passwordVisible;
            });
          },
          icon: Icon(passwordVisible ? Icons.visibility : Icons.visibility_off),
        ),
      ),
    );
  }
}
