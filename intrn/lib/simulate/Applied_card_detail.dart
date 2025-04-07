import 'package:flutter/material.dart';


class Applieds extends StatefulWidget {
  const Applieds({super.key});

  @override
  State<Applieds> createState() => Appliedstate();
}

class Appliedstate extends State<Applieds> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Applied detail')),
      body: Center(child: Text('page1')
                              ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.pop(context);
        },
        child: Icon(Icons.arrow_back),
      ),
    );
  }
}


