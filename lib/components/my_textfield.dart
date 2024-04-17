import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;

  const MyTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.8),
          borderRadius: BorderRadius.circular(45),
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(255, 101, 101, 101).withOpacity(0.5),
              blurRadius: 5,
              spreadRadius: 2,
              offset: Offset(6, 6)
            ),
          ],
        ),
        child: TextField(
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            hintText: hintText,
            border: InputBorder.none, // Remove the border
            contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
          ),
        ),
      ),
    );
  }
}
