import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AudioQuiz extends StatefulWidget {
  @override
  _AudioQuizState createState() => _AudioQuizState();
}

class _AudioQuizState extends State<AudioQuiz> {
  final TextEditingController _answerController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Audio Quiz'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 120,),
                // First image
                Transform.scale(
                  scale: 2,
                  child: Image.asset(
                    'lib/images/Cat.png', // Replace with your image asset path
                    height: 100,
                    width: 100,
                  ),
                ),
                SizedBox(height: 50),
                // Label
                Text(
                  'Cat',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 50),
                // Second image
                Transform.scale(
                  scale: 2,
                  child: Image.asset(
                    'lib/images/Bat.png', // Replace with your image asset path
                    height: 100,
                    width: 100,
                  ),
                ),
                SizedBox(height: 80),
                // Input field
                TextField(
                  controller: _answerController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter your answer',
                  ),
                ),
                SizedBox(height: 50),
                // Submit button
                ElevatedButton(
                  onPressed: () {
                    String userAnswer = _answerController.text;
                    // Handle the user's answer (e.g., check if it is correct)
                    // For now, just print it to the console
                    print('User answer: $userAnswer');
                  },
                  child: Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
