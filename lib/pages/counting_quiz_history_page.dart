import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CountResultsPage extends StatelessWidget {
  final Map<String, List<Map<String, dynamic>>> quizResults;
  final int id;
  const CountResultsPage({Key? key, required this.quizResults,required this.id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Filter out the results for quiz ID 2

    final resultsForQuiz2 = quizResults[id] ?? [];

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
                'Counting Quiz',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // Chart for quiz results
            Container(
              height: 252,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
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
            SizedBox(height: 25),
            // ListView for individual attempts
            Center(
              child: Container(
                width: 286,
                height: MediaQuery.of(context).size.height -
                    252 -
                    70 -
                    AppBar().preferredSize.height,
                child: SingleChildScrollView(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: resultsForQuiz2.length,
                    itemBuilder: (context, index) {
                      final result = resultsForQuiz2[index];
                      return Container(
                          height: 80,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 255, 255,
                                255), // Background color for the container
                            borderRadius: BorderRadius.circular(
                                15), // Radius for the curved corners
                          ),
                          child: Stack(
                            children: [
                              Positioned(
                                top: 15,
                                left: 10,
                                child: Container(
                                  height: 20,
                                  width: 95,
                                  decoration: BoxDecoration(
                                    color: Color(
                                        0xFF373737), // Adjusted color value for the first container
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Center(
                                      child: Text(
                                    'Attempt ${index + 1}',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  )),
                                ),
                              ),
                              Positioned(
                                top:
                                    15, // Adjust this value as needed to separate the two containers
                                left: 150,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Color(
                                        0xFFF8E191), // Adjusted color value for the second container
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                        'Average Result:\n ${result['average_result']}'),
                                  ),
                                ),
                              ),
                              Positioned(
                                  top: 45,
                                  left: 10,
                                  child: Text("Date: \nTime: "))
                            ],
                          ));
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
