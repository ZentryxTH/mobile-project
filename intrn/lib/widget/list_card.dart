import 'package:flutter/material.dart';

class Mycard extends StatefulWidget {
  const Mycard({super.key});

  @override
  State<Mycard> createState() => Mycardstate();
}

class Mycardstate extends State<Mycard> {
  // const Mycardstate({super.key});
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.only(left: 20,right: 20),
      color: const Color.fromARGB(255, 245, 245, 245),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8), 
                  child: Image.asset(
                    'intrn/assets/logo.png', 
                    width: 40,
                    height: 40,
                    fit: BoxFit.cover, 
                  ),
                ),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Data Engineer',
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
            IconButton(
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: isFavorite ? Colors.red : Colors.grey,
              ),
              onPressed: () {
                setState(() {
                  isFavorite = !isFavorite;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildTag(String label, Color color) {
    return Container(
      margin: EdgeInsets.only(top: 8,right: 8),
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: TextStyle(fontSize: 12, color: Colors.white),
      ),
    );
  }
}