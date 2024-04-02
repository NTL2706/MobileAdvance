// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class ApplyProject extends StatelessWidget {
  const ApplyProject({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Example'),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Apply Text',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10.0),
              Text(
                'Description Text',
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 20.0),
              Expanded(
                child: TextField(
                  maxLines: 5, // Allow for multiple lines
                  decoration: InputDecoration(
                    hintText: 'Enter your text here...',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Cancel'),
                  ),
                  SizedBox(width: 20.0),
                  ElevatedButton(
                    onPressed: () {
                      // Add your button 2 action here
                    },
                    child: Text('Apply'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
