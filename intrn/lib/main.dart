import 'package:flutter/material.dart';
import 'package:intrn/pages/create_new_password.dart';
import 'package:intrn/pages/forgot_password_page.dart';
import 'package:intrn/pages/verification_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: VerificationPage(),
    );
  }
}
