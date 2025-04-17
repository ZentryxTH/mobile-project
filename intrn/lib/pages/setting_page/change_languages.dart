import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangeLanguages extends StatefulWidget {
  const ChangeLanguages({super.key});

  @override
  State<ChangeLanguages> createState() => _ChangeLanguagesState();
}

class _ChangeLanguagesState extends State<ChangeLanguages> {


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
          "Change Language", // Or localized text
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontFamily: "Poppins",
          ),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Column(
          children: [
            languageOption("English", "assets/flags/english.png", () {
              Get.updateLocale(const Locale('en', 'US'));
            }),
            languageOption("Thai", "assets/flags/thai.png", () {
              // TODO: change language to Thai
              Get.updateLocale(const Locale('th', 'TH'));
            }),
            languageOption("Chinese", "assets/flags/china.png", () {
              // TODO: change language to Chinese
              Get.updateLocale(const Locale('zh', 'ZH'));
            }),
          ],
        )
      ),
    );
  }

  Widget languageOption(String title, String imagePath, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: const Color(0xFFF5F5F5),
          borderRadius: BorderRadius.circular(24),
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
            Image.asset(imagePath, width: 32, height: 32),
            const SizedBox(width: 16),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontFamily: "Poppins",
              ),
            ),
          ],
        ),
      ),
    );
  }
}