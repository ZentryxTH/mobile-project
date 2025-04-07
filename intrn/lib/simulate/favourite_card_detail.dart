import 'package:flutter/material.dart';


class favourite extends StatefulWidget {
  const favourite({super.key});

  @override
  State<favourite> createState() => favouritestate();
}

class favouritestate extends State<favourite> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('favourite detail')),
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


