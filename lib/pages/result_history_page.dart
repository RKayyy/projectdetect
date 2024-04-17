import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import 'package:projectssrk/pages/counting_quiz_history_page.dart';

class ResultHistoryPage extends StatefulWidget {
  final String uid;

  ResultHistoryPage({required this.uid});

  @override
  _ResultHistoryPageState createState() => _ResultHistoryPageState();
}

class _ResultHistoryPageState extends State<ResultHistoryPage> {
  List<Map<String, dynamic>> results = [];
  List<Map<String, dynamic>> predictions = [];

  @override
  void initState() {
    super.initState();
    fetchResultsAndPredictions();
  }

  Future<void> fetchResultsAndPredictions() async {
    await fetchResults();
    await fetchPredictions();
  }

  Future<void> fetchPredictions() async {
    final response = await http
        .get(Uri.parse('http://127.0.0.1:5566/prediction_table/${widget.uid}'));

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      if (jsonResponse.containsKey('predictions')) {
        setState(() {
          predictions =
              List<Map<String, dynamic>>.from(jsonResponse['predictions']);
          print(predictions);
        });
      } else {
        print('Predictions key not found in the response');
      }
    } else {
      print('Failed to fetch predictions');
    }
  }

  Future<void> fetchResults() async {
    final response = await http
        .get(Uri.parse('http://127.0.0.1:5566/result_history/${widget.uid}'));

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      if (jsonResponse.containsKey('results')) {
        setState(() {
          results = List<Map<String, dynamic>>.from(jsonResponse['results']);
          print(results);
        });
      } else {
        print('Results key not found in the response');
      }
    } else {
      print('Failed to fetch result history');
    }
  }

  Map<String, List<Map<String, dynamic>>> groupResultsByQuiz() {
    Map<String, List<Map<String, dynamic>>> groupedResults = {};

    for (var result in results) {
      final quizId = result['quiz_id'].toString();
      if (!groupedResults.containsKey(quizId)) {
        groupedResults[quizId] = [];
      }
      groupedResults[quizId]!.add(result);
    }

    return groupedResults;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF6F6F6), // Background color
        title: Text('Result History'),
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
          color: Color(0xFFF6F6F6), // Background color
          image: DecorationImage(
            image: AssetImage('lib/images/background.png'), // Image asset
            fit:
                BoxFit.cover, // Adjusts the image to cover the entire container
            colorFilter: ColorFilter.mode(
              Colors.white.withOpacity(0.1), // 10% opacity (90% transparent)
              BlendMode.dstATop, // Apply the opacity to the image
            ),
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: 20),
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(
                  left: 50, top: 16, bottom: 16), // Padding from the left side
              child: Text(
                'Predictions',
                style: TextStyle(
                  fontSize: 32, // Font size
                  fontFamily: 'Assistant', // Font family
                ),
              ),
            ),
            if (predictions.isNotEmpty)
              Container(
                width: 400, // Set the width to 310 pixels
                decoration: BoxDecoration(
                  color: Colors.white, // White background color
                  borderRadius:
                      BorderRadius.circular(14), // Rounded edges with radius 14
                  boxShadow: [
                    // Add a shadow for a more pronounced effect
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3), // Shadow color
                      spreadRadius: 2, // Spread radius
                      blurRadius: 5, // Blur radius
                      offset: Offset(0, 3), // Shadow offset
                    ),
                  ],
                ),
                child: SfCartesianChart(
                  primaryXAxis:
                      CategoryAxis(title: AxisTitle(text: 'Prediction')),
                  primaryYAxis: NumericAxis(title: AxisTitle(text: 'Value')),
                  series: [
                    LineSeries<Map<String, dynamic>, String>(
                      dataSource: predictions,
                      xValueMapper: (prediction, _) =>
                          'Prediction ${predictions.indexOf(prediction) + 1}',
                      yValueMapper: (prediction, _) =>
                          prediction['predicted_values'],
                      markerSettings: MarkerSettings(
                        isVisible: true,
                      ),
                    ),
                  ],
                ),
              ),

            SizedBox(height: 35),
            Text(
              'Your results are like stepping stones in \nthe playful garden of knowledge. Keep leaping, \nlittle explorer!',
              textAlign: TextAlign.center, // Align text to the left
              style: TextStyle(
                fontSize: 14, // Font size 14
                fontFamily: 'Assistant', // Font family "Assistant"
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CountResultsPage(
                      quizResults: groupResultsByQuiz(),
                      id: 2,
                    ),
                  ),
                ); // Go back to the home page
              },
              style: ElevatedButton.styleFrom(
                fixedSize: Size(270, 46),
                backgroundColor: Color(0xFFEBC272), // Button color
              ),
              child: Text(
                'Counting Quiz',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24, // Text size 24
                  fontWeight: FontWeight.bold, // Bold text
                ),
              ),
            ),
            SizedBox(height: 15), // Spacer for second button
            ElevatedButton(
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CountResultsPage(
                      quizResults: groupResultsByQuiz(),
                      id: 1,
                    ),
                  ),
                ); // Go back to the home page
              },
              style: ElevatedButton.styleFrom(
                fixedSize: Size(270, 46),
                backgroundColor: Color(0xFFEBC272), // Button color
              ),
              child: Text(
                'Coloring Quiz',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24, // Text size 24
                  fontWeight: FontWeight.bold, // Bold text
                ),
              ),
            ),
            SizedBox(height: 15), // Spacer for third button
            ElevatedButton(
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CountResultsPage(
                      quizResults: groupResultsByQuiz(),
                      id: 3,
                    ),
                  ),
                ); // Go back to the home page
              },
              style: ElevatedButton.styleFrom(
                fixedSize: Size(270, 46),
                backgroundColor: Color(0xFFEBC272), // Button color
              ),
              child: Text(
                'Calculating Quiz',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24, // Text size 24
                  fontWeight: FontWeight.bold, // Bold text
                ),
              ),
            ),
            // ListView for quiz results
          ],
        ),
      ),
    );
  }
}
