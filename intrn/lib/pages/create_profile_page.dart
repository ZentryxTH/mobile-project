import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:intrn/pages/add_education_page.dart';
import 'package:intrn/data/services/phone_format.dart';
import 'package:intrn/data/services/first_letter_uppercase.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

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

class CreateProfilePage extends StatefulWidget {
  const CreateProfilePage({super.key});

  @override
  State<CreateProfilePage> createState() => _CreateProfilePageState();
}

class _CreateProfilePageState extends State<CreateProfilePage> {

  final TextEditingController firstnameController = TextEditingController();
  final TextEditingController lastnameController = TextEditingController();
  DateTime? selectedDate;
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  File? _image;
  String? errorMessage;

  Future<void> _showPickerDialog(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Gallery'),
                onTap: () {
                  pickImage(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text('Camera'),
                onTap: () {
                  pickImage(ImageSource.camera);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // Select Date
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  // File Picker
  Future<void> pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  void _next() {
    setState(() {
      errorMessage = null;
    });

    if (firstnameController.text.isEmpty ||
        lastnameController.text.isEmpty ||
        phoneController.text.isEmpty ||
        countryController.text.isEmpty ||
        selectedDate == null
        ) {
      setState(() {
        errorMessage = "Please complete all fields";
      });
      return;
    }

    Navigator.of(context).pushReplacement(_fadeRoute(AddEducationPage()));
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
                          "Create your profile",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 24,
                          )
                        ),
                        SizedBox(height: 24,),
                        firstNameInput(),
                        SizedBox(height: 16,),
                        lastNameInput(),
                        SizedBox(height: 16,),
                        birthDateInput(),
                        SizedBox(height: 16,),
                        phoneInput(),
                        SizedBox(height: 16,),
                        countryInput(),
                        SizedBox(height: 8,),
                        if (errorMessage != null) ...[
                          SizedBox(height: 8),
                          Text(
                            errorMessage!,
                            style: TextStyle(color: Colors.red),
                          ),
                        ],
                        SizedBox(height: 8,),
                        Center(
                          child: profilePicturePicker(),
                        ),
                        SizedBox(height: 16),
                        nextButton()
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      )
    );
  }

  Widget nextButton() {
    return GestureDetector(
      onTap: _next,
      child: Container(
        width: double.infinity,
        height: 48,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Color.fromARGB(255, 255, 122, 39), width: 2),
        ),
        alignment: Alignment.center,
        child: Text(
          "Next",
          style: TextStyle(
            color: Color.fromARGB(255, 255, 122, 39),
            fontSize: 18,
          ),
        ),
      ),
    );
  }

  Widget profilePicturePicker() {
    return Column(
    children: [
      GestureDetector(
        onTap: () => _showPickerDialog(context),
        child: CircleAvatar(
          radius: 50,
          backgroundColor: Colors.grey,
          backgroundImage: _image != null ? FileImage(_image!) : null,
          child: _image == null
              ? Icon(Icons.add_photo_alternate, size: 40, color: Colors.white)
              : null,
        ),
      ),
      SizedBox(height: 8),
      Text("Choose your profile picture", style: TextStyle(fontSize: 14)),
    ],
  );
  }

  TextField countryInput() {
    return TextField(
      controller: countryController,
      decoration:  inputDecoration("Country"),
      inputFormatters: [
        FirstLetterUpperCase(),
      ],
    );
  }

  TextField lastNameInput() {
    return TextField(
      controller: lastnameController,
      decoration: inputDecoration("Lastname"),
      inputFormatters: [
        FirstLetterUpperCase(),
      ],
    );
  }

  TextField firstNameInput() {
    return TextField(
      controller: firstnameController,
      decoration: inputDecoration("Firstname"),
      inputFormatters: [
        FirstLetterUpperCase(),
      ],
    );
  }

  TextField phoneInput() {
    return TextField(
      controller: phoneController,
      decoration: inputDecoration("Phone"),
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        PhoneFormat(),
      ],
    );
  }

   Widget birthDateInput() {
    return GestureDetector(
      onTap: () => _selectDate(context),
      child: AbsorbPointer(
        child: TextField(
          decoration: InputDecoration(
            filled: true,
            fillColor: Color.fromARGB(255, 239, 239, 239),
            hintText: "Birth Date",
            hintStyle: TextStyle(fontFamily: "Poppins", fontSize: 16),
            contentPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(24),
              borderSide: BorderSide.none,
            ),
            suffixIcon: Icon(Icons.calendar_today),
          ),
          controller: TextEditingController(
            text: selectedDate == null
                ? ''
                : DateFormat('dd/MM/yyyy').format(selectedDate!),
          ),
        ),
      ),
    );
  }

  InputDecoration inputDecoration(String hint) {
    return InputDecoration(
      filled: true,
      fillColor: Color.fromARGB(255, 239, 239, 239),
      hintText: hint,
      hintStyle: TextStyle(fontFamily: "Poppins", fontSize: 16),
      contentPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(24),
        borderSide: BorderSide.none,
      ),
    );
  }
}