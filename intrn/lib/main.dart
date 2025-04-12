import 'package:flutter/material.dart';
import 'package:intrn/pages/create_profile_page.dart';
import 'package:intrn/pages/onboarding_page.dart';
import 'package:get/get.dart';
import 'package:intrn/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:intrn/data/repositories/authentication_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform).then(
    (FirebaseApp value) => Get.put(AuthenticationRepository())
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(home: OnboardingPage());
  }
}
