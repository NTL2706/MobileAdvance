import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class UploadPage extends StatefulWidget {
  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  File? _resumeFile;
  File? _transcriptFile;

  Future pickResume() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc'],
    );

    if (result != null) {
      setState(() {
        _resumeFile = File(result.files.single.path!);
      });
    } else {
      print('No resume file selected.');
    }
  }

  Future pickTranscript() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc'],
    );

    if (result != null) {
      setState(() {
        _transcriptFile = File(result.files.single.path!);
      });
    } else {
      print('No transcript file selected.');
    }
  }

  Widget buildUploadButton(String title, Function() onPressed, File? file) {
    return AspectRatio(
      aspectRatio: 1,
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(5),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Expanded(
                child: buildUploadButton(
                    'Upload Resume/CV', pickResume, _resumeFile)),
            SizedBox(height: 20),
            Expanded(
                child: buildUploadButton(
                    'Upload Transcript', pickTranscript, _transcriptFile)),
          ],
        ),
      ),
    );
  }
}
