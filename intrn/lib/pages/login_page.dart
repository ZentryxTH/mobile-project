import 'package:flutter/material.dart';
import 'package:intrn/pages/home_page.dart';
import 'package:intrn/pages/signup_page.dart';
import 'package:intrn/firebase_options.dart';
import 'package:intrn/data/repositories/authentication_repository.dart';

PageRouteBuilder _fadeRoute(Widget page) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(opacity: animation, child: child);
    },
  );
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isObscure = true;

  void _login() async {
    if (_formKey.currentState!.validate()) {
      try {
        await AuthenticationRepository.instance.loginWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );

        // Navigate on success
        Navigator.of(context).pushReplacement(_fadeRoute(const HomePage()));
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 255, 179, 117),
          ),
          width: double.infinity,
          child: Column(
            children: [
              const SizedBox(height: 80),
              Container(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height * 0.8,
                ),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 64,
                          height: 64,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: const Image(
                            image: AssetImage("assets/images/Intrnip.png"),
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          "Hey, there",
                          style: TextStyle(fontFamily: "Poppins", fontSize: 24),
                        ),
                        const Text(
                          "Welcome Back",
                          style: TextStyle(fontFamily: "Poppins", fontSize: 24),
                        ),
                        const SizedBox(height: 16),
                        emailBox(),
                        const SizedBox(height: 24),
                        passwordBox(),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const [
                            Text(
                              "Forget Password?",
                              style: TextStyle(
                                color: Color(0xFFFF7A27),
                                fontFamily: "Poppins",
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        loginButton(),
                        const SizedBox(height: 6),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "New user?",
                              style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(width: 4),
                            GestureDetector(
                              onTap:
                                  () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => SignupPage(),
                                    ),
                                  ),
                              child: const Text(
                                "Sign up",
                                style: TextStyle(
                                  fontFamily: "Poppins",
                                  color: Color(0xFFFF7A27),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        Row(
                          children: const [
                            Expanded(
                              child: Divider(
                                color: Colors.black,
                                thickness: 1,
                                endIndent: 8,
                              ),
                            ),
                            Text(
                              "OR",
                              style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            Expanded(
                              child: Divider(
                                color: Colors.black,
                                thickness: 1,
                                indent: 8,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
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
        if (value == null || value.isEmpty) return 'Please enter email';
        final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
        if (!emailRegex.hasMatch(value)) return 'Enter a valid email';
        return null;
      },
      decoration: inputStyle("Email"),
    );
  }

  TextFormField passwordBox() {
    return TextFormField(
      controller: passwordController,
      obscureText: isObscure,
      validator: (value) {
        if (value == null || value.isEmpty) return 'Please enter password';
        if (value != passwordController.text) return 'Password is incorrect';
        return null;
      },
      decoration: inputStyle("Password").copyWith(
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

  InputDecoration inputStyle(String hint) {
    return InputDecoration(
      filled: true,
      fillColor: const Color(0xFFEFEFEF),
      hintText: hint,
      hintStyle: const TextStyle(fontFamily: "Poppins", fontSize: 16),
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(24),
        borderSide: BorderSide.none,
      ),
    );
  }

  Widget loginButton() {
    return GestureDetector(
      onTap: _login,
      child: Container(
        width: double.infinity,
        height: 48,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: const Color(0xFFFF7A27), width: 2),
        ),
        alignment: Alignment.center,
        child: const Text(
          "Login",
          style: TextStyle(
            color: Color(0xFFFF7A27),
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
