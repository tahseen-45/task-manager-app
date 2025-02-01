import 'package:flutter/material.dart';

// Custom Button widget that are custom options
class Button extends StatelessWidget {
  double buttonHeight;
  double buttonWidth;
  Color? buttonColor;
  VoidCallback? buttonOntap;
  String buttonText;
  Color? buttonTextColor;
  // some fields are required so these must be provided and some are optional
  // in that constructor
  Button(
      {super.key,
      this.buttonColor,
      required this.buttonHeight,
      required this.buttonWidth,
      this.buttonOntap,
      required this.buttonText,
      this.buttonTextColor});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: buttonOntap,
      child: Container(
        height: buttonHeight,
        width: buttonWidth,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), color: buttonColor),
        child: Center(
            child: Text(
          buttonText,
          style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: buttonTextColor),
        )),
      ),
    );
  }
}
