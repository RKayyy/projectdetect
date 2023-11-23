import 'package:flutter/material.dart';
import 'package:projectssrk/pages/quiz_page.dart';
import 'package:projectssrk/data/quiz_data.dart';

class QuizTypeButton extends StatelessWidget {
  final String button_text;
  final Color button_color;

  const QuizTypeButton(
      {super.key, required this.button_color, required this.button_text});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Container(
          height: 120,
          decoration: BoxDecoration(
            borderRadius:
                BorderRadius.circular(10), // Customize the button color
          ),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: button_color, // Change the button color here
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
              style: TextStyle(color: Colors.white, fontSize: 20), // Text color
            ),
          ),
        ),
      ),
    );
  }
}
