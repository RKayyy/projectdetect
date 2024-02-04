import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AudioToTextPage(),
    );
  }
}

class AudioToTextPage extends StatefulWidget {
  @override
  _AudioToTextPageState createState() => _AudioToTextPageState();
}

class _AudioToTextPageState extends State<AudioToTextPage> {
  // stt.SpeechToText _speech;
  stt.SpeechToText _speech = stt.SpeechToText();

  bool _isListening = false;
  String _text = '';
  List<String> _answers = [];
  String _currentWord = 'book'; // Change this to the correct word
  int _score = 0;

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
    _answers = []; // Resetting the answers list on initialization
  }

  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize();
      if (available) {
        _speech.listen(
          onResult: (result) {
            setState(() {
              _text = result.recognizedWords;
            });
          },
        );
        setState(() {
          _isListening = true;
        });
        Future.delayed(Duration(seconds: 10), () {
          _evaluateAnswer();
          _speech.stop();
        });
      }
    }
  }

  void _evaluateAnswer() {
    String answer = _text.toLowerCase();
    if (answer == _currentWord) {
      _score++;
    }
    _answers.add(answer);
    print('Child\'s Answers: $_answers');
    setState(() {
      _isListening = false;
      _text = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Audio to Text Quiz'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Score: $_score',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            Image.asset(
              'lib/images/book.png', // Change this to your image path
              width: 200,
              height: 200,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isListening ? null : _listen,
              child: Text(_isListening ? 'Listening...' : 'Start Listening'),
            ),
          ],
        ),
      ),
    );
  }
}
