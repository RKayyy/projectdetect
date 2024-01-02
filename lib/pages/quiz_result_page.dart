import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:convert'; // For JSON encoding

class QuizResultPage extends StatelessWidget {
  final Map<String, List<double>> userAnswers;

  const QuizResultPage({Key? key, required this.userAnswers}) : super(key: key);

  Future<void> sendQuizResults(Map<String, List<double>> userAnswers) async {
    try {
      final response = await http.post(
        Uri.parse(
            'http://127.0.0.1:5000/predict'), // Replace with your Flask backend URL
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'counting_input': userAnswers['counting'],
          'color_input': userAnswers['coloring'],
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
              'your answers are: $userAnswers',
            ),
            SizedBox(height: 20.0),
            (userAnswers['counting'] != null &&
                    userAnswers['coloring'] != null &&
                    userAnswers['counting']!.isNotEmpty &&
                    userAnswers['coloring']!.isNotEmpty)
                ? ElevatedButton(
                    onPressed: () async {
                      if (userAnswers['counting'] != null &&
                          userAnswers['coloring'] != null &&
                          userAnswers['counting']!.isNotEmpty &&
                          userAnswers['coloring']!.isNotEmpty) {
                        await sendQuizResults(userAnswers);
                        Navigator.popUntil(context,
                            ModalRoute.withName('/')); // Go back to home page
                      } else {
                        // Display a message or handle the case where one or both lists are null
                        print('Please answer all questions before submitting.');
                      }
                    },
                    child: Text('Submit Quiz Results'),
                  )
                : ElevatedButton(
                    onPressed: () async {
                      
                        Navigator.popUntil(context,
                            ModalRoute.withName('/')); // Go back to home page
                      
                    },
                    child: Text('Go to Home'),
                  ),
          ],
        ),
      ),
    );
  }
}
