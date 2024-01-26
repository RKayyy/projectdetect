import 'package:flutter/material.dart';
import 'package:projectssrk/pages/quiz_page.dart';
import 'package:projectssrk/data/quiz_data.dart';
import 'package:projectssrk/models/question.dart';

class QuizTypeButton extends StatelessWidget {
  final String button_text;
  final List<Question> questions; // New parameter to hold the questions
  final String quizType;
  final String backgroundImage;

  const QuizTypeButton({
    Key? key,
    required this.button_text,
    required this.questions, // Updated constructor to take questions
    required this.quizType,
    required this.backgroundImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          minimumSize:
              Size(double.infinity, 120), // Set minimum size to take full width
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  QuizPage(questions: questions, quizType: quizType),
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(backgroundImage),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Text(
              button_text,
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ),
      ),
    );
  }
}
