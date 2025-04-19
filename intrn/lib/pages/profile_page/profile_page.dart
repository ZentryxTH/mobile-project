import 'package:flutter/material.dart';
import 'package:intrn/models/user_model.dart';
import 'package:intrn/data/repositories/user_repository.dart';
import 'package:intrn/pages/profile_page/edit_profile_page.dart';
import 'package:intrn/models/user_extended_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intrn/pages/setting_page/setting_page.dart';
import 'package:get/get.dart';
import 'dart:io';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final UserRepository _repo = UserRepository();
  UserModel? currentUser;
  UserExtendedModel? currentUserExtra;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadUser();
  }

  Future<void> loadUser() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) return;

    try {
      final user = await _repo.getUserById(userId);
      final extra = await _repo.getUserExtended();

      if (mounted) {
        setState(() {
          currentUser = user;
          currentUserExtra = extra;
          isLoading = false;
        });
      }
    } catch (e) {
      print("Error loading user: $e");
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : currentUser == null
              ? Center(child: Text("No user found"))
              : SafeArea(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topRight,
                          child: IconButton(
                            onPressed: () => Get.to(SettingPage()),
                            icon: Icon(Icons.settings),
                          ),
                        ),
                        CircleAvatar(
                          radius: 50,
                          backgroundImage: currentUser!.imageUrl != null && currentUser!.imageUrl!.isNotEmpty
                              ? currentUser!.imageUrl!.startsWith('http')
                                  ? NetworkImage(currentUser!.imageUrl!)
                                  : FileImage(File(currentUser!.imageUrl!)) as ImageProvider
                              : AssetImage('assets/avatar.png'),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "${currentUser!.firstName} ${currentUser!.lastName}",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        if (currentUserExtra?.biography != null &&
                            currentUserExtra!.biography!.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              currentUserExtra!.biography!,
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.grey[700]),
                            ),
                          ),
                        SizedBox(height: 10),
                        Wrap(
                          spacing: 10,
                          runSpacing: 8,
                          children: [
                            Chip(
                              avatar:
                                  Icon(Icons.mail, color: Colors.white, size: 18),
                              label: Text(currentUser!.email),
                              backgroundColor: Colors.orange,
                              labelStyle: TextStyle(color: Colors.white),
                            ),
                            if (currentUser!.country.isNotEmpty ||
                                (currentUserExtra?.city?.isNotEmpty ?? false))
                              Chip(
                                avatar: Icon(Icons.location_on,
                                    color: Colors.white, size: 18),
                                label: Text(
                                  "${currentUser!.country}${currentUserExtra?.city != null ? ', ${currentUserExtra!.city}' : ''}",
                                ),
                                backgroundColor: Colors.orange,
                                labelStyle: TextStyle(color: Colors.white),
                              ),
                            if (currentUser!.phone.isNotEmpty)
                              Chip(
                                avatar: Icon(Icons.phone,
                                    color: Colors.white, size: 18),
                                label: Text(currentUser!.phone),
                                backgroundColor: Colors.orange,
                                labelStyle: TextStyle(color: Colors.white),
                              ),
                          ],
                        ),
                        SizedBox(height: 20),
                        if (currentUserExtra?.address1 != null ||
                            currentUserExtra?.address2 != null)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (currentUserExtra?.address1?.isNotEmpty ?? false)
                                Text("Address 1: ${currentUserExtra!.address1}"),
                              if (currentUserExtra?.address2?.isNotEmpty ?? false)
                                Text("Address 2: ${currentUserExtra!.address2}"),
                            ],
                          ),
                        SizedBox(height: 20),
                        ElevatedButton.icon(
                          onPressed: () async {
                            final updatedUser = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    EditProfilePage(user: currentUser!),
                              ),
                            );

                            if (updatedUser != null &&
                                updatedUser is UserModel) {
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
                ),
    );
  }
}
