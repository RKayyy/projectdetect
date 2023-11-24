import 'package:flutter/material.dart';
import 'package:projectssrk/pages/quiz_page.dart';
import 'package:projectssrk/data/quiz_data.dart';

class QuizTypeButton extends StatelessWidget {
  final String button_text;
  final Color button_color;

  const QuizTypeButton({
    Key? key,
    required this.button_color,
    required this.button_text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          minimumSize: Size(double.infinity, 120), // Set minimum size to take full width
          backgroundColor: button_color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => QuizPage(questions: questions_spell),
            ),
          );
        },
        child: Text(
          button_text,
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    );
  }
}
