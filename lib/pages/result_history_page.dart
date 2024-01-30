import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class ResultHistoryPage extends StatefulWidget {
  final String uid;

  ResultHistoryPage({required this.uid});

  @override
  _ResultHistoryPageState createState() => _ResultHistoryPageState();
}

class _ResultHistoryPageState extends State<ResultHistoryPage> {
  List<Map<String, dynamic>> results = [];

  @override
  void initState() {
    super.initState();
    fetchResults();
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
        // Handle the case where the 'results' key is not present in the response
        print('Results key not found in the response');
      }
    } else {
      // Handle error
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
        title: Text('Result History'),
      ),
      body: ListView.builder(
        itemCount: groupResultsByQuiz().length,
        itemBuilder: (context, index) {
          final entry = groupResultsByQuiz().entries.toList()[index];
          final quizId = entry.key;
          final quizResults = entry.value;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Quiz $quizId',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              SfCartesianChart(
                primaryXAxis: CategoryAxis(title: AxisTitle(text: 'Attempt')),
                primaryYAxis:
                    NumericAxis(title: AxisTitle(text: 'Average Score')),
                series: [
                  LineSeries<Map<String, dynamic>, int>(
                    dataSource: quizResults,
                    xValueMapper: (result, _) =>
                        quizResults.indexOf(result) + 1,
                    yValueMapper: (result, _) => result['average_result'],
                    name: 'Quiz $quizId',
                    markerSettings: MarkerSettings(
                      isVisible: true,
                    ),
                  ),
                ],
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: quizResults.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('Attempt ${index + 1}'),
                    subtitle: Text(
                        'Average Result: ${quizResults[index]['average_result']}'),
                    // Add more details or customize as needed
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
