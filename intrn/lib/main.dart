import 'package:flutter/material.dart';
import 'package:intrn/pages/finish_signup.dart';
import 'package:intrn/pages/signup_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FinishSignup(),
    );
  }
}
