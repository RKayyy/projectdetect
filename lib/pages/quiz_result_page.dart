import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:projectssrk/pages/home_page.dart'; // For JSON encoding

class QuizResultPage extends StatefulWidget {
  final Map<String, List<double>> userAnswers;
  final String quizType;
  const QuizResultPage(
      {Key? key, required this.userAnswers, required this.quizType})
      : super(key: key);

  @override
  _QuizResultPageState createState() => _QuizResultPageState();
}

class _QuizResultPageState extends State<QuizResultPage> {
  double? prediction;
  bool quizSubmitted = false;
  

  Future<void> sendQuizResults(Map<String, List<double>> userAnswers) async {
    try {
      final response = await http.post(
        Uri.parse('http://127.0.0.1:5566/predict'), // Replace with your Flask backend URL
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
              (widget.quizType == 'counting')
                  ? 'Your total score for counting questions is ${
                    ((widget.userAnswers['counting']!.fold(0.0, (sum, score) => sum + score)/12.5)*100).toString()
                    } % '
                  : 'Your total score for coloring questions is ${
                    ((widget.userAnswers['coloring']!.fold(0.0, (sum, score) => sum + score)/12.5)*100).toString()
                    } %',
              style: TextStyle(fontSize: 16.0),
            ),
            Text(
            'Your answers are: ${widget.userAnswers}',
            ),

            SizedBox(height: 20.0),
            (widget.userAnswers['counting'] != null &&
                    widget.userAnswers['coloring'] != null &&
                    widget.userAnswers['counting']!.isNotEmpty &&
                    widget.userAnswers['coloring']!.isNotEmpty)
                ? ElevatedButton(
                    onPressed: () async {
                      if (widget.userAnswers['counting'] != null &&
                          widget.userAnswers['coloring'] != null &&
                          widget.userAnswers['counting']!.isNotEmpty &&
                          widget.userAnswers['coloring']!.isNotEmpty) {
                        await sendQuizResults(widget.userAnswers);
                        // ignore: use_build_context_synchronously
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomePage(
                              listfromresult: widget.userAnswers,
                            ),
                          ),
                        ); // Go back to home page
                      } else {
                        // Display a message or handle the case where one or both lists are null
                        print('Please answer all questions before submitting.');
                      }
                    },
                    child: Text('Submit Quiz Results'),
                  )
                : ElevatedButton(
                    onPressed: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomePage(
                            listfromresult: widget.userAnswers,
                          ),
                        ),
                      ); // Go back to home page
                    },
                    child: Text('Go to Home'),
                  ),
          ],
        ),
      ),
    );
  }
}