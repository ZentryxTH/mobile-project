import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 255, 179, 117),
        ),
        width: double.infinity,
        child: Column(
          children: <Widget>[
            SizedBox(height: 80,),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft:Radius.circular(40), topRight: Radius.circular(40)),
                  color: Colors.white,                  
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}