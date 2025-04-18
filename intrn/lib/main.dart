import 'package:flutter/material.dart';
import 'simulate/Homepage.dart';
import 'Listpage.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: ThemeData(useMaterial3: true),
//       home: ListPage(),
//     );
//   }
// }

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: ListPage(),
      initialRoute: '/listpage',
      routes: {
        '/homepage': (context) =>  Homepage(),
        '/listpage': (context) =>  ListPage(),
        // '/profilepage': (context) => const ProfilePage(),
      },
    );
  }
}