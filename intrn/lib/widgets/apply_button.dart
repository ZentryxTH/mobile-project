import 'package:flutter/material.dart';

class ApplyButton extends StatelessWidget {
  final String text;
  final Color colorbackground;
  final Color colortext;
  final VoidCallback onPressed; // Define onPressed parameter

  const ApplyButton({
    Key? key,
    required this.text,
    required this.colorbackground,
    required this.colortext,
    required this.onPressed,  // Accept onPressed parameter
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: colorbackground, // Use backgroundColor for button's background color
        foregroundColor: colortext, // Use foregroundColor for text color
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 25),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28),
        ),
      ),
      onPressed: onPressed,  // Set onPressed to the callback
      child: Text(text),
    );
  }
}
