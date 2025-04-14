import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intrn/pages/forgot_password_page/forgot_password_page.dart';

PageRouteBuilder _fadeRoute(Widget page) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(opacity: animation, child: child);
    },
  );
}

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController currentPasswordController =
      TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isObscure = true;

  void _send() {
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 245, 245, 245),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_rounded),
        ),
        title: Text(
          "Change Password",
          style: TextStyle(fontFamily: "Poppins", fontSize: 24),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 24),
              Text(
                "Enter Email Address",
                style: TextStyle(fontFamily: "Poppins", fontSize: 16),
              ),
              SizedBox(height: 8),
              emailBox(),
              SizedBox(height: 16,),
              Text(
                "Current Password",
                style: TextStyle(fontFamily: "Poppins", fontSize: 16),
              ),
              SizedBox(height: 8,),
              currentPassword(),
              SizedBox(height: 12,),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(_fadeRoute(ForgotPasswordPage()));
                }, 
                child: Text("Forgot Password?",
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 12,
                  ),
                )
              ),
              SizedBox(height: 32),
              _sendEmailButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sendEmailButton() {
    return GestureDetector(
      onTap: _send,
      child: Container(
        width: double.infinity,
        height: 48,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: Color.fromARGB(255, 255, 122, 39),
            width: 2,
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          "Send",
          style: TextStyle(
            fontFamily: "Poppins",
            fontSize: 16,
            color: Color.fromARGB(255, 255, 122, 39),
          ),
        ),
      ),
    );
  }

  TextFormField currentPassword() {
    return TextFormField(
      controller: currentPasswordController,
      obscureText: isObscure,
      validator: (value) {
        if (value == null || value.isEmpty) return 'Please enter password';
        // Push Backend
        return null;
      },
      decoration: InputDecoration(
        labelText: 'Current Password',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        suffixIcon: GestureDetector(
          onTap: () => setState(() => isObscure = !isObscure),
          child: Icon(
            isObscure ? Icons.visibility_off : Icons.visibility,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }

  TextFormField emailBox() {
    return TextFormField(
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your email';
        } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
          return 'Invalid email format';
        }
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
    );
  }
}
