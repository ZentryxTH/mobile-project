import 'package:flutter/material.dart';


class Mycard extends StatefulWidget {
  final String jobTitle;
  final bool isInProgress;
  final bool isApplied;
  final Function(String, bool) onFavoriteToggle;
  

  const Mycard({super.key, required this.jobTitle,required this.isInProgress,required this.isApplied, required this.onFavoriteToggle});

  @override
  State<Mycard> createState() => Mycardstate();
}


class Mycardstate extends State<Mycard> {
  bool isFavorite = true;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.only(top: 20,left: 20,right: 20),
      color: const Color.fromARGB(255, 245, 245, 245),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10), 
                  child: Image.asset(
                    'assets/images/SCB LOGO.png', 
                    width: 40,
                    height: 60,
                    fit: BoxFit.cover, 
                  ),
                ),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.jobTitle,  
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        _buildTag('Full-time', Colors.black),
                        _buildTag('Hybrid', Colors.red),
                        _buildTag('Senior', Colors.green),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            widget.isInProgress
                ? Padding(
                  padding: EdgeInsets.only(bottom: 30),
                  child: Container(
                    margin: EdgeInsets.only(top: 2, right: 5),
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.orangeAccent,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text(
                      'Pending',
                      style: TextStyle(fontSize: 9.5, color: Colors.black),
                    ),
                  ),
                )
                : widget.isApplied
                ? Padding(
                  padding: EdgeInsets.only(bottom: 30),
                  child: Container(
                    margin: EdgeInsets.only(top: 2, right: 5),
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.orangeAccent,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text(
                      'Applied',
                      style: TextStyle(fontSize: 9.5, color: Colors.black),
                    ),
                  ),
                )
                : IconButton(
                  padding: EdgeInsets.only(bottom: 30),
                  iconSize: 30,
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite ? Colors.red : Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      isFavorite = !isFavorite;
                    });
                    widget.onFavoriteToggle(widget.jobTitle, isFavorite);
                  },
                ),
              
          ],
        ),
      ),
    );
  }

  Widget _buildTag(String label, Color color) {
    return Container(
      margin: EdgeInsets.only(top: 5,right: 5),
      padding: EdgeInsets.symmetric(horizontal: 9, vertical: 5),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(13),
      ),
      child: Text(
        label,
        style: TextStyle(fontSize: 10, color: Colors.white),
      ),
    );
  }
}

