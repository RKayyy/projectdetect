import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // For JSON encoding

class QuizResultPage extends StatefulWidget {
  final Map<String, List<double>> userAnswers;

  const QuizResultPage({Key? key, required this.userAnswers}) : super(key: key);

  @override
  _QuizResultPageState createState() => _QuizResultPageState();
}

class _QuizResultPageState extends State<QuizResultPage> {
  double? prediction;
  bool quizSubmitted = false; // Track whether quiz answers have been submitted

  Future<void> sendQuizResults(Map<String, List<double>> userAnswers) async {
    try {
      final response = await http.post(
        Uri.parse('http://127.0.0.1:5000/predict'), // Replace with your Flask backend URL
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
        double newPrediction = data['prediction'];
        print('Prediction: $newPrediction');

        // Update the state to trigger a UI refresh with the new prediction
        setState(() {
          prediction = newPrediction;
          quizSubmitted = true; // Mark the quiz as submitted
        });
      } else {
        throw Exception('Failed to submit quiz results');
      }
    } catch (e) {
      print('Error from quiz_result_page.dart: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    int totalQuestions = widget.userAnswers.length;

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
              'Your answers are: ${widget.userAnswers}',
            ),
            SizedBox(height: 20.0),
            (widget.userAnswers['counting'] != null &&
                    widget.userAnswers['coloring'] != null &&
                    widget.userAnswers['counting']!.isNotEmpty &&
                    widget.userAnswers['coloring']!.isNotEmpty)
                ? Column(
                    children: [
                      quizSubmitted
                          ? Container()
                          : ElevatedButton(
                              onPressed: () async {
                                if (widget.userAnswers['counting'] != null &&
                                    widget.userAnswers['coloring'] != null &&
                                    widget.userAnswers['counting']!.isNotEmpty &&
                                    widget.userAnswers['coloring']!.isNotEmpty) {
                                  await sendQuizResults(widget.userAnswers);
                                  // No need to navigate back immediately, as the "Go to Home" button will appear
                                } else {
                                  // Display a message or handle the case where one or both lists are null
                                  print('Please answer all questions before submitting.');
                                }
                              },
                              child: Text('Submit Quiz Results'),
                            ),
                      SizedBox(height: 20.0),
                      quizSubmitted
                          ? ElevatedButton(
                              onPressed: () async {
                                Navigator.popUntil(
                                    context, ModalRoute.withName('/'));
                              },
                              child: Text('Go to Home'),
                            )
                          : Container(),
                      SizedBox(height: 20.0),
                      prediction != null
                          ? Text('Prediction: $prediction')
                          : Container(),
                    ],
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
