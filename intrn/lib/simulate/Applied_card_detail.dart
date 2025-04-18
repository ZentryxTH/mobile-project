import 'package:flutter/material.dart';
import 'package:intrn/widget/Information_tabbar.dart';
import 'package:intrn/widget/Information_card.dart';

class Applieds extends StatefulWidget {
  final String jobTitle;
  const Applieds({super.key,required this.jobTitle});

  @override
  State<Applieds> createState() => Appliedstate();
}

class Appliedstate extends State<Applieds> {
  int selectedIndex = 0;


  final List<Widget> _contentPages = [
    const AboutContent(),
    const CompanyContent(),
    const ReviewContent(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
      appBar: appbarCard(),
      body: SingleChildScrollView( 
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height + 150, 
              child: Column(
                children: [
                  SizedBox(height: 50),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(30),
                        ),
                      ),
                      padding: EdgeInsets.only(top: 60, left: 0, right: 0),
                      child: Column(
                        children: [
                          Center(
                            child: Column(
                              children: [
                                Text(
                                  widget.jobTitle,
                                  style: TextStyle(
                                    fontSize: 33,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'SCB',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: const Color.fromARGB(255, 32, 32, 32),
                                    ),
                                ),
                                SizedBox(height: 2),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.map, color: Colors.orangeAccent),
                                    SizedBox(width: 4),
                                    Text(
                                      'Thailand, Bangkok',
                                      style:
                                          TextStyle(color: const Color.fromARGB(255, 58, 58, 58)),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 24),
                          Wrap(
                            spacing: 20,
                            runSpacing: 20,
                            alignment: WrapAlignment.center,
                            children: [
                              Build_infocard(icon: Icons.monetization_on, text: "Salary",text2: "1000-2000",),
                              Build_infocard(icon: Icons.work, text: "Job type",text2: "Full-time",),
                              Build_infocard(icon: Icons.wifi, text: "Work model",text2: "Online",),
                              Build_infocard(icon: Icons.stacked_line_chart, text: "Level",text2: "Internship",),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 40,left: 0,right: 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                _buildTabButton(0, 'About'),
                                _buildTabButton(1, 'Company'),
                                _buildTabButton(2, 'Review'),
                              ],
                            ),
                          ),
                          
                          Expanded(child: _contentPages[selectedIndex]),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 20,
              left: 0,
              right: 0,
              child: Center(
                child: Material(
                  borderRadius: BorderRadius.circular(10),
                  elevation: 6,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      "assets/images/scblogo.png",
                      height: 70,
                      width: 70,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        child: Material(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(1),
            topRight: Radius.circular(1),
          ),
          child: Container(
            margin: EdgeInsets.only(left: 1, right: 1),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 250, 250, 250),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(28),
                topRight: Radius.circular(28),
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color.fromARGB(255, 226, 226, 226),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: Offset(0, -2),
                ),
              ],
            ),
            padding: const EdgeInsets.all(16.0),
            child: apply_button(
              text: 'Apply the job',
              colorbackground: Colors.orange,
              colortext: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTabButton(int index, String text) {
    bool isSelected = selectedIndex == index;
    
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.white,
          borderRadius: BorderRadius.circular(0),
          boxShadow: isSelected ? [
            BoxShadow(
              color: const Color.fromARGB(255, 219, 219, 219),
              blurRadius: 2,
              spreadRadius: 1,
              offset: const Offset(0, 1),
            )
          ] : [BoxShadow(
            color: const Color.fromARGB(255, 207, 207, 207),
              blurRadius: 0,
              spreadRadius: 1,
              offset: const Offset(1, -1),
          )],
          border: isSelected ? Border(
            bottom: BorderSide(
              color: Colors.orange,
              width: 3,
            ),
          ) : Border(
            top: BorderSide(
              color: const Color.fromARGB(255, 231, 231, 231)
            ),
            bottom: BorderSide(
              color: const Color.fromARGB(255, 231, 231, 231)
            ),
            left: BorderSide(
              color: const Color.fromARGB(255, 231, 231, 231)
            ),
            
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            color: isSelected ? Colors.orange : Colors.black,
          ),
        ),
      ),
    );
  }

}


