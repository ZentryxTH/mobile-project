import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intrn/models/education_model.dart';
import 'package:intrn/data/repositories/eduction_repository.dart';
import 'package:intrn/pages/profile_page/add_resume_page.dart';
import 'package:intrn/data/services/first_letter_uppercase.dart';

class AddEducationPage extends StatefulWidget {
  const AddEducationPage({super.key});

  @override
  State<AddEducationPage> createState() => _AddEducationPageState();
}

enum Degree { bachelor, master, doctorate, diploma, associate, other }

class _AddEducationPageState extends State<AddEducationPage> {
  final _instructorController = TextEditingController();
  final _facultyController = TextEditingController();
  final _educationRepo = EducationRepository();

  Degree? _selectedDegree;
  DateTime? _startDate;
  DateTime? _endDate;

  @override
  void dispose() {
    _instructorController.dispose();
    _facultyController.dispose();
    super.dispose();
  }

  Future<void> _pickDate({
    required ValueChanged<DateTime?> onPicked,
    required DateTime firstDate,
    DateTime? initialDate,
  }) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate ?? DateTime.now(),
      firstDate: firstDate,
      lastDate: DateTime(2100),
    );
    onPicked(pickedDate);
  }

  Future<void> _submitEducation() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) {
      _showMessage('User not logged in');
      return;
    }

    if (_instructorController.text.isEmpty ||
        _facultyController.text.isEmpty ||
        _selectedDegree == null ||
        _startDate == null ||
        _endDate == null) {
      _showMessage('Please fill in all fields');
      return;
    }

    final education = EducationModel(
      instructor: _instructorController.text.trim(),
      faculty: _facultyController.text.trim(),
      degree: _degreeToString(_selectedDegree),
      startDate: _startDate!.toIso8601String(),
      endDate: _endDate!.toIso8601String(),
    );

    try {
      await _educationRepo.createEducation(education);
      _showMessage('Education saved successfully');
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const AddResumePage()),
      );
    } catch (e) {
      _showMessage('Failed to save: $e');
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  String _degreeToString(Degree? degree) {
    switch (degree) {
      case Degree.bachelor:
        return "Bachelor's";
      case Degree.master:
        return "Master's";
      case Degree.doctorate:
        return "Doctorate";
      case Degree.diploma:
        return "Diploma";
      case Degree.associate:
        return "Associate";
      case Degree.other:
      default:
        return "Other";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFB375),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 80),
            Container(
              padding: const EdgeInsets.all(32),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Add Your Education",
                    style: TextStyle(fontFamily: "Poppins", fontSize: 24),
                  ),
                  const SizedBox(height: 24),
                  _buildTextField(_instructorController, 'Instructor'),
                  const SizedBox(height: 16),
                  _buildTextField(_facultyController, 'Faculty'),
                  const SizedBox(height: 16),
                  _buildDegreeDropdown(),
                  const SizedBox(height: 16),
                  _buildDatePicker("Start Date", _startDate, () {
                    _pickDate(
                      onPicked: (date) => setState(() => _startDate = date),
                      firstDate: DateTime(1950),
                    );
                  }),
                  const SizedBox(height: 16),
                  _buildDatePicker("End Date", _endDate, () {
                    _pickDate(
                      onPicked: (date) => setState(() => _endDate = date),
                      firstDate: _startDate ?? DateTime(1950),
                    );
                  }),
                  const SizedBox(height: 24),
                  _buildNextButton(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: const Color(0xFFEFEFEF),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 16,
        ),
      ),
      inputFormatters: [FirstLetterUpperCase()],
    );
  }

  Widget _buildDegreeDropdown() {
    return DropdownButtonFormField<Degree>(
      value: _selectedDegree,
      decoration: InputDecoration(
        labelText: "Degree",
        filled: true,
        fillColor: const Color(0xFFEFEFEF),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 16,
        ),
      ),
      items:
          Degree.values.map((degree) {
            return DropdownMenuItem(
              value: degree,
              child: Text(
                degree.name[0].toUpperCase() + degree.name.substring(1),
              ),
            );
          }).toList(),
      onChanged: (degree) => setState(() => _selectedDegree = degree),
    );
  }

  Widget _buildDatePicker(String label, DateTime? date, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: AbsorbPointer(
        child: TextField(
          controller: TextEditingController(
            text: date == null ? "" : DateFormat('dd/MM/yyyy').format(date),
          ),
          decoration: InputDecoration(
            labelText: label,
            filled: true,
            fillColor: const Color(0xFFEFEFEF),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 16,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNextButton() {
    return GestureDetector(
      onTap: _submitEducation,
      child: Container(
        width: double.infinity,
        height: 48,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: const Color(0xFFFF7A27), width: 2),
        ),
        alignment: Alignment.center,
        child: const Text(
          "Next",
          style: TextStyle(color: Color(0xFFFF7A27), fontSize: 18),
        ),
      ),
    );
  }
}
