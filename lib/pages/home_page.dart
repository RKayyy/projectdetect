import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projectssrk/components/my_button.dart';
import 'package:projectssrk/components/quiztype_button.dart';
import 'package:projectssrk/pages/login_page.dart';
import 'quiz_page.dart';
import 'package:projectssrk/data/quiz_data.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:projectssrk/pages/result_history_page.dart';
import 'package:projectssrk/pages/profile_page.dart'; // Import the ProfilePage
import 'package:projectssrk/pages/login_page.dart';
import 'package:projectssrk/pages/login_page.dart';
import 'package:projectssrk/pages/profile_page.dart';

class HomePage extends StatelessWidget {
  dynamic listfromresult;
  bool isFirstAttempt;

  HomePage({Key? key, this.listfromresult})
      : isFirstAttempt = listfromresult == null,
        super(key: key);

  final user = FirebaseAuth.instance.currentUser!;

  // Sign user out method
  void signUserOut(BuildContext context) {
    FirebaseAuth.instance.signOut();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LoginPage(),
      ),
    );
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
      body: Container(
        color: Color(0xFFF6F6F6),
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          const SizedBox(height: 55),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: 300,
                height: 100, // Set the desired width here
                child: MyButton(
                    onTap: () {
                      // Navigate to the register page
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProfilePage(),
                        ),
                      );
                    },
                    text: "Hi ${user.displayName} !",
                    buttonColor: Color.fromRGBO(255, 255, 255, 0.612),
                    textColor: Colors.black,
                    textSize: 35),
              ),
              PopupMenuButton(
                child: ClipRRect(
                  child: Icon(
                    Icons.account_circle,
                    size: 80,
                  ),
                ),
                onSelected: (value) {
                  if (value == "profile") {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProfilePage(),
                      ),
                    );
                  } else if (value == "settings") {
                    // add desired output
                  } else if (value == "logout") {
                    signUserOut(context);
                  }
                },
                itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                  PopupMenuItem(
                    value: "profile",
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Icon(Icons.account_circle),
                        ),
                        const Text(
                          'Profile',
                          style: TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: "settings",
                    child: Row(
                      children: [
                        Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Icon(Icons.settings)),
                        const Text(
                          'Settings',
                          style: TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: "logout",
                    child: Row(
                      children: [
                        Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Icon(Icons.logout)),
                        const Text(
                          'Logout',
                          style: TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
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
                        child: Image.asset("lib/images/giraffe_carousel.png")),
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
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white, // Set background color to white
                    borderRadius:
                        BorderRadius.circular(10), // Add rounded corners
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5), // Set shadow color
                        spreadRadius: 7, // Set spread radius
                        blurRadius: 7, // Set blur radius
                        offset: Offset(0, 0), // Set shadow offset
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      Row(
                        children: [
                          const SizedBox(
                            width: 13,
                          ),
                          Column(
                            children: [
                              const SizedBox(
                                height: 22,
                              ),
                              Container(
                                height: 26,
                                width: 91,
                                decoration: BoxDecoration(
                                  color: Color(
                                      0xFF373737), // Set background color to white
                                  borderRadius: BorderRadius.circular(
                                      10), // Add rounded corners
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey
                                          .withOpacity(0.5), // Set shadow color
                                      spreadRadius: 5, // Set spread radius
                                      blurRadius: 7, // Set blur radius
                                      offset: Offset(0, 3), // Set shadow offset
                                    ),
                                  ],
                                ),
                                child: Text(
                                  "Coloring",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              Container(
                                height: 90,
                                width: 91,
                                decoration: BoxDecoration(
                                  color: Color(
                                      0xFFEBC272), // Set background color to white
                                  borderRadius: BorderRadius.circular(
                                      10), // Add rounded corners
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey
                                          .withOpacity(0.5), // Set shadow color
                                      spreadRadius: 5, // Set spread radius
                                      blurRadius: 7, // Set blur radius
                                      offset: Offset(0, 3), // Set shadow offset
                                    ),
                                  ],
                                ),
                                child: Text(
                                  " Total Questions: 5 \n \n Correct: ${((listfromresult["coloring"]?.fold(0, (a, b) => a + b) ?? 0)).toStringAsFixed(0)} \nIncorrect: ${(5 - (listfromresult["coloring"]?.fold(0, (a, b) => a + b) ?? 0)).toStringAsFixed(2)}",
                                  style: TextStyle(fontSize: 12),
                                  textAlign: TextAlign.center,
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            width: 25,
                          ),
                          Positioned(
                            right: 0,
                            top: 015,
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
                              progressColor: Color(0xFFEBC272),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
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
              if (listfromresult != null &&
                  listfromresult['calculate'] != null &&
                  listfromresult['calculate']!.isNotEmpty)
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.asset("lib/images/giraffe_carousel.png"),
                    ),
                    Positioned(
                      right: 15,
                      top: 15,
                      child: CircularPercentIndicator(
                        radius: 80.0,
                        lineWidth: 10.0,
                        percent: (listfromresult["calculate"]
                                    ?.fold(0, (a, b) => a + b) ??
                                0) /
                            12.5,
                        center: Text(
                          "${((listfromresult["calculate"]?.fold(0, (a, b) => a + b) ?? 0) / 12.5 * 100).toStringAsFixed(2)}%",
                          style: TextStyle(fontSize: 16.0),
                        ),
                        progressColor: Colors.red,
                      ),
                    )
                  ],
                )
              else
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.asset("lib/images/giraffe_carousel.png"),
                    ),
                    Positioned(
                      right: 15,
                      top: 15,
                      child: Text(
                        "Please attempt \nthe calculating quiz \nfor your results",
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
                      ),
                    ),
                  ],
                ),
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
          Container(
            child: Column(
              children: [
                Row(
                  children: [
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
                  ],
                ),
                Row(
                  children: [
                    QuizTypeButton(
                      button_color: Colors.blue,
                      button_text: 'Quiz on calculating',
                      questions: questions_color,
                      quizType: 'calculate',
                    ),
                    TextButton(
                      onPressed: () async {
                        await getUserID(context);
                      },
                      child: Text('Show Result History'),
                    ),
                  ],
                )
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
