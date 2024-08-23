// import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:projectssrk/components/my_button.dart';
import 'package:projectssrk/components/my_textfield.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:projectssrk/pages/home_page.dart';

class UserDetailsPage extends StatefulWidget {
  final Function()? onDetailsSubmitted;
  UserDetailsPage({super.key, this.onDetailsSubmitted});

  @override
  State<UserDetailsPage> createState() => _UserDetailsPageState();
}

class _UserDetailsPageState extends State<UserDetailsPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController parentsNameController = TextEditingController();
  final TextEditingController parentsPhoneNumber = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  Future<void> getUserID(String name, int age, String parent_name,
      int parent_phone_number, String Address) async {
    // Retrieve the currently signed-in user
    User? user = FirebaseAuth.instance.currentUser;
    String uid = user?.uid ?? ""; // Fetch the UID
    print("User UID: $uid");
    // print(name);
    await save_user_details1(
        uid, name, age, parent_name, parent_phone_number, Address);
  }

  Future<void> save_user_details1(String uid, String name, int age,
      String parent_name, int parent_phone_number, String Address) async {
    try {
      final response = await http.post(
        Uri.parse(
            'http://127.0.0.1:5566/save_user_details'), // Replace with your Flask backend URL
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'uid': uid,
          "child_name": name,
          "child_age": age,
          "parent_name": parent_name,
          "parent_phone_number": parent_phone_number,
          "address": Address,
        }),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode != 200) {
        throw Exception('Failed to register user on the server');
      }
    } catch (e) {
      print('Error while saving user details: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFEBC272),
        elevation: 10,
        shadowColor: Color.fromARGB(255, 46, 46, 46),
        title: Text('User Details'),
        actions: [
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context); // Close the UserDetailsPage
            },
          ),
        ],
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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyTextField(
                controller: nameController,
                hintText: 'Name',
                obscureText: false,
              ),
              const SizedBox(height: 20),
              MyTextField(
                controller: ageController,
                hintText: 'Age',
                obscureText: false,
              ),
              const SizedBox(height: 20),
              MyTextField(
                controller: parentsNameController,
                hintText: "Parents' Name",
                obscureText: false,
              ),
              const SizedBox(height: 20),
              MyTextField(
                controller: parentsPhoneNumber,
                hintText: "Parents' Phone Number",
                obscureText: false,
              ),
              const SizedBox(height: 20),
              MyTextField(
                controller: addressController,
                hintText: 'Address',
                obscureText: false,
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Colors.black), // Set background color to black
                    foregroundColor: MaterialStateProperty.all<Color>(
                        Colors.white), // Set text color to white
                    minimumSize: MaterialStateProperty.all<Size>(
                        Size(350.0, 50)), // Set width to 200 and height to 40
                    elevation: MaterialStateProperty.all<double>(
                        20.0), // Add shadow with elevation
                  ),
                  onPressed: () {
                    getUserID(
                      nameController.text,
                      int.tryParse(ageController.text) ?? 0,
                      parentsNameController.text,
                      int.tryParse(parentsPhoneNumber.text) ?? 0,
                      addressController.text,
                    );
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomePage(),
                      ),
                    );
                    // You can add logic to handle the submission
                  },
                  child: Text('Submit details'),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: SizedBox(
        width: 100.0, // Set the desired width
        height: 100.0, // Set the desired height
        child: FloatingActionButton(
          onPressed: () {
            Navigator.pop(context); // Close the UserDetailsPage
          },
          tooltip: 'Back to Home',
          backgroundColor: Color(0xFFEBC272), // Change background color to red
          elevation: 4.0, // Increase elevation for a larger appearance
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
                20.0), // Adjust the border radius for a circular button
          ),
          child: Transform.scale(scale: 1.8, child: Icon(Icons.home)),
        ),
      ),
    );
  }
}
