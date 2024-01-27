import 'package:flutter/material.dart';
import 'package:projectssrk/pages/quiz_page.dart';
import 'package:projectssrk/data/quiz_data.dart';
import 'package:projectssrk/models/question.dart';

class QuizTypeButton extends StatelessWidget {
  final List<Question> questions; // New parameter to hold the questions
  final String quizType;
  final String backgroundImage;

  const QuizTypeButton({
    Key? key,
    required this.questions, // Updated constructor to take questions
    required this.quizType,
    required this.backgroundImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.5, horizontal: 20),
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
          width:
              double.infinity, // Make sure the Container takes the full width
          height: 120, // Set the height as needed
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(backgroundImage),
              fit: BoxFit.cover,
            ),
            borderRadius:
                BorderRadius.circular(20), // Match the button's border radius
          ),
        ),
      ),
    );
  }
}
