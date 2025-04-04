import 'package:flutter/material.dart';
import 'package:intrn/Listpage.dart';



class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('test'),
      ),
      bottomNavigationBar: NavigationBars(),
      
    );
  }
}

