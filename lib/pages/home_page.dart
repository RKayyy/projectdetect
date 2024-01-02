import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projectssrk/components/quiztype_button.dart';
import 'quiz_page.dart';
import 'package:projectssrk/data/quiz_data.dart';
import 'package:projectssrk/models/answers.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final user = FirebaseAuth.instance.currentUser!;

  //sign user out method
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        Row(
          children: [
            Text(
              "Welcome to our quizzes!",
              style: TextStyle(fontSize: 20),
            ),
            IconButton(
              onPressed: signUserOut,
              icon: Icon(Icons.logout),
            ),
          ],
        )
      ]),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            QuizTypeButton(
              button_color: Colors.pink,
              button_text: 'Quiz on coloring',
              questions: questions_color,
              quizType: 'coloring',
            ),
            QuizTypeButton(
              button_color: Colors.green,
              button_text: 'Quiz on counting',
              questions: questions_count,
              quizType: 'counting'
            ),
          ],
        ),
      ),
    );
  }
}
