import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CountResultsPage extends StatelessWidget {
  final Map<String, List<Map<String, dynamic>>> quizResults;

  const CountResultsPage({Key? key, required this.quizResults})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Filter out the results for quiz ID 2
    final resultsForQuiz2 = quizResults['2'] ?? [];

    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz Results'),
        backgroundColor: Color(0xFFF6F6F6), // Background color for app bar
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Color(0xFFF6F6F6), // Background color for container
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Quiz 2',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // Chart for quiz results
            Container(
              height: 252,
              color: Colors.white,
              child: SfCartesianChart(
                primaryXAxis: CategoryAxis(title: AxisTitle(text: 'Attempt')),
                primaryYAxis:
                    NumericAxis(title: AxisTitle(text: 'Average Score')),
                series: [
                  LineSeries<Map<String, dynamic>, int>(
                    dataSource: resultsForQuiz2,
                    xValueMapper: (result, index) => index + 1,
                    yValueMapper: (result, _) => result['average_result'],
                    name: 'Counting Quiz',
                    markerSettings: MarkerSettings(
                      isVisible: true,
                    ),
                  ),
                ],
              ),
            ),
            // ListView for individual attempts
            Center(
              child: Container(
                width: 80,
                height: 500,
                child: SingleChildScrollView(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: resultsForQuiz2.length,
                    itemBuilder: (context, index) {
                      final result = resultsForQuiz2[index];
                      return Container(
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 247, 131,
                              131), // Background color for the container
                          borderRadius: BorderRadius.circular(
                              15), // Radius for the curved corners
                        ),
                        child: ListTile(
                          minLeadingWidth: 100,
                          title: Text('Attempt ${index + 1}'),
                          subtitle: Text(
                              'Average Result: ${result['average_result']}'),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
