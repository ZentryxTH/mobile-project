import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intrn/data/services/verification_service.dart';
import 'package:intrn/data/repositories/authentication_repository.dart';
import 'package:intrn/pages/forgot_password_page/create_new_password.dart';

class VerificationPage extends StatefulWidget {
  final String email;

  const VerificationPage({required this.email, super.key});

  @override
  State<VerificationPage> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());
  final List<TextEditingController> codeController = List.generate(
    6,
    (_) => TextEditingController(),
  );

  void _onCodeChanged(String value, int index) {
    if (value.length == 1 && index < 5) {
      FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
    } else if (value.isEmpty && index > 0) {
      FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
    }
  }

  Future<void> _sendCode() async {
    final code = codeController.map((c) => c.text).join();
    final isVerified = await AuthenticationRepository.instance.verifyOtp(
      email: widget.email,
      otp: code,
    );

    if (isVerified) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => CreateNewPassword(email: widget.email),
        ),
      );
    } else {
      _showError("Incorrect code");
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.redAccent,
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 245, 245, 245),
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios_rounded),
        ),
        title: Text(
          "Verification",
          style: TextStyle(fontFamily: "Poppins", fontSize: 24),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Enter Your Verification Code",
              style: TextStyle(fontFamily: "Poppins", fontSize: 16),
            ),
            SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(6, (index) => _buildCodeInputBox(index)),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Text(
                  "If you didn't receive a code,",
                  style: TextStyle(fontFamily: "Poppins", fontSize: 12),
                ),
                TextButton(
                  onPressed: () => {},
                  child: Text(
                    "Resend",
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 12,
                      color: Color.fromARGB(255, 255, 122, 39),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            confirmCodeButton(),
          ],
        ),
      ),
    );
  }

  Widget confirmCodeButton() {
    return GestureDetector(
      onTap: _sendCode,
      child: Container(
        width: double.infinity,
        height: 48,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: Color(0xFFFF7A27),
        ),
        alignment: Alignment.center,
        child: const Text(
          "Login",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildCodeInputBox(int index) {
    return SizedBox(
      width: 48,
      child: TextField(
        controller: codeController[index],
        focusNode: _focusNodes[index],
        keyboardType: TextInputType.number,
        maxLength: 1,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 20,
          fontFamily: "Poppins",
          fontWeight: FontWeight.bold,
        ),
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        decoration: InputDecoration(
          counterText: "",
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
        onChanged: (value) => _onCodeChanged(value, index),
      ),
    );
  }
}
