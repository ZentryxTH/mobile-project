import 'package:flutter/material.dart';

class CreateNewPassword extends StatefulWidget {
  const CreateNewPassword({super.key});

  @override
  State<CreateNewPassword> createState() => _CreateNewPasswordState();
}

class _CreateNewPasswordState extends State<CreateNewPassword> {
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmNewPasswordController =
      TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isObscure = true;

  void _send() {
    if (_formKey.currentState!.validate()) {
      // Check if passwords match
      if (newPasswordController.text != confirmNewPasswordController.text) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Passwords do not match')),
        );
        return;
      }

      // Simulate password update success
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 64,
              ),
              const SizedBox(height: 16),
              const Text(
                "Password Have Changed",
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(); 
                  Navigator.of(context).pop(); 
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 255, 122, 39),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                ),
                child: const Text(
                  "Back to Home",
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 245, 245, 245),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_rounded),
        ),
        title: const Text(
          "New Password",
          style: TextStyle(fontFamily: "Poppins", fontSize: 24),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "New Password",
                style: TextStyle(fontFamily: "Poppins", fontSize: 16),
              ),
              const SizedBox(height: 8),
              newPasswordInput(),
              const SizedBox(height: 16),
              const Text(
                "Confirm New Password",
                style: TextStyle(fontFamily: "Poppins", fontSize: 16),
              ),
              const SizedBox(height: 8),
              confirmNewPasswordInput(),
              const SizedBox(height: 32),
              sendButton()
            ],
          ),
        ),
      ),
    );
  }

  Widget sendButton() {
    return GestureDetector(
      onTap: _send,
      child: Container(
        width: double.infinity,
        height: 48,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: Color.fromARGB(255, 255, 122, 39),
        ),
        alignment: Alignment.center,
        child: const Text(
          "Send",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  TextFormField newPasswordInput() {
    return TextFormField(
      controller: newPasswordController,
      obscureText: isObscure,
      validator: (value) {
        if (value == null || value.isEmpty) return 'Please enter password';
        if (value.length < 8) return 'Password must be at least 8 characters';
        return null;
      },
      decoration: inputDecoration(),
    );
  }

  TextFormField confirmNewPasswordInput() {
    return TextFormField(
      controller: confirmNewPasswordController,
      obscureText: isObscure,
      validator: (value) {
        if (value == null || value.isEmpty) return 'Please confirm password';
        return null;
      },
      decoration: inputDecoration(),
    );
  }

  InputDecoration inputDecoration() {
    return InputDecoration(
      filled: true,
      fillColor: const Color.fromARGB(255, 239, 239, 239),
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(24),
        borderSide: BorderSide.none,
      ),
      suffixIcon: GestureDetector(
        onTap: () => setState(() => isObscure = !isObscure),
        child: Icon(
          isObscure ? Icons.visibility_off : Icons.visibility,
          color: Colors.grey,
        ),
      ),
    );
  }
}
