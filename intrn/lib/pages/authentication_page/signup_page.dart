import 'package:flutter/material.dart';
import 'package:intrn/pages/profile_page/create_profile_page.dart';
import 'package:intrn/pages/authentication_page/login_page.dart';
import 'package:intrn/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:intrn/data/repositories/authentication_repository.dart';


PageRouteBuilder _fadeRoute(Widget page) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: animation,
        child: child,
      );
    },
  );
}

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool isPasswordObscure = true;
  bool isConfirmPasswordObscure = true;

  void _signup() async {
    if (formKey.currentState!.validate()) {
      try {
        await AuthenticationRepository.instance.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );

        Navigator.of(context).pushReplacement(_fadeRoute(const CreateProfilePage()));
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Signup failed: ${e.toString()}')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(color: Color.fromARGB(255, 255, 179, 117)),
          width: double.infinity,
          child: Column(
            children: <Widget>[
              const SizedBox(height: 80),
              Container(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height * 0.8,
                ),
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: 64,
                          height: 64,
                          clipBehavior: Clip.antiAlias,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                          ),
                          child: const Image(
                            image: AssetImage("assets/images/Intrnip.png"),
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          "Welcome to Intrn",
                          style: TextStyle(fontFamily: "Poppins", fontSize: 24),
                        ),
                        const Text(
                          "Create your account",
                          style: TextStyle(fontFamily: "Poppins", fontSize: 24),
                        ),
                        const SizedBox(height: 8),
                        Form(
                          key: formKey,
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  children: [
                                    emailBox(),
                                    const SizedBox(height: 24),
                                    passwordBox(),
                                    const SizedBox(height: 24),
                                    confirmPasswordBox(),
                                    const SizedBox(height: 16),
                                    signupButton(),
                                    const SizedBox(height: 10),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 6),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Have an account?",
                              style: TextStyle(fontFamily: "Poppins", fontSize: 12),
                            ),
                            const SizedBox(width: 4),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const LoginPage(),
                                  ),
                                );
                              },
                              child: const Text(
                                "Sign in",
                                style: TextStyle(
                                  fontFamily: "Poppins",
                                  color: Color.fromARGB(255, 255, 122, 39),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 48),
                          child: Row(
                            children: [
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
                        ),
                        const SizedBox(height: 20),
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
      decoration: inputDecoration("Email"),
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

  TextFormField passwordBox() {
    return TextFormField(
      controller: passwordController,
      obscureText: isPasswordObscure,
      decoration: inputDecoration("Password").copyWith(
        suffixIcon: IconButton(
          icon: Icon(
            isPasswordObscure ? Icons.visibility_off : Icons.visibility,
            color: Colors.grey,
          ),
          onPressed: () {
            setState(() {
              isPasswordObscure = !isPasswordObscure;
            });
          },
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your password';
        } else if (value.length < 8) {
          return 'Password must be at least 8 characters';
        }
        return null;
      },
    );
  }

  TextFormField confirmPasswordBox() {
    return TextFormField(
      controller: confirmPasswordController,
      obscureText: isConfirmPasswordObscure,
      decoration: inputDecoration("Confirm Password").copyWith(
        suffixIcon: IconButton(
          icon: Icon(
            isConfirmPasswordObscure ? Icons.visibility_off : Icons.visibility,
            color: Colors.grey,
          ),
          onPressed: () {
            setState(() {
              isConfirmPasswordObscure = !isConfirmPasswordObscure;
            });
          },
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please confirm your password';
        } else if (value != passwordController.text) {
          return 'Passwords do not match';
        }
        return null;
      },
    );
  }

  Widget signupButton() {
    return GestureDetector(
      onTap: _signup,
      child: Container(
        width: double.infinity,
        height: 48,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: const Color.fromARGB(255, 255, 122, 39),
            width: 2,
          ),
        ),
        alignment: Alignment.center,
        child: const Text(
          "Sign up",
          style: TextStyle(
            color: Color.fromARGB(255, 255, 122, 39),
            fontSize: 18,
          ),
        ),
      ),
    );
  }

  InputDecoration inputDecoration(String hint) {
    return InputDecoration(
      filled: true,
      fillColor: const Color.fromARGB(255, 239, 239, 239),
      hintText: hint,
      hintStyle: const TextStyle(fontFamily: "Poppins", fontSize: 16),
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(24),
        borderSide: BorderSide.none,
      ),
    );
  }
}
