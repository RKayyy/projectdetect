import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projectssrk/components/quiztype_button.dart';
import 'quiz_page.dart';
import 'package:projectssrk/data/quiz_data.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:projectssrk/pages/result_history_page.dart';

class HomePage extends StatelessWidget {
  dynamic listfromresult;
  bool isFirstAttempt;

  HomePage({Key? key, this.listfromresult})
      : isFirstAttempt = listfromresult == null,
        super(key: key);

  final user = FirebaseAuth.instance.currentUser!;

  // Sign user out method
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  Future<void> getUserID(BuildContext context) async {
    // Retrieve the currently signed-in user
    User? user = FirebaseAuth.instance.currentUser;
    String uid = user?.uid ?? ""; // Fetch the UID
    print("User UID: $uid");

    // Pass the UID to the ResultHistoryPage
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultHistoryPage(uid: uid),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Row(
            children: [
              Text(
                "Welcome to our quizzes!",
                style: TextStyle(fontSize: 20),
              ),
              IconButton(
                onPressed: signUserOut,
                icon: Icon(Icons.logout),
              ),
            ],
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              isFirstAttempt ? "Attempt Quizzes" : "Welcome back!",
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            CarouselSlider(
              items: [
                if (listfromresult != null &&
                    listfromresult['counting'] != null &&
                    listfromresult['counting']!.isNotEmpty)
                  Stack(
                    children: [
                      ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child:
                              Image.asset("lib/images/giraffe_carousel.png")),
                      Positioned(
                        right: 15,
                        top: 15,
                        child: CircularPercentIndicator(
                          radius: 80.0,
                          lineWidth: 10.0,
                          percent: (listfromresult["counting"]
                                      ?.fold(0, (a, b) => a + b) ??
                                  0) /
                              12.5,
                          center: Text(
                            "${((listfromresult["counting"]?.fold(0, (a, b) => a + b) ?? 0) / 12.5 * 100).toStringAsFixed(2)}%",
                            style: TextStyle(fontSize: 16.0),
                          ),
                          progressColor: Colors.blue,
                        ),
                      )
                    ],
                  )
                else
                  Stack(children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.asset("lib/images/giraffe_carousel.png")),
                    Positioned(
                        right: 15,
                        top: 15,
                        child: Text(
                          "Please attempt \nthe counting quiz \nfor your results",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                            shadows: [
                              Shadow(
                                color: Colors.black.withOpacity(0.5),
                                offset: Offset(2.0, 2.0),
                                blurRadius: 5.0,
                              ),
                            ],
                          ),
                        ))
                  ]),
                if (listfromresult != null &&
                    listfromresult['coloring'] != null &&
                    listfromresult['coloring']!.isNotEmpty)
                  Stack(
                    children: [
                      ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child:
                              Image.asset("lib/images/giraffe_carousel.png")),
                      Positioned(
                        right: 15,
                        top: 15,
                        child: CircularPercentIndicator(
                          radius: 80.0,
                          lineWidth: 10.0,
                          percent: (listfromresult["coloring"]
                                      ?.fold(0, (a, b) => a + b) ??
                                  0) /
                              12.5,
                          center: Text(
                            "${((listfromresult["coloring"]?.fold(0, (a, b) => a + b) ?? 0) / 12.5 * 100).toStringAsFixed(2)}%",
                            style: TextStyle(fontSize: 16.0),
                          ),
                          progressColor: Colors.green,
                        ),
                      )
                    ],
                  )
                else
                  Stack(children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.asset("lib/images/giraffe_carousel.png")),
                    Positioned(
                        right: 15,
                        top: 15,
                        child: Text(
                          "Please attempt \nthe coloring quiz \nfor your results",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                            shadows: [
                              Shadow(
                                color: Colors.black.withOpacity(0.5),
                                offset: Offset(2.0, 2.0),
                                blurRadius: 5.0,
                              ),
                            ],
                          ),
                        ))
                  ]),
              ],
              options: CarouselOptions(
                height: 200.0,
                enlargeCenterPage: true,
                autoPlay: true,
                aspectRatio: 16 / 9,
                autoPlayCurve: Curves.fastOutSlowIn,
                enableInfiniteScroll: true,
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                viewportFraction: 0.8,
              ),
            ),
            QuizTypeButton(
              button_color: Colors.pink,
              button_text: "Quiz on Coloring",
              questions: questions_color,
              quizType: 'coloring',
            ),
            QuizTypeButton(
              button_color: Colors.green,
              button_text: 'Quiz on counting',
              questions: questions_count,
              quizType: 'counting',
            ),
            TextButton(
              onPressed: () async {
                await getUserID(context);
              },
              child: Text('Show Result History'),
            ),
          ],
        ),
      ),
    );
  }
}
