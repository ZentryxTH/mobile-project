import 'package:flutter/material.dart';


class Inprogess extends StatefulWidget {
  const Inprogess({super.key});

  @override
  State<Inprogess> createState() => Inprogessstate();
}

class Inprogessstate extends State<Inprogess> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Inprogess detail')),
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


