import 'package:flutter/material.dart';
import 'package:intrn/pages/main_page/main_page.dart';

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

class FinishSignup extends StatefulWidget {
  const FinishSignup({super.key});

  @override
  State<FinishSignup> createState() => _FinishSignupPageState();
}

class _FinishSignupPageState extends State<FinishSignup> {

  void _finish(){
    Navigator.of(context).pushReplacement(_fadeRoute(MainPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background1.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 200,),
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/Intrnip.png"),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(32)),
                ),
              ),
              SizedBox(height: 180,),
              Padding(
                padding: EdgeInsets.fromLTRB(48, 0, 48, 0),
                child: finishButton(),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget finishButton() {
    return GestureDetector(
      onTap: _finish ,
      child: Container(
        width: double.infinity,
        height: 48,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 255, 122, 39),
          borderRadius: BorderRadius.all(Radius.circular(24)),
        ),
        alignment: Alignment.center,
        child: Text(
          "Finish",
          style: TextStyle(
            fontFamily: "Poppins",
            color: Colors.white,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}