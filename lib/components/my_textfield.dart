import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final controller;
  final String hintText;
  final bool obscureText;

  const MyTextField(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.obscureText});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.85,
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
        decoration: BoxDecoration(
          color: Color(0xFFEEEEEE),
          border: Border.all(
              color: Colors.transparent, width: 1, style: BorderStyle.solid),
          borderRadius: BorderRadius.circular(30),
        ),
        child: TextField(
          controller: controller,
          obscureText: obscureText,
          //1st : property name, second: variable name
          decoration: InputDecoration(
            hintText: hintText,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            // hintStyle: TextStyle(color: Colors.grey[500]),
            // border: OutlineInputBorder(
            //   borderRadius: BorderRadius.circular(30),
            // ),
          ),

        ),
      ),
    );
  }
}
