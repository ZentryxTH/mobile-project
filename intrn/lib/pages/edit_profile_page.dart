import 'package:flutter/material.dart';
import '../models/user.dart';

class EditProfilePage extends StatefulWidget {
  final User user;

  const EditProfilePage({Key? key, required this.user}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();
  late User editableUser;

  @override
  void initState() {
    super.initState();
    editableUser = User(
      firstName: widget.user.firstName,
      lastName: widget.user.lastName,
      birthDate: widget.user.birthDate,
      phone: widget.user.phone,
      biography: widget.user.biography,
      address1: widget.user.address1,
      address2: widget.user.address2,
      city: widget.user.city,
      country: widget.user.country,
      university: widget.user.university,
      faculty: widget.user.faculty,
      degree: widget.user.degree,
      startDate: widget.user.startDate,
      endDate: widget.user.endDate,
      email: widget.user.email,
    );
  }

  Widget _buildTextField(String label, String value, Function(String) onChanged) {
    return TextFormField(
      initialValue: value,
      decoration: InputDecoration(labelText: label),
      onChanged: onChanged,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Edit Profile")),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/avatar.png'),
              ),
              SizedBox(height: 20),
              _buildTextField("First Name", editableUser.firstName, (val) => editableUser.firstName = val),
              _buildTextField("Last Name", editableUser.lastName, (val) => editableUser.lastName = val),
              _buildTextField("Birth Date", editableUser.birthDate, (val) => editableUser.birthDate = val),
              _buildTextField("Phone", editableUser.phone, (val) => editableUser.phone = val),
              _buildTextField("Biography", editableUser.biography, (val) => editableUser.biography = val),
              _buildTextField("Address 1", editableUser.address1, (val) => editableUser.address1 = val),
              _buildTextField("Address 2", editableUser.address2, (val) => editableUser.address2 = val),
              _buildTextField("City", editableUser.city, (val) => editableUser.city = val),
              _buildTextField("Country", editableUser.country, (val) => editableUser.country = val),
              _buildTextField("University", editableUser.university, (val) => editableUser.university = val),
              _buildTextField("Faculty", editableUser.faculty, (val) => editableUser.faculty = val),
              _buildTextField("Degree", editableUser.degree, (val) => editableUser.degree = val),
              _buildTextField("Start Date", editableUser.startDate, (val) => editableUser.startDate = val),
              _buildTextField("End Date", editableUser.endDate, (val) => editableUser.endDate = val),
              _buildTextField("Email", editableUser.email, (val) => editableUser.email = val),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.pop(context, editableUser); // return the edited user
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