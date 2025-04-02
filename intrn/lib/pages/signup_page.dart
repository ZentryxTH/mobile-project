import 'package:flutter/material.dart';

PageRouteBuilder _fadeRoute(Widget page) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
          opacity: animation,
          child: child); // Directly return the new page with no animation
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
  bool isObscure = true;
  String? errorMessage;

  void _signup() {
    // Navigator.of(context).pushReplacement(_fadeRoute(HomePage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 255, 179, 117),
        ),
        width: double.infinity,
        child: Column(
          children: <Widget>[
            SizedBox(height: 80,),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft:Radius.circular(40), topRight: Radius.circular(40)),
                  color: Colors.white,                  
                ),
                child: Padding(
                  padding: EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: 64,
                        height: 64,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                        ),
                        child: Image(image: AssetImage("assets/images/Intrnip.png"))
                      ),
                      SizedBox(height: 16,),
                      Text("Welcome to Intrn", style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 24,
                        ),
                      ),
                      Text("Create your account", style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 24,
                        ),
                      ),
                      SizedBox(height: 8,),
                      Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(16),
                            child: Column(
                              children: [
                                emailBox(),
                                SizedBox(height: 24,),
                                passwordBox(),
                                SizedBox(height: 24,),
                                confirmPasswordBox(),
                                SizedBox(height: 16,),
                                signupButton(),
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 6,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Have an account?",
                            style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 12,
                            ),
                          ),
                          SizedBox(width: 4),
                          GestureDetector(
                            onTap: () {
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(builder: (context) => LoginPage()),
                              // );
                            },
                            child: Text(
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
                      SizedBox(height: 24,),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(48, 0, 48, 0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Divider(
                                color: Colors.black, // Line color
                                thickness: 1, // Line thickness
                                endIndent: 8, // Space between line and text
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
                                color: Colors.black, // Line color
                                thickness: 1, // Line thickness
                                indent: 8, // Space between line and text
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20,),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextField emailBox() {
    return TextField(
      controller: emailController,
      decoration: InputDecoration(
        filled: true,
        fillColor: Color.fromARGB(255, 239, 239, 239),
        hintText: "Email",
        hintStyle: TextStyle(
          fontFamily: "Poppins",
          fontSize: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: BorderSide.none,
        )
      ),
    );
  }

  TextField passwordBox() {
    return TextField(
      controller: passwordController,
      obscureText: isObscure,
      decoration: InputDecoration(
        filled: true,
        fillColor: Color.fromARGB(255, 239, 239, 239),
        hintText: "Password",
        hintStyle: TextStyle(
          fontFamily: "Poppins",
          fontSize: 16,
        ),
        suffixIcon: GestureDetector( 
          onTap: () {
            setState(() {
              isObscure = !isObscure; 
            });
          },
          child: Icon(
            isObscure ? Icons.visibility_off : Icons.visibility,
            color: Colors.grey,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: BorderSide.none,
        )
      ),
    );
  }

  TextField confirmPasswordBox() {
    return TextField(
      controller: confirmPasswordController,
      obscureText: isObscure,
      decoration: InputDecoration(
        filled: true,
        fillColor: Color.fromARGB(255, 239, 239, 239),
        hintText: "Confirm Password",
        hintStyle: TextStyle(
          fontFamily: "Poppins",
          fontSize: 16,
        ),
        suffixIcon: GestureDetector( 
          onTap: () {
            setState(() {
              isObscure = !isObscure; 
            });
          },
          child: Icon(
            isObscure ? Icons.visibility_off : Icons.visibility,
            color: Colors.grey,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: BorderSide.none,
        )
      ),
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
          border: Border.all(color: Color.fromARGB(255, 255, 122, 39), width: 2),
        ),
        alignment: Alignment.center,
        child: Text(
          "Sign up",
          style: TextStyle(
            color: Color.fromARGB(255, 255, 122, 39),
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}

