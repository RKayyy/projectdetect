import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projectssrk/pages/quiz_page.dart';
import 'package:projectssrk/data/quiz_data.dart';
import 'package:projectssrk/models/question.dart';

class QuizTypeButton extends StatelessWidget {
  final String button_text;
  final Color button_color;
  final List<Question> questions;
  final String quizType;
  final String buttonImage;

  const QuizTypeButton({
    Key? key,
    required this.button_color,
    required this.button_text,
    required this.questions,
    required this.quizType,
    required this.buttonImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: 150,
        height: 150,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.zero,
            backgroundColor: button_color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            shadowColor: Colors.black, // Set the shadow color
            elevation: 12, // Set the elevation
            // Define the box shadow
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 26,
                width: 110,
                decoration: BoxDecoration(
                  color: Color(0xFF373737),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    button_text,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      fontFamily: AutofillHints.birthday,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(height: 25), // Adjust the spacing between the text and image
              Transform.scale(
                scale: 1.75,
                child: Image.asset(
                  buttonImage,
                  height: 40, // Adjust the height of the image as needed
                ),
              ),
              SizedBox(height: 15)
            ],
          ),
        ),
      ),
    );
  }
}
