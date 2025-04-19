import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:intrn/pages/setting_page/change_languages.dart';
import 'package:intrn/pages/setting_page/change_password.dart';
import 'package:intrn/data/repositories/authentication_repository.dart';
import 'package:intrn/data/repositories/notification_repository.dart';
import 'package:get/get.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {

  bool isDarkMode = false;
  bool isNotificationOn = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFFF5F5F5),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Setting",
          style: TextStyle(
            color: Colors.black,
            fontFamily: "Poppins",
            fontSize: 24,
          ),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 24,),
            settingTitle("Security"),
            SizedBox(height: 12,),
            settingButton("Change Password", Icons.lock_outline, onTap: () {
              Get.to(() => ChangePasswordPage());
            }),
            divider(),
            settingTitle("Preference"),
            SizedBox(height: 12,),
            settingButton('Languages', Icons.language, onTap: () {
              Get.to(() => ChangeLanguages());
            }),
            SizedBox(height: 16,),
            switchButton("Dark Mode", isDarkMode, (value) {
              setState(() => isDarkMode = value);
            }),
            divider(),
            settingTitle("Notification"),
            SizedBox(height: 12,),
            notificationSwitchButton("Notification"),
            SizedBox(height: 32,),
            Center(
              child: OutlinedButton(
                onPressed: () {
                  AuthenticationRepository.instance.logout();
                },
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  side: const BorderSide(color: Colors.red),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32),
                  ),
                ),
                child: const Text(
                  "Log out",
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 16,
                    fontFamily: "Poppins",
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget settingTitle(String title) {
    return Text(
      title,
       style: TextStyle(
          color: Colors.black,
          fontFamily: "Poppins",
          fontSize: 24,
       )
    );
  }

  Widget settingButton(String title, IconData icon, {required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: const Color(0xFFF5F5F5),
          borderRadius: BorderRadius.circular(32),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 16,
                ),
              ),
            ),
            Icon(icon, color: Colors.black54),
          ],
        ),
      ),
    );
  }

  Widget divider() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 12),
      child: Divider(),
    );
  }

  Widget switchButton(String title, bool value, Function(bool) onChanged) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(32),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontFamily: "Poppins",
                fontSize: 16,
              ),
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: Color.fromARGB(255, 255, 122, 39),
          ),
        ],
      ),
    );
  }

  Widget notificationSwitchButton(String title) {
  final notificationRepo = NotificationRepository.instance;

  return Obx(() => Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: const Color(0xFFF5F5F5),
          borderRadius: BorderRadius.circular(32),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 16,
                ),
              ),
            ),
            Switch(
              value: !notificationRepo.isMuted.value,
              onChanged: (val) {
                notificationRepo.toggleMute(!val); // If off, mute true
              },
              activeColor: Color.fromARGB(255, 255, 122, 39),
            ),
          ],
        ),
      ));
  }
}