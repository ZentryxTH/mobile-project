import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intrn/pages/add_resume_page.dart';

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

class AddEducationPage extends StatefulWidget {
  const AddEducationPage({super.key});

  @override
  State<AddEducationPage> createState() => _AddEducationPageState();
}

enum Degree {
  bachelor,
  master,
  doctorate,
  diploma,
  associate,
  other,
}

class _AddEducationPageState extends State<AddEducationPage> {

  final TextEditingController instructorController = TextEditingController();
  final TextEditingController facultyController = TextEditingController();
  Degree? selectedDegree;
  DateTime? startDate;
  DateTime? endDate;

  Future<void> pickStartDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        startDate = picked;
      });
    }
  }

  Future<void> pickEndDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime.now().add(Duration(days: 365 * 10)),
    );
    if (picked != null) {
      setState(() {
        endDate = picked;
      });
    }
  }

  void _next() {
    Navigator.of(context).pushReplacement(_fadeRoute(AddResumePage()));
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
                          "Add Your Education",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 24,
                          )
                        ),
                        SizedBox(height: 24,),
                        instructorInput(),
                        SizedBox(height: 16,),
                        facultyInput(),
                        SizedBox(height: 16,),
                        degreeInput(),
                        SizedBox(height: 16,),
                        startDateInput(),
                        SizedBox(height: 16,),
                        endDateInput(),
                        SizedBox(height: 24,),
                        nextButton(),
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

  GestureDetector endDateInput() {
    return GestureDetector(
      onTap: pickEndDate,
      child: AbsorbPointer(
        child: TextField(
          decoration: InputDecoration(
            labelText: "End Date",
            filled: true,
            fillColor: Color.fromARGB(255, 239, 239, 239),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none,
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          ),
          controller: TextEditingController(
            text: endDate == null
                ? ""
                : DateFormat('dd/MM/yyyy').format(endDate!),
          ),
        ),
      ),
    );
  }

  GestureDetector startDateInput() {
    return GestureDetector(
      onTap: pickStartDate,
      child: AbsorbPointer(
        child: TextField(
          decoration: InputDecoration(
            labelText: "Start Date",
            filled: true,
            fillColor: Color.fromARGB(255, 239, 239, 239),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none,
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          ),
          controller: TextEditingController(
            text: startDate == null
                ? ""
                : DateFormat('dd/MM/yyyy').format(startDate!),
          ),
        ),
      ),
    );
  }
 

  DropdownButtonFormField degreeInput() {
    return DropdownButtonFormField<Degree>(
      value: selectedDegree,
      decoration: InputDecoration(
        labelText: "Degree",
        filled: true,
        fillColor: Color.fromARGB(255, 239, 239, 239),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      ),
      items: Degree.values.map((degree) {
        return DropdownMenuItem<Degree>(
          value: degree,
          child: Text(
            degree.name[0].toUpperCase() + degree.name.substring(1), // Capitalize
            style: TextStyle(fontFamily: "Poppins"),
          ),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          selectedDegree = value;
        });
      },
    );
  }

  TextField facultyInput() {
    return TextField(
      controller: facultyController,
      decoration: InputDecoration(
        labelText: "Faculty",
        labelStyle: TextStyle(
          fontFamily: "Poppins",
          fontSize: 16,
          color: Colors.black,
        ),
        filled: true,
        fillColor: Color.fromARGB(255, 239, 239, 239), // Light gray background
        contentPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30), // Fully rounded corners
          borderSide: BorderSide.none, // No border line
        ),
      ),
      style: TextStyle(
        fontFamily: "Poppins",
        fontSize: 16,
        color: Colors.black,
      ),
    );
  }

  TextField instructorInput() {
    return TextField(
      controller: instructorController,
      decoration: InputDecoration(
        labelText: "Instructor",
        labelStyle: TextStyle(
          fontFamily: "Poppins",
          fontSize: 16,
          color: Colors.black,
        ),
        filled: true,
        fillColor: Color.fromARGB(255, 239, 239, 239), // Light gray background
        contentPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30), // Fully rounded corners
          borderSide: BorderSide.none, // No border line
        ),
      ),
      style: TextStyle(
        fontFamily: "Poppins",
        fontSize: 16,
        color: Colors.black,
      ),
    );
  }

  String? getDegreeString() {
    if (selectedDegree == null) return null;
    switch (selectedDegree!) {
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
        return "Other";
    }
  }

}