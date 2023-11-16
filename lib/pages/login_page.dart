import 'package:flutter/material.dart';
import 'package:projectssrk/components/my_button.dart';
import 'package:projectssrk/components/my_textfield.dart';
import 'package:projectssrk/components/square_tile.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  //text editing controllers
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();


  // sign user in method(function for onTap property and onTap prop for my_button)
  void signUserIn() {

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 50,),

            //logo
            const Icon(
              Icons.lock,
              size: 100,
            ),

            const SizedBox(height: 50),

            //welcome back, you;ve been missed
            Text(
              "Welcome back, you've been missed1",
              style: TextStyle(
                color: Colors.grey.shade700,
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 25),

            //username textfield
            MyTextField(
              controller: usernameController,
              hintText: 'Username',
              obscureText: false,
            ),

            const SizedBox(height: 10,),

            //password textfield
            MyTextField(
              controller: passwordController,
              hintText: 'Password',
              obscureText: true,
            ),

            const SizedBox(height: 10,),

            //forgot password
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Forgot Password?',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            //sign in button
            MyButton(
              onTap: signUserIn,
            ),

            const SizedBox(height: 50),

            //or continue with
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                children: [
                  Expanded(
                    child: Divider(
                      thickness: 0.5,
                      color: Colors.grey[400],
                    ),
                  ),
            
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(
                      'Or continue with',
                    style: TextStyle(
                      color: Colors.grey[400],
                      ),
                    ),
                  ),
            
                  Expanded(
                    child: Divider(
                      thickness: 0.5,
                      color: Colors.grey[400],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 50,),

            //google sign in buttons
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SquareTile(imagePath: 'lib/images/google.png')
              ],
            ),

            const SizedBox(height: 50,),

            //not a member? register here
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Not a member",
                  style: TextStyle(color: Colors.grey[700]),
                ),
                const SizedBox(width: 4,),
                const Text(
                  "Register now",
                  style: TextStyle(
                    color: Colors.blue, fontWeight: FontWeight.bold
                  ),
                )
              ],
            )



          ],
        ));
  }
}
