import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projectssrk/pages/login_page.dart';
import 'package:projectssrk/pages/home_page.dart';
import 'package:projectssrk/pages/login_or_register_page.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  //page to check if the user is signed in or not, if signed in: homepage, if not signed in: login page
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //stream that constantly listens if the user has logged in or not
        body: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              //user is logged in
              if (snapshot.hasData) {
                return HomePage();
              }

              //user is not logged in
              else {
                return LoginOrRegisterPage();
              }
            }));
  }
}
