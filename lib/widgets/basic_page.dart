import 'package:final_project_advanced_mobile/feature/profie/views/profile_screen.dart';
import 'package:flutter/material.dart';

class BasicPage extends StatelessWidget {

  BasicPage({
    super.key,
    required this.child,
    this.floatingActionButton
  });

  Widget child; 
  Widget? floatingActionButton;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
                Padding(
                  padding: EdgeInsets.all(8),
                  child: IconButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                          builder: (context) {
                            return ProfileScreen(
                              
                            );
                          },
                        ));
                      },
                      icon: Icon(Icons.person)),
                )
              ],
        scrolledUnderElevation: 0,
        title: Text("Student Hub"),
      ),
      body: child,
      floatingActionButton: floatingActionButton,
    );
  }
}