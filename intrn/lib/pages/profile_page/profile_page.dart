import 'package:flutter/material.dart';
import '../../models/user.dart';
import '../edit_profile_page.dart';

class ProfilePage extends StatefulWidget {
  final User user;

  const ProfilePage({Key? key, required this.user}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late User currentUser;

  @override
  void initState() {
    super.initState();
    currentUser = widget.user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'List'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            const Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.settings),
              ),
            ),
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/avatar.png'),
            ),
            Text("${currentUser.firstName} ${currentUser.lastName}",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text(currentUser.biography),
            Wrap(
              spacing: 10,
              children: [
                Chip(
                  avatar: Icon(Icons.location_on, color: Colors.white),
                  label: Text('${currentUser.country}, ${currentUser.city}'),
                  backgroundColor: Colors.orange,
                  labelStyle: TextStyle(color: Colors.white),
                ),
                Chip(
                  avatar: Icon(Icons.mail, color: Colors.white),
                  label: Text(currentUser.email),
                  backgroundColor: Colors.orange,
                  labelStyle: TextStyle(color: Colors.white),
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () async {
                final updatedUser = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditProfilePage(user: currentUser),
                  ),
                );

                if (updatedUser != null && updatedUser is User) {
                  setState(() {
                    currentUser = updatedUser;
                  });
                }
              },
              icon: Icon(Icons.edit),
              label: Text("Edit Profile"),
            ),
            ElevatedButton.icon(
              onPressed: () {},
              icon: Icon(Icons.share),
              label: Text("Share Profile"),
            ),
          ],
        ),
      ),
    );
  }
}