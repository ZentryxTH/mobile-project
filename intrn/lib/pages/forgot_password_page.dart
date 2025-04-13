import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {

  final TextEditingController emailController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
          "Forgot Password",
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
              Text(
                "Enter Email Address",
                style: TextStyle(fontFamily: "Poppins", fontSize: 16),
              ),
              SizedBox(height: 6),
              emailBox(),
              SizedBox(height: 32,),
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
        child: Text("Send",
          style: TextStyle(
            fontFamily: "Poppins",
            fontSize: 16,
            color: Color.fromARGB(255, 255, 122, 39),
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
