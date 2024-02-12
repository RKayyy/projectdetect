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
      backgroundColor: Color(0xFFEBC272),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Align(
            alignment: Alignment.topLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Image.asset(
                    'lib/images/login_image1 (2).png',
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),

                const Padding(
                  padding: EdgeInsets.fromLTRB(47, 0, 0, 0),
                  child: Text(
                    'Enter Details',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 33,
                        fontFamily: 'ArimaMadurai',
                        fontWeight: FontWeight.bold),
                  ),
                ),

                const SizedBox(height: 23),

                MyTextField(
                  controller: nameController,
                  hintText: 'Name',
                  obscureText: false,
                ),
                const SizedBox(height: 12.5),
                MyTextField(
                  controller: ageController,
                  hintText: 'Age',
                  obscureText: false,
                ),
                const SizedBox(height: 12.5),
                MyTextField(
                  controller: parentsNameController,
                  hintText: "Parent's Name",
                  obscureText: false,
                ),
                const SizedBox(height: 12.5),
                MyTextField(
                  controller: parentsPhoneNumber,
                  hintText: "Parent's Contact",
                  obscureText: false,
                ),
                const SizedBox(height: 12.5),
                MyTextField(
                  controller: addressController,
                  hintText: 'Address',
                  obscureText: false,
                ),
                const SizedBox(height: 25),
                // ElevatedButton(
                //   child: Text('Submit'),
                //   onPressed: () {
                //     getUserID(nameController.text,int.tryParse(ageController.text) ?? 0,parentsNameController.text,  int.tryParse(parentsPhoneNumber.text) ?? 0,addressController.text);
                //
                //     // You can add logic to handle the submission
                //   },
                // ),
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: () {
                      getUserID(
                        nameController.text,
                        int.tryParse(ageController.text) ?? 0,
                        parentsNameController.text,
                        int.tryParse(parentsPhoneNumber.text) ?? 0,
                        addressController.text,
                      );

                      // You can add logic to handle the submission
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.76,
                      padding: EdgeInsets.symmetric(vertical: 18),
                      child: Center(
                        child: Text(
                          'Submit', // Replace with your desired text
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),


                const SizedBox(
                  height: 10,
                ),

                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Image.asset(
                    'lib/images/login_image1 (2).png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context); // Close the UserDetailsPage
        },
        tooltip: 'Back to Home',
        child: Icon(Icons.home),
      ),
    );
  }
}
