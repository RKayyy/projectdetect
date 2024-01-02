import 'package:flutter/material.dart';
import '../models/question.dart';
import 'quiz_result_page.dart'; // New screen for quiz result

import 'package:projectssrk/models/answers.dart';

class QuizPage extends StatefulWidget {
  final List<Question> questions;
  final String quizType;

  const QuizPage({Key? key, required this.questions, required this.quizType}) : super(key: key);

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int currentQuestionIndex = 0;
  
  void checkAnswer(int selectedOptionIndex) {
    double weight = widget.questions[currentQuestionIndex].weight;
    bool isCorrect = (selectedOptionIndex == widget.questions[currentQuestionIndex].correctAnswerIndex);

    setState(() {
      if (widget.quizType == 'counting') {
        if(userAnswers['counting']?.length == 5){
          userAnswers['counting'] = [];
        }
        userAnswers['counting']?.add(isCorrect ? weight : 0.0);
        
      } else if (widget.quizType == 'coloring') {
        if(userAnswers['coloring']?.length == 5){
          userAnswers['coloring'] = [];
        }
        userAnswers['coloring']?.add(isCorrect ? weight : 0.0);
        
      }

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
            Transform.scale(
              scale: 1.25,
              child: Image.asset(
                widget.questions[currentQuestionIndex].questionText,
                width: 200, // Adjust the width as needed
                height: 200, // Adjust the height as needed
              ),
            ),
            SizedBox(height: 40.0),
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
