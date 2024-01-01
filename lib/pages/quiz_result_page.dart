import 'package:flutter/material.dart';

class QuizResultPage extends StatelessWidget {
  final List<double> userAnswers;

  const QuizResultPage({Key? key, required this.userAnswers}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int correctAnswers = userAnswers.where((answer) => answer == true).length;
    int totalQuestions = userAnswers.length;

    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz Result'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Quiz has ended!',
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(height: 20.0),
            Text(
              'You answered $correctAnswers out of $totalQuestions questions correctly.',
              style: TextStyle(fontSize: 18.0),
              textAlign: TextAlign.center,
            ),
            Text(
              'your answers are: $userAnswers',
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                Navigator.popUntil(context, ModalRoute.withName('/')); // Go back to home page
              },
              child: Text('Back to Home'),
            ),
          ],
        ),
      ),
    );
  }
}
