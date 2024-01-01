import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:convert'; // For JSON encoding

class QuizResultPage extends StatelessWidget {
  final List<double> userAnswers;

  const QuizResultPage({Key? key, required this.userAnswers}) : super(key: key);

  Future<void> sendQuizResults(List<double?> userAnswers) async {
    try {
    final response = await http.post(
      Uri.parse('http://127.0.0.1:5000/predict'), // Replace with your Flask backend URL
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'counting_input': userAnswers,
        'color_input': userAnswers,
      }),
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      // Parse the response and handle the prediction as needed
      Map<String, dynamic> data = json.decode(response.body);
      double prediction = data['prediction'];
      print('Prediction: $prediction');
    } else {
      throw Exception('Failed to submit quiz results');
    }
  } catch (e) {
    print('Error from quiz_result_page.dart: $e');
  }
  }



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
              onPressed: () async {
                await sendQuizResults(userAnswers);
                Navigator.popUntil(context, ModalRoute.withName('/')); // Go back to home page
              },
              child: Text('Submit Quiz Results'),
            ),
          ],
        ),
      ),
    );
  }
}
