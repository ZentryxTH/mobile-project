import 'package:flutter/material.dart';
import 'package:intrn/pages/onboarding_page.dart';
import 'package:get/get.dart';

void main() async{
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: OnboardingPage(),
    );
  }
}
