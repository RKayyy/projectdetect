import 'package:flutter/material.dart';
import '../models/question.dart';
import 'quiz_result_page.dart'; // New screen for quiz result

import 'package:projectssrk/models/answers.dart';

class QuizPage extends StatefulWidget {
  final List<Question> questions;
  final String quizType;

  const QuizPage({Key? key, required this.questions, required this.quizType})
      : super(key: key);

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int currentQuestionIndex = 0;
  late List<Question> shuffledQuestions;
  List<int> shuffledQuestionIds = [];

  @override
  void initState() {
    super.initState();
    shuffledQuestions = List.from(widget.questions)..shuffle();
    shuffledQuestionIds =
        shuffledQuestions.map((question) => question.questionid).toList();
    print(shuffledQuestionIds);
  }

  void checkAnswer(int selectedOptionIndex) {
    double weight = widget.questions[currentQuestionIndex].weight;
    bool isCorrect = (selectedOptionIndex ==
        shuffledQuestions[currentQuestionIndex].correctAnswerIndex);

    setState(() {
      if (widget.quizType == 'counting') {
        if (userAnswers['counting']?.length == 5) {
          userAnswers['counting'] = [];
        }
        userAnswers['counting']?.add(isCorrect ? 1.0 : 0.0);
      } else if (widget.quizType == 'coloring') {
        if (userAnswers['coloring']?.length == 5) {
          userAnswers['coloring'] = [];
        }
        userAnswers['coloring']?.add(isCorrect ? 1.0 : 0.0);
      } else if (widget.quizType == 'calculate') {
        if (userAnswers['calculate']?.length == 5) {
          userAnswers['calculate'] = [];
        }
        userAnswers['calculate']?.add(isCorrect ? 1.0 : 0.0);
      }

      if (currentQuestionIndex < shuffledQuestions.length - 1) {
        currentQuestionIndex++;
      } else {
        // Quiz ended, navigate to result page
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => QuizResultPage(
              userAnswers: userAnswers,
              quizType: widget.quizType,
              questionids: shuffledQuestionIds,
            ),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF6F6F6), // Background color
        title: Text('Result History'),
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('lib/images/background.png'), // Image asset
              fit:
                  BoxFit.cover, // Adjusts the image to cover the entire app bar
              colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.1), // 10% opacity (90% transparent)
                BlendMode.dstATop, // Apply the opacity to the image
              ),
            ),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('lib/images/background.png'), // Image asset
            fit: BoxFit.cover, // Adjusts the image to cover the entire app bar
            colorFilter: ColorFilter.mode(
              Colors.white.withOpacity(0.1), // 10% opacity (90% transparent)
              BlendMode.dstATop, // Apply the opacity to the image
            ),
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Transform.scale(
                scale: 1.25,
                child: Image.asset(
                  shuffledQuestions[currentQuestionIndex].questionText,
                  width: 200, // Adjust the width as needed
                  height: 200, // Adjust the height as needed
                ),
              ),
              SizedBox(height: 40.0),
              Column(
                children: List.generate(
                  shuffledQuestions[currentQuestionIndex].options.length,
                  (index) => Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: ElevatedButton(
                      onPressed: () => checkAnswer(index),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Color(0xFFEBC272), // Button color EBC272
                        minimumSize:
                            Size(270, 45), // Button width 270 and height 45
                      ),
                      child: Text(
                        shuffledQuestions[currentQuestionIndex].options[index],
                        style: TextStyle(color: Colors.black, fontSize: 25),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
