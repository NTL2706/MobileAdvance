import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(""),
        elevation: 0, // remove shadow
      ),
      body: Column(
        children: [_appProfileBar(), _appProfileAction()],
      ),
    );
  }

  _appProfileBar() {
    return Container(
      padding: const EdgeInsets.all(12.0),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center, // center with column
        children: [
          CircleAvatar(
            backgroundImage: AssetImage("assets/images/logo.png"),
            radius: 50,
          ),
          SizedBox(height: 12.0),
          Row(
            // crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Text(
                    "Nguyen Van A",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text("Profile"),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  _appProfileAction() {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12.0),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
          color: Color.fromARGB(255, 164, 132, 132),
        ),
        child: Column(
          children: [
            // ListTile is a row with leading, title, trailing
            ListTile(
              leading: Container(
                padding: const EdgeInsets.all(8.0),
                // config border radius
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 93, 54, 54),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: const Icon(Icons.person, color: Colors.white),
              ),
              title: const Text("Profile"),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                print("Submit button clicked");
              },
            ),
            ListTile(
              leading: Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 93, 54, 54),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: const Icon(Icons.settings, color: Colors.white),
              ),
              title: const Text("Profile"),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                print("Submit button clicked");
              },
            ),
            ListTile(
              leading: Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 93, 54, 54),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: const Icon(Icons.logout, color: Colors.white),
              ),
              title: const Text("Profile"),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                print("Submit button clicked");
              },
            ),
          ],
        ),
      ),
    );
  }
}
