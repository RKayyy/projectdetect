import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late Map<String, dynamic> _userDetails;
  late String _uid; // Add this line to store the user ID

  @override
  void initState() {
    super.initState();
    _userDetails = {}; // Initialize with empty details
    _uid = ""; // Initialize user ID
    fetchUserDetails();
  }

  Future<void> fetchUserDetails() async {
    try {
      // Fetch the UID using the getUserID method
      _uid = await getUserID(); // Store user ID
      print("User UID: $_uid");

      // Use the retrieved UID to get user details
      final response = await http
          .get(Uri.parse('http://127.0.0.1:5566/get_user_details/$_uid'));
      print(response.statusCode);

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        // Check if the widget is still mounted before calling setState
        if (mounted) {
          setState(() {
            _userDetails = jsonResponse;
            print(_userDetails);
          });
        }
      } else {
        // Handle error
        print('Failed to fetch user details');
      }
    } catch (e) {
      // Handle exception
      print('Exception: $e');
    }
  }

  // Modified method to return the UID
  Future<String> getUserID() async {
    // Retrieve the currently signed-in user
    User? user = FirebaseAuth.instance.currentUser;
    String uid = user?.uid ?? ""; // Fetch the UID
    return uid;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF6F6F6), // Background color
        title: Text('Result History'),
        elevation: 0,
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
          image: DecorationImage(
            image: AssetImage('lib/images/background.png'), // Image asset
            fit: BoxFit.cover, // Adjusts the image to cover the entire app bar
            colorFilter: ColorFilter.mode(
              Colors.white.withOpacity(0.1), // 10% opacity (90% transparent)
              BlendMode.dstATop, // Apply the opacity to the image
            ),
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 16),
              Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Color(0xFFEBC272)),
                    child: Column(
                      children: [
                        Text(
                          'User ID:\n',
                          style: TextStyle(fontSize: 12),
                        ),
                        Text(
                          '$_uid',
                          style: TextStyle(fontSize: 20),
                        )
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Color(0xFFEBC272)),
                    child: Column(
                      children: [
                        Text(
                          'User ID:\n',
                          style: TextStyle(fontSize: 12),
                        ),
                        Text(
                          '$_uid',
                          style: TextStyle(fontSize: 20),
                        )
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Color(0xFFEBC272)),
                    child: Column(
                      children: [
                        Text(
                          'User ID:\n',
                          style: TextStyle(fontSize: 12),
                        ),
                        Text(
                          '$_uid',
                          style: TextStyle(fontSize: 20),
                        )
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Color(0xFFEBC272)),
                    child: Column(
                      children: [
                        Text(
                          'User ID:\n',
                          style: TextStyle(fontSize: 12),
                        ),
                        Text(
                          '$_uid',
                          style: TextStyle(fontSize: 20),
                        )
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Color(0xFFEBC272)),
                    child: Column(
                      children: [
                        Text(
                          'User ID:\n',
                          style: TextStyle(fontSize: 12),
                        ),
                        Text(
                          '$_uid',
                          style: TextStyle(fontSize: 20),
                        )
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Color(0xFFEBC272)),
                    child: Column(
                      children: [
                        Text(
                          'User ID:\n',
                          style: TextStyle(fontSize: 12),
                        ),
                        Text(
                          '$_uid',
                          style: TextStyle(fontSize: 20),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
