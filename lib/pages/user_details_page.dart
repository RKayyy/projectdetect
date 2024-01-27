import 'package:flutter/material.dart';
import 'package:projectssrk/components/my_button.dart';
import 'package:projectssrk/components/my_textfield.dart';

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

  Future<void> save_user_details()
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      body: Padding(
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
            ElevatedButton(
              child: Text('Submit details'),
              onPressed: () {
                widget.onDetailsSubmitted?.call();
                // You can add logic to handle the submission
              },
            ),
          ],
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
