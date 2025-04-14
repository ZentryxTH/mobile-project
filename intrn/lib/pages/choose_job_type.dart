import 'package:flutter/material.dart';
import 'package:intrn/pages/finish_signup.dart';

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

class ChooseJobType extends StatefulWidget {
  const ChooseJobType({super.key});

  @override
  State<ChooseJobType> createState() => _ChooseJobTypeState();
}


class _ChooseJobTypeState extends State<ChooseJobType> {

  final List<String> jobTypes = [
    "Software Engineer",
    "Creative",
    "Data Engineer",
    "UX/UI Designer",
    "Computer Scientist",
    "Graphic Designer",
    "Marketing",
    "Accountant",
    "Internship",
    "Senior",
    "Graduated",
    "Video Editor",
    "Game Developer",
    "Web Developer",
  ];

  List<String> selectedJobs = [];

  void _next() {
    Navigator.of(context).pushReplacement(_fadeRoute(FinishSignup()));
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
              SizedBox(height: 64,),
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
                          "What type of Job you're\nlooking for?",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 24,
                          )
                        ),
                        SizedBox(height: 24),
                        _buildChipsWrap(),
                        SizedBox(height: 80),
                        nextButton(),
                        SizedBox(height: 16),
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

  Widget _buildChipsWrap() {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: jobTypes.map((job) {
        final isSelected = selectedJobs.contains(job);
        return FilterChip(
          label: Text(
            job,
            style: TextStyle(
              fontFamily: "Poppins",
              color: isSelected ? Color.fromARGB(255, 255, 122, 39) : Colors.black,
            ),
          ),
          selected: isSelected,
          onSelected: (bool selected) {
            setState(() {
              if (selected) {
                selectedJobs.add(job);
              } else {
                selectedJobs.remove(job);
              }
            });
          },
          backgroundColor: Colors.white,
          selectedColor: const Color(0xFFFFE5D3),
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: isSelected ? Color.fromARGB(255, 255, 122, 39) : Colors.grey.shade400,
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(24),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        );
      }).toList(),
    );
  }
}