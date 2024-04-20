import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
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
    print(user);

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
        child: Align(
          alignment: Alignment.topCenter,
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            const SizedBox(height: 45),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 180.0,
                  height: 50.0,
                  decoration: BoxDecoration(
                    color: Colors.transparent, // Transparent background
                    borderRadius:
                        BorderRadius.circular(50.0), // Rounded corners
                    border: Border.all(
                        color: Colors.black, width: 2.0), // Black border
                  ),
                  child: Center(
                    child: Text(
                      "Hi there!",
                      style: TextStyle(fontSize: 22.0,
                      fontFamily: AutofillHints.birthdayDay, fontWeight: FontWeight.bold, ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 50,
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
                          color:
                              Colors.grey.withOpacity(0.5), // Set shadow color
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
                                            fontFamily: AutofillHints.birthday),
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
                          ],
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0,0,30.0,0),
                            child: CircularPercentIndicator(
                              radius: 70.0,
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
                              backgroundColor: Color(0xFF373737),
                            ),
                          ),
                        )
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
                          color:
                              Colors.grey.withOpacity(0.5), // Set shadow color
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
                                padding:
                                    const EdgeInsets.fromLTRB(12.0, 0, 0, 0),
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
                                              fontFamily:
                                                  AutofillHints.birthday),
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
                              Align(
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(20,0,0,0),
                                  child: CircularPercentIndicator(
                                    radius: 70.0,
                                    lineWidth: 12.0,
                                    percent: 0,
                                    center: Text(
                                      "0%",
                                      style: TextStyle(fontSize: 16.0),
                                    ),
                                    progressColor: Color(0xFFEBC272),
                                    backgroundColor: Color(0xFF373737),
                                  ),
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
                          color:
                              Colors.grey.withOpacity(0.5), // Set shadow color
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
                                            fontFamily: AutofillHints.birthday),
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
                            
                          ],
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(0,0,30.0,0),
                                child: CircularPercentIndicator(
                                  radius: 70.0,
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
                                  backgroundColor: Color(0xFF373737),
                                ),
                              ),
                            )
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
                          color:
                              Colors.grey.withOpacity(0.5), // Set shadow color
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
                                            fontFamily: AutofillHints.birthday),
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
                            Align(
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(20,0,0,0),
                                child: CircularPercentIndicator(
                                  radius: 70.0,
                                  lineWidth: 12.0,
                                  percent: 0,
                                  center: Text(
                                    "0%",
                                    style: TextStyle(fontSize: 16.0),
                                  ),
                                  progressColor: Color(0xFFEBC272),
                                  backgroundColor: Color(0xFF373737),
                                ),
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
                          color:
                              Colors.grey.withOpacity(0.5), // Set shadow color
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
                                            fontFamily: AutofillHints.birthday),
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
                            
                          ],
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                              child: Padding(
                                
                                padding: const EdgeInsets.fromLTRB(0,0,30.0,0),
                                child: CircularPercentIndicator(
                                  radius: 70.0,
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
                                  backgroundColor: Color(0xFF373737),
                                ),
                              ),
                            )
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
                          color:
                              Colors.grey.withOpacity(0.5), // Set shadow color
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
                                padding:
                                    const EdgeInsets.fromLTRB(12.0, 0, 0, 0),
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
                                              fontFamily:
                                                  AutofillHints.birthday),
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
                              Align(
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(20,0,0,0),
                                  child: CircularPercentIndicator(
                                    radius: 70.0,
                                    lineWidth: 12.0,
                                    percent: 0,
                                    center: Text(
                                      "0%",
                                      style: TextStyle(fontSize: 16.0),
                                    ),
                                    progressColor: Color(0xFFEBC272),
                                    backgroundColor: Color(0xFF373737),
                                  ),
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
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
              child: Container(
                child: Column(
                  children: [
                    Text(
                      'Quizzes',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: AutofillHints.birthdayDay,
                          fontSize: 25.0,
                          color: const Color.fromARGB(255, 0, 0, 0)),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Hey champ! step into a world of wonder! Join our Quiz Wizards, where learning feels like play. Embrace fun challenges, and let your smiles light the way to knowledge and excitement!',
                      style: TextStyle(
                          fontFamily: AutofillHints.birthday,
                          fontSize: 12.0,
                          color: const Color.fromARGB(255, 0, 0, 0)),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(40.0, 0, 40.0, 0),
                child: Container(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            QuizTypeButton(
                              button_color: Color(0xFFCFFFDF),
                              button_text: 'Counting',
                              questions: questions_count,
                              quizType: 'counting',
                              buttonImage: 'lib/images/counting_button_img.png',
                            ),
                            QuizTypeButton(
                              button_color: Color.fromARGB(255, 255, 213, 231),
                              button_text: "Coloring",
                              questions: questions_color,
                              quizType: 'coloring',
                              buttonImage: 'lib/images/coloring_button_img.png',
                            ),
                            
                          ],
                        ),
                        Row(
                          children: [
                            QuizTypeButton(
                              button_color: Color(0xFFD4DDFF),
                              button_text: 'Calculation',
                              questions: questions_color,
                              quizType: 'calculate',
                              buttonImage:
                                  'lib/images/calculation_button_img.png',
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Container(
                              width: 150,
                              height: 150,
                              decoration: BoxDecoration(
                                color: Color(0xFF373737),
                                borderRadius: BorderRadius.circular(
                                    15), // Adjust the value for the desired border radius
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(
                                        0.5), // Color of the shadow
                                    spreadRadius: 2, // Spread radius
                                    blurRadius: 5, // Blur radius
                                    offset: Offset(
                                        0, 3), // Offset in x and y directions
                                  ),
                                ],
                              ),
                              child: TextButton(
                                onPressed: () async {
                                  await getUserID(context);
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 26,
                                      width: 110,
                                      decoration: BoxDecoration(
                                        color: Color(0xFFEBC272),
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      child: Text(
                                        "Results History",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          // fontFamily: AutofillHints.birthday, // There's no AutofillHints.birthday font family, so I commented this line
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    SizedBox(
                                        height:
                                            25), // Adjust the spacing between the text and image
                                    Transform.scale(
                                      scale: 1.75,
                                      child: Image.asset(
                                        'lib/images/results_button_img.png',
                                        height:
                                            40, // Adjust the height of the image as needed
                                      ),
                                    ),
                                    SizedBox(height: 15)
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
