import 'package:flutter/material.dart';
import 'package:intrn/data/repositories/notification_repository.dart';
import 'package:intrn/pages/onboarding_page/onboarding_page.dart';
import 'package:get/get.dart';
import 'package:intrn/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:intrn/data/repositories/authentication_repository.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

<<<<<<< HEAD
void main() {
  runApp(MyApp());
=======
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("🌙 Background message: ${message.notification?.title}");
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform).then(
    (FirebaseApp value) => Get.put(AuthenticationRepository())
  );

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  Get.put(NotificationRepository());
  await NotificationRepository.instance.initNotifications();

  runApp(const MyApp());
>>>>>>> bd647a859dc251c2a69287f90405fe2ef1555ecb
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: ListPage(),
      initialRoute: '/listpage',
      routes: {
        '/homepage': (context) =>  Homepage(),
        '/listpage': (context) =>  ListPage(),
        
      },
    );
=======
    return GetMaterialApp(home: OnboardingPage());
>>>>>>> bd647a859dc251c2a69287f90405fe2ef1555ecb
  }
}