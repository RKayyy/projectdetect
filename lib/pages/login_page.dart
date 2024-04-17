import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:projectssrk/components/my_button.dart';
import 'package:projectssrk/components/my_textfield.dart';
import 'package:projectssrk/components/square_tile.dart';
import 'package:projectssrk/pages/home_page.dart';
import 'package:projectssrk/pages/register_page.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  LoginPage({super.key, this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //text editing controllers
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  // sign user in method(function for onTap property and onTap prop for my_button)
  void signUserIn() async {
    //show loading circle
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });

    //try signin
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      //pop the circle
      Navigator.pop(context);
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                HomePage()), // Replace 'RegisterPage' with the actual name of your register page class
      );
    } on FirebaseAuthException catch (e) {
      //pop the circle
      Navigator.pop(context);
      //show error message
      showErrorMessage(e.code);
    }
  }

  //show error message
  void showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Center(
            child: Text(
              message,
              style: const TextStyle(color: Colors.black),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFEBC272),
        image: DecorationImage(
          image: AssetImage('lib/images/background.png'),
          fit: BoxFit.fill,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: SafeArea(
            child: Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(0.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 180,
                    ),
                    Container(
                      width: screenWidth,
                      padding: EdgeInsets.fromLTRB(0, 30, 0, 30.0),
                      decoration: BoxDecoration(
                        color: Color(0xFFEBC272),
                        
                        border: Border.all(color: Colors.white),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(width: 50),
                          Row(
                            children: [
                              const SizedBox(width: 30),
                              Image.asset(
                                'lib/images/App_logo.png',
                                width: 75, // Adjust the width as needed
                                height: 75, // Adjust the height as needed
                              ),
                              const SizedBox(width: 20),
                              Text(
                                'CountCandy',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 43,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(25, 0, 0, 0),
                            child: Text(
                              'Login',
                              style: TextStyle(
                                color: const Color.fromARGB(255, 23, 0, 0),
                                fontSize: 33,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          MyTextField(
                            controller: emailController,
                            hintText: 'Email',
                            obscureText: false,
                          ),
                          const SizedBox(height: 10),
                          MyTextField(
                            controller: passwordController,
                            hintText: 'Password',
                            obscureText: true,
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                'Forgot Password?',
                                style: TextStyle(color: Colors.grey[600]),
                              ),
                            ],
                          ),
                          const SizedBox(height: 25),
                          MyButton(
                            text: "Sign In",
                            onTap: signUserIn,
                          ),
                          const SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Not a member?",
                                style: TextStyle(color: Colors.grey[700]),
                              ),
                              const SizedBox(width: 4),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => RegisterPage(),
                                    ),
                                  );
                                },
                                child: const Text(
                                  "Register now",
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
