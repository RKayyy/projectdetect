import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final Function()? onTap;
  final String text;
  final Color buttonColor;
  final Color textColor;
  final double textSize;
  const MyButton({
    Key? key,
    required this.onTap,
    required this.text,
    this.buttonColor = Colors.black,
    this.textColor = Colors.white,
    this.textSize = 18, // Set black as the default text color
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(25),
        margin: const EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(45),
          border: Border.all(color: Colors.black), // Add a black border
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: textColor, // Use the specified text color
              fontWeight: FontWeight.bold,
              fontSize: textSize,
            ),
          ),
        ),
      ),
    );
  }
}
