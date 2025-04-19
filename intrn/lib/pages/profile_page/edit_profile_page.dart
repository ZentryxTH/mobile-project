import 'package:flutter/material.dart';
import 'package:intrn/models/education_model.dart';
import 'package:intrn/models/user_model.dart';
import 'package:intrn/models/user_extended_model.dart';
import 'package:intrn/data/repositories/user_repository.dart';
import 'package:intrn/data/repositories/education_repository.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class EditProfilePage extends StatefulWidget {
  final UserModel user;
  final UserExtendedModel? extendedUser;
  final EducationModel? educationModel;

  const EditProfilePage({Key? key, required this.user, this.extendedUser, this.educationModel}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();
  late UserModel editableUser;
  late UserExtendedModel editableUserExtended;
  late EducationModel editableEducation;
  File? _image;

  @override
  void initState() {
    super.initState();
    editableUser = widget.user; // Use passed UserModel
    editableUserExtended = widget.extendedUser ?? UserExtendedModel(); // Handle possible null
    editableEducation = widget.educationModel ?? EducationModel(
      instructor: '',
      faculty: '',
      degree: '',
      startDate: '',
      endDate: '',
    );
  }

  Widget _buildTextField(String label, String value, Function(String) onChanged) {
    return TextFormField(
      initialValue: value,
      decoration: InputDecoration(labelText: label),
      onChanged: onChanged,
    );
  }

  Widget _buildTextFieldOptional(String label, String? value, Function(String?) onChanged) {
    return TextFormField(
      initialValue: value ?? '',
      decoration: InputDecoration(labelText: label),
      onChanged: onChanged,
    );
  }

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

  Future<void> pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xFFF5F5F5),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Edit Profile",
          style: TextStyle(
            fontFamily: "Poppins",
            fontSize: 24,
          ),
        )
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              GestureDetector(
                onTap: () => _showPickerDialog(context),
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: File(editableUser.imageUrl!).existsSync()
                      ? FileImage(File(editableUser.imageUrl!))
                      : AssetImage('assets/avatar.png') as ImageProvider,
                ),
              ),
              SizedBox(height: 20),
              _buildTextField("First Name", editableUser.firstName, (val) => editableUser.firstName = val),
              _buildTextField("Last Name", editableUser.lastName, (val) => editableUser.lastName = val),
              _buildTextField("Birth Date", editableUser.birthDate, (val) => editableUser.birthDate = val),
              _buildTextField("Phone", editableUser.phone, (val) => editableUser.phone = val),
              _buildTextFieldOptional("Biography", editableUserExtended.biography, (val) => editableUserExtended.biography = val),
              _buildTextFieldOptional("Address 1", editableUserExtended.address1, (val) => editableUserExtended.address1 = val),
              _buildTextFieldOptional("Address 2", editableUserExtended.address2, (val) => editableUserExtended.address2 = val),
              _buildTextFieldOptional("City", editableUserExtended.city, (val) => editableUserExtended.city = val),
              _buildTextField("Country", editableUser.country, (val) => editableUser.country = val),
              // Add Education Fields
              SizedBox(height: 20),
              _buildTextField("Instructor", editableEducation.instructor, (val) => editableEducation.instructor = val),
              _buildTextField("Faculty", editableEducation.faculty, (val) => editableEducation.faculty = val),
              _buildTextField("Degree", editableEducation.degree, (val) => editableEducation.degree = val),
              _buildTextField("Start Date", editableEducation.startDate, (val) => editableEducation.startDate = val),
              _buildTextField("End Date", editableEducation.endDate, (val) => editableEducation.endDate = val),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    try {
                      // Save User Extended Data
                      await UserRepository().createOrUpdateUserExtended(editableUserExtended);
                      // Save Education Data
                      await EducationRepository().saveEducation(editableEducation);
                      Navigator.pop(context, editableUser); // return the edited user
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Failed to save changes")));
                    }
                  }
                },
                child: Text("Save Changes"),
              )
            ],
          ),
        ),
      ),
    );
  }
}