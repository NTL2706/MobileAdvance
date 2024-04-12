import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:final_project_advanced_mobile/constants/colors.dart';
import 'package:final_project_advanced_mobile/constants/text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CvTranscriptScreen extends StatefulWidget {
  int studentId;
  String name = "";

  CvTranscriptScreen({super.key, required this.studentId, required this.name});

  @override
  State<CvTranscriptScreen> createState() => _CvTranscriptScreenState();
}

class _CvTranscriptScreenState extends State<CvTranscriptScreen> {
  File? _resumeFile;
  File? _transcriptFile;

  void _loadSkillsDefault() async {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _loadSkillsDefault();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(""),
        elevation: 0,
      ),
      body: Column(
        children: [
          _appDetailProfileBar(),
          SizedBox(height: 20),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(20.0),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
                color: AppColors.backgroundColor,
              ),
              child: Column(
                children: <Widget>[
                  buildUploadButton(
                      'Upload Resume/CV',
                      () => pickFile((file) => _resumeFile = file),
                      _resumeFile),
                  SizedBox(height: 20),
                  buildUploadButton(
                      'Upload Transcript',
                      () => pickFile((file) => _transcriptFile = file),
                      _transcriptFile),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _appDetailProfileBar() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            width: 80,
            height: 80,
            child: CircleAvatar(
              backgroundImage: AssetImage("assets/images/logo.png"),
              radius: 40,
            ),
          ),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.name ?? "",
                style: AppTextStyles.headerStyle,
              ),
              Text("HCMUS", style: AppTextStyles.bodyStyle),
              Text("Student", style: AppTextStyles.bodyStyle),
            ],
          ),
        ],
      ),
    );
  }

  Future pickFile(Function(File) fileSetter) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc'],
    );

    if (result != null) {
      setState(() {
        fileSetter(File(result.files.single.path!));
      });
    } else {
      print('No file selected.');
    }
  }

  Widget buildUploadButton(String title, Function() onPressed, File? file) {
    return AspectRatio(
      aspectRatio: 4 / 3,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.file_upload),
              color: Colors.grey,
              onPressed: onPressed,
              iconSize: 50,
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
            if (file != null)
              Column(
                children: [
                  Icon(
                    file.path.endsWith('.pdf')
                        ? Icons.picture_as_pdf
                        : file.path.endsWith('.jpg') ||
                                file.path.endsWith('.png')
                            ? Icons.image
                            : Icons.insert_drive_file, // This is the new icon
                    size: 70, // Adjust the icon size here
                  ),
                  Text(
                    'File: ' +
                        (file.path.split('/').last.length > 15
                            ? file.path.split('/').last.substring(0, 15) + '...'
                            : file.path.split('/').last),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
