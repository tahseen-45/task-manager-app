import 'package:flutter/material.dart';
import 'package:internship_task/res/colors.dart';

class RoundButton extends StatelessWidget {
  String text;
  double height;
  double width;
  VoidCallback? onPress;
  Color? color;

  RoundButton(
      {super.key,
      required this.text,
      required this.height,
      required this.width,
      this.onPress,
      this.color});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: this.onPress,
      child: Container(
        height: this.height,
        width: this.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: this.color,
        ),
        child: Center(
            child: Text(
          this.text,
          style: TextStyle(
              fontSize: 39, fontWeight: FontWeight.bold, color: AppColor.white),
        )),
      ),
    );
  }
}
