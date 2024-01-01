import 'package:flutter/material.dart';
import '../models/question.dart';
import 'quiz_result_page.dart'; // New screen for quiz result

class QuizPage extends StatefulWidget {
  final List<Question> questions;

  const QuizPage({Key? key, required this.questions}) : super(key: key);

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int currentQuestionIndex = 0;
  List<double> userAnswers = []; // List to store user answers

  void checkAnswer(int selectedOptionIndex) {
    double weight = widget.questions[currentQuestionIndex].weight;
    bool isCorrect = (selectedOptionIndex == widget.questions[currentQuestionIndex].correctAnswerIndex);

    setState(() {
      userAnswers.add(isCorrect ? weight : 0.0);
      if (currentQuestionIndex < widget.questions.length - 1) {
        currentQuestionIndex++;
      } else {
        // Quiz ended, navigate to result page
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => QuizResultPage(userAnswers: userAnswers),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              widget.questions[currentQuestionIndex].questionText,
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(height: 20.0),
            Column(
              children: List.generate(
                widget.questions[currentQuestionIndex].options.length,
                (index) => Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: ElevatedButton(
                    onPressed: () => checkAnswer(index),
                    child: Text(widget.questions[currentQuestionIndex].options[index]),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
