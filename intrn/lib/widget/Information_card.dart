import 'package:flutter/material.dart';


class Build_infocard extends StatelessWidget {
  const Build_infocard({
    super.key,
    required this.icon,
    required this.text,
    required this.text2,
    
  });

  final IconData icon;
  final String text;
  final String text2;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(16),
      elevation: 3.5,
      child: Container(
        width: 150,
        height: 80,
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
                color: Color.fromARGB(255, 250, 178, 126),
                shape: BoxShape.circle,
              ),
              padding: EdgeInsets.all(8),
              child: Icon(icon, color: Colors.white),
            ),
            SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 8,),
                  Text(
                    text,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black, 
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  Text(
                    text2,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.orange, 
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ],

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
  bool islike = false;
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
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisSize: MainAxisSize.min, 
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 253, 159, 82),
                      borderRadius: BorderRadius.circular(10),
                      
                    ),
                    margin: EdgeInsets.only(right: 10),
                    child: StatefulBuilder(
                      builder: (BuildContext context, StateSetter setState){
                        return IconButton(
                        icon: Icon(
                          size: 30,
                          islike ? Icons.favorite : Icons.favorite_border,
                          color: islike ? Colors.red : Colors.black,
                        ),
                        onPressed: () {
                          setState(() {
                            islike = !islike; 
                          });
                        },
                      );
                      }),
                  ),
                  Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 253, 159, 82), 
                    borderRadius: BorderRadius.circular(10), 
                  ),
                  child: IconButton(
                    color: Colors.black,
                    icon: Icon(Icons.share),
                    onPressed: () {
                      
                      print('แชร์');
                    },
                  ),
                ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }