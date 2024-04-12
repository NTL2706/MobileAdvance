import 'package:flutter/material.dart';

class BasicPage extends StatelessWidget {

  BasicPage({
    super.key,
    required this.child
  });

  Widget child; 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: Text("Student Hub"),
      ),
      body: child
    );
  }
}