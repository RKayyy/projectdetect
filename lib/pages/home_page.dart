import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white, // Set background color to white
                    borderRadius:
                        BorderRadius.circular(10), // Add rounded corners
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5), // Set shadow color
                        spreadRadius: 4, // Set spread radius
                        blurRadius: 10, // Set shadow offset
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      Row(
                        children: [
                          const SizedBox(
                            width: 15,
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20.0, 0, 0, 0),
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 25,
                                ),
                                Container(
                                  height: 26,
                                  width: 91,
                                  decoration: BoxDecoration(
                                    color: Color(
                                        0xFF373737), // Set background color to white
                                    borderRadius: BorderRadius.circular(
                                        10), // Add rounded corners
                                    
                                  ),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Counting",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                          fontFamily: AutofillHints.birthday 
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                Container(
                                  height: 100,
                                  width: 90,
                                  decoration: BoxDecoration(
                                    color: Color(
                                        0xFFEBC272), // Set background color to white
                                    borderRadius: BorderRadius.circular(
                                        10), // Add rounded corners
                                    
                                  ),
                                  
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      
                                      " Total Questions: 5 \n \n Correct: ${((listfromresult["counting"]?.fold(0, (a, b) => a + b) ?? 0)).toStringAsFixed(0)} \nIncorrect: ${(5 - (listfromresult["counting"]?.fold(0, (a, b) => a + b) ?? 0)).toStringAsFixed(2)}",
                                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold,
                                          color: Colors.white,),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 25,
                          ),
                          Positioned(
                            right: 0,
                            top: 015,
                            child: CircularPercentIndicator(
                              radius: 80.0,
                              lineWidth: 12.0,
                              percent: (listfromresult["counting"]
                                          ?.fold(0, (a, b) => a + b) ??
                                      0) /
                                  12.5,
                              center: Text(
                                "${((listfromresult["counting"]?.fold(0, (a, b) => a + b) ?? 0) / 12.5 * 100).toStringAsFixed(2)}%",
                                style: TextStyle(fontSize: 16.0),
                              ),
                              progressColor: Color(0xFFEBC272),
                              backgroundColor: Color(
                                          0xFF373737),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                )
              else
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white, // Set background color to white
                    borderRadius:
                        BorderRadius.circular(10), // Add rounded corners
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5), // Set shadow color
                        spreadRadius: 4, // Set spread radius
                        blurRadius: 10, // Set blur radius
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      Align(
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 15,
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(12.0, 0, 0, 0),
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 25,
                                  ),
                                  Container(
                                    height: 26,
                                    width: 91,
                                    decoration: BoxDecoration(
                                      color: Color(
                                          0xFF373737), // Set background color to white
                                      borderRadius: BorderRadius.circular(
                                          30), // Add rounded corners
                                      
                                    ),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        "Counting",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: AutofillHints.birthday 
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  Container(
                                    height: 100,
                                    width: 90,
                                    decoration: BoxDecoration(
                                      color: Color(
                                          0xFFEBC272), // Set background color to white
                                      borderRadius: BorderRadius.circular(
                                          10), // Add rounded corners
                                      
                                    ),
                                    
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        " Total Questions: 5 \n \n Correct: N/A \nIncorrect: N/A",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 25,
                            ),
                            Positioned(
                              right: 0,
                              top: 015,
                              child: CircularPercentIndicator(
                                radius: 80.0,
                                lineWidth: 12.0,
                                percent:0,
                                center: Text(
                                  "0%",
                                  style: TextStyle(fontSize: 16.0),
                                ),
                                progressColor: Color(0xFFEBC272),
                                backgroundColor: Color(
                                          0xFF373737), 
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
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
                        spreadRadius: 4, // Set spread radius
                        blurRadius: 10, // Set shadow offset
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      Row(
                        children: [
                          const SizedBox(
                            width: 15,
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20.0, 0, 0, 0),
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 25,
                                ),
                                Container(
                                  height: 26,
                                  width: 91,
                                  decoration: BoxDecoration(
                                    color: Color(
                                        0xFF373737), // Set background color to white
                                    borderRadius: BorderRadius.circular(
                                        30), // Add rounded corners
                                    
                                  ),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Coloring",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                          fontFamily: AutofillHints.birthday 
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                Container(
                                  height: 100,
                                  width: 90,
                                  decoration: BoxDecoration(
                                    color: Color(
                                        0xFFEBC272), // Set background color to white
                                    borderRadius: BorderRadius.circular(
                                        10), // Add rounded corners
                                    
                                  ),
                                  
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      
                                      " Total Questions: 5 \n \n Correct: ${((listfromresult["coloring"]?.fold(0, (a, b) => a + b) ?? 0)).toStringAsFixed(0)} \nIncorrect: ${(5 - (listfromresult["coloring"]?.fold(0, (a, b) => a + b) ?? 0)).toStringAsFixed(2)}",
                                      style: TextStyle(fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                          color: Colors.white,),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 25,
                          ),
                          Positioned(
                            right: 0,
                            top: 015,
                            child: CircularPercentIndicator(
                              radius: 80.0,
                              lineWidth: 12.0,
                              percent: (listfromresult["coloring"]
                                          ?.fold(0, (a, b) => a + b) ??
                                      0) /
                                  12.5,
                              center: Text(
                                "${((listfromresult["coloring"]?.fold(0, (a, b) => a + b) ?? 0) / 12.5 * 100).toStringAsFixed(2)}%",
                                style: TextStyle(fontSize: 16.0),
                              ),
                              progressColor: Color(0xFFEBC272),
                              backgroundColor: Color(
                                          0xFF373737),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                )
              else
              //------------------------------------------------------------------------------------------


                Container(
                  decoration: BoxDecoration(
                    color: Colors.white, // Set background color to white
                    borderRadius:
                        BorderRadius.circular(10), // Add rounded corners
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5), // Set shadow color
                        spreadRadius: 4, // Set spread radius
                        blurRadius: 10,  // Set shadow offset
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      Row(
                        children: [
                          const SizedBox(
                            width: 15,
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(12.0, 0, 0, 0),
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 25,
                                ),
                                Container(
                                  height: 26,
                                  width: 91,
                                  decoration: BoxDecoration(
                                    color: Color(
                                        0xFF373737), // Set background color to white
                                    borderRadius: BorderRadius.circular(
                                        30), // Add rounded corners
                                    
                                  ),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Coloring",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                          fontFamily: AutofillHints.birthday 
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                Container(
                                  height: 100,
                                  width: 90,
                                  decoration: BoxDecoration(
                                    color: Color(
                                        0xFFEBC272), // Set background color to white
                                    borderRadius: BorderRadius.circular(
                                        10), // Add rounded corners
                                    
                                  ),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      " Total Questions: 5 \n \n Correct: N/A \nIncorrect: N/A",
                                      style: TextStyle(fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                          color: Colors.white,),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 25,
                          ),
                          Positioned(
                            right: 0,
                            top: 015,
                            child: CircularPercentIndicator(
                              radius: 80.0,
                              lineWidth: 12.0,
                              percent:0,
                              center: Text(
                                "0%",
                                style: TextStyle(fontSize: 16.0),
                              ),
                              progressColor: Color(0xFFEBC272),
                              backgroundColor: Color(
                                          0xFF373737),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),


                //-----------------------------------------------------------------------------
              if (listfromresult != null &&
                  listfromresult['calculate'] != null &&
                  listfromresult['calculate']!.isNotEmpty)
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white, // Set background color to white
                    borderRadius:
                        BorderRadius.circular(10), // Add rounded corners
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5), // Set shadow color
                        spreadRadius: 4, // Set spread radius
                        blurRadius: 10, // Set shadow offset
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      Row(
                        children: [
                          const SizedBox(
                            width: 15,
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20.0, 0, 0, 0),
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 25,
                                ),
                                Container(
                                  height: 26,
                                  width: 91,
                                  decoration: BoxDecoration(
                                    color: Color(
                                        0xFF373737), // Set background color to white
                                    borderRadius: BorderRadius.circular(
                                        10), // Add rounded corners
                                    
                                  ),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Calculation",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                          fontFamily: AutofillHints.birthday 
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                Container(
                                  height: 100,
                                  width: 90,
                                  decoration: BoxDecoration(
                                    color: Color(
                                        0xFFEBC272), // Set background color to white
                                    borderRadius: BorderRadius.circular(
                                        10), // Add rounded corners
                                    
                                  ),
                                  
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      
                                      " Total Questions: 5 \n \n Correct: ${((listfromresult["calculate"]?.fold(0, (a, b) => a + b) ?? 0)).toStringAsFixed(0)} \nIncorrect: ${(5 - (listfromresult["calculate"]?.fold(0, (a, b) => a + b) ?? 0)).toStringAsFixed(2)}",
                                      style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold,
                                          color: Colors.white,),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 25,
                          ),
                          Positioned(
                            right: 0,
                            top: 015,
                            child: CircularPercentIndicator(
                              radius: 80.0,
                              lineWidth: 12.0,
                              percent: (listfromresult["calculate"]
                                          ?.fold(0, (a, b) => a + b) ??
                                      0) /
                                  12.5,
                              center: Text(
                                "${((listfromresult["calculate"]?.fold(0, (a, b) => a + b) ?? 0) / 12.5 * 100).toStringAsFixed(2)}%",
                                style: TextStyle(fontSize: 16.0),
                              ),
                              progressColor: Color(0xFFEBC272),
                              backgroundColor: Color(
                                          0xFF373737),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                )
              else
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white, // Set background color to white
                    borderRadius:
                        BorderRadius.circular(10), // Add rounded corners
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5), // Set shadow color
                        spreadRadius: 4, // Set spread radius
                        blurRadius: 10, // Set blur radius
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      Align(
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 15,
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(12.0, 0, 0, 0),
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 25,
                                  ),
                                  Container(
                                    height: 26,
                                    width: 91,
                                    decoration: BoxDecoration(
                                      color: Color(
                                          0xFF373737), // Set background color to white
                                      borderRadius: BorderRadius.circular(
                                          30), // Add rounded corners
                                      
                                    ),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        "Calculation",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: AutofillHints.birthday 
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  Container(
                                    height: 100,
                                    width: 90,
                                    decoration: BoxDecoration(
                                      color: Color(
                                          0xFFEBC272), // Set background color to white
                                      borderRadius: BorderRadius.circular(
                                          10), // Add rounded corners
                                      
                                    ),
                                    
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        " Total Questions: 5 \n \n Correct: N/A \nIncorrect: N/A",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 25,
                            ),
                            Positioned(
                              right: 0,
                              top: 015,
                              child: CircularPercentIndicator(
                                radius: 80.0,
                                lineWidth: 12.0,
                                percent:0,
                                center: Text(
                                  "0%",
                                  style: TextStyle(fontSize: 16.0),
                                ),
                                progressColor: Color(0xFFEBC272),
                                backgroundColor: Color(
                                          0xFF373737), 
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
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
          SizedBox(height:  20),
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
