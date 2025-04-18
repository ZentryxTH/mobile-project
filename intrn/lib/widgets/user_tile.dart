import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {

  final Map<String, dynamic> userData;
  final VoidCallback? onTap;

  const UserTile({
    super.key,
    required this.userData,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {

    final firstname = userData['firstName'] ?? '';
    final lastname = userData['lastName'] ?? '';
    final displayInitial = firstname.isNotEmpty ? firstname[0].toUpperCase() : '?';

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.grey.shade300,
              child: Text(
                displayInitial,
                style: const TextStyle(color: Colors.black),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                "$firstname $lastname",
                style: const TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}