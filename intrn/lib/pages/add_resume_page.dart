import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

import 'package:intrn/pages/choose_job_type.dart';

PageRouteBuilder _fadeRoute(Widget page) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
          opacity: animation,
          child: child); // Directly return the new page with no animation
    },
  );
}

class AddResumePage extends StatefulWidget {
  const AddResumePage({super.key});

  @override
  State<AddResumePage> createState() => _AddResumePageState();
}

class _AddResumePageState extends State<AddResumePage> {

  File? resumeFile;
  String? fileName;

  void _next() {
    Navigator.of(context).pushReplacement(_fadeRoute(ChooseJobType()));
  }

  Future<void> pickResume() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['pdf', 'doc', 'docx'],
  );

  if (result != null && result.files.single.path != null) {
    setState(() {
      resumeFile = File(result.files.single.path!);
      fileName = result.files.single.name;
    });
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 255, 179, 117),
          ),
          width: double.infinity,
          child: Column(
            children: <Widget>[
              SizedBox(height: 80,),
              Container(
                constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height * 0.8),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topLeft:Radius.circular(40), topRight: Radius.circular(40)),
                    color: Colors.white,                  
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(32),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Add Your Resume/CV",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 24,
                          )
                        ),
                        SizedBox(height: 24,),
                        resumeInput(),
                        SizedBox(height: 400,),
                        skipButton(),
                        SizedBox(height: 16,),
                        nextButton(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget skipButton() {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushReplacement(_fadeRoute(ChooseJobType()));
      },
      child: Container(
        width: double.infinity,
        height: 48,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.black54, width: 1.5),
        ),
        alignment: Alignment.center,
        child: Text(
          "Skip",
          style: TextStyle(
            color: Colors.black87,
            fontSize: 18,
          ),
        ),
      ),
    );
  }

  Widget nextButton() {
    bool isEnabled = resumeFile != null;

    return GestureDetector(
      onTap: isEnabled ? _next : null,
      child: Container(
        width: double.infinity,
        height: 48,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isEnabled
                ? Color.fromARGB(255, 255, 122, 39)
                : Color.fromARGB(255, 255, 179, 117),
            width: 2,
          ),
          color: isEnabled
              ? Colors.transparent
              : Colors.transparent,
        ),
        alignment: Alignment.center,
        child: Text(
          "Next",
          style: TextStyle(
            color: isEnabled
                ? Color.fromARGB(255, 255, 122, 39)
                : Color.fromARGB(255, 255, 179, 117),
            fontSize: 18,
          ),
        ),
      ),
    );
  }

  Widget resumeInput() {
    return GestureDetector(
      onTap: pickResume,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 239, 239, 239),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Row(
          children: [
            SizedBox(width: 12),
            Expanded(
              child: Text(
                fileName ?? 'Upload Resume/CV',
                style: TextStyle(
                  fontSize: 16, 
                  fontFamily: "Poppins"
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Icon(Icons.upload_file, color: Colors.grey[700]),
          ],
        ),
      ),
    );
  }
}