import 'package:flutter/material.dart';
import 'models/user.dart';
import 'pages/profile_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final User testUser = User(
    firstName: "John",
    lastName: "Doe",
    birthDate: "27/08/1996",
    phone: "099-999-9999",
    biography: "Senior UX/UI Designer",
    address1: "Address 1",
    address2: "Address 2",
    city: "Bangkok",
    country: "Thailand",
    university: "Mahidol University",
    faculty: "Information Communication and",
    degree: "Bachelor's Degree",
    startDate: "01/01/2015",
    endDate: "01/01/2019",
    email: "john.doe@who.com",
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ProfilePage(user: testUser),
    );
  }
}