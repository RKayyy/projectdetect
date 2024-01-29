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
      final response = await http.get(Uri.parse('http://127.0.0.1:5566/get_user_details/$_uid'));
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
        title: Text('Profile'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 16),
            Column(
              children: [
                Text(
                  'User ID: $_uid',
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  'Child Name: ${_userDetails['child_name'] ?? 'N/A'}',
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  'Child Age: ${_userDetails['child_age'] ?? 'N/A'}',
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  'Parent Name: ${_userDetails['parent_name'] ?? 'N/A'}',
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  'Parent Phone: ${_userDetails['parent_phone_number'] ?? 'N/A'}',
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  'Address: ${_userDetails['address'] ?? 'N/A'}',
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
