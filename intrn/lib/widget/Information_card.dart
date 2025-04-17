import 'package:flutter/material.dart';


class Build_infocard extends StatelessWidget {
  const Build_infocard({
    super.key,
    required this.icon,
    required this.text,
  });

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(16),
      elevation: 3.5,
      child: Container(
        width: 150,
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
        ),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Color(0xFFFFE5D3),
                shape: BoxShape.circle,
              ),
              padding: EdgeInsets.all(8),
              child: Icon(icon, color: Colors.orange),
            ),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                text,
                style: TextStyle(fontSize: 14),
                softWrap: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class apply_button extends StatelessWidget {

  const apply_button({
    super.key,
    required this.text,
    required this.colorbackground,
    required this.colortext,
    
  });
  final String text;
  final Color colorbackground;
  final Color colortext;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(

      onPressed: () {
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: colorbackground,
        foregroundColor: colortext,
        padding: EdgeInsets.symmetric(vertical: 16,),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: 16),
      ),
    );
  }
}

AppBar appbarCard() {
    return AppBar(
      toolbarHeight: 80,
      backgroundColor: Colors.transparent,
      flexibleSpace: Stack(
        fit: StackFit.expand,
        children: [
          Image(
            image: AssetImage("assets/images/CardTemplate.png"),
            fit: BoxFit.cover,
          ),
          Align(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Container(
                height: 10,
                padding: EdgeInsets.only(right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(Icons.favorite_border),
                    Icon(Icons.share),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }