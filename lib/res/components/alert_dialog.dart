import 'package:flutter/material.dart';
import 'package:internship_task/res/colors.dart';

// Custom Alert Dialog widget for user confirmation
class CustomAlertDialog extends StatelessWidget {
  Widget? messageText;
  VoidCallback? okOntap;
  VoidCallback? cancellOntap;
  // Constructor that takes text message as string and okOntap and CancellOntap
  // as void call back
  CustomAlertDialog(
      {super.key, this.messageText, this.okOntap, this.cancellOntap});

  @override
  Widget build(BuildContext context) {
    final HeightX = MediaQuery.of(context).size.height;
    final WidthY = MediaQuery.of(context).size.width;
    return AlertDialog(
      title: messageText,
      // AppColor is custom colors class its easy when want to change a color
      // we can change the color in AppColor class and that color will change
      // in all app widgets those uses that color
      backgroundColor: AppColor.white,
      actions: [
        // Row widget for align the children horizontally
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            InkWell(
              onTap: okOntap,
              child: Container(
                height: HeightX * 0.05,
                width: WidthY * 0.2,
                decoration: BoxDecoration(
                    color: AppColor.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          color: AppColor.black54,
                          offset: Offset(2, 2),
                          blurRadius: 2,
                          spreadRadius: 2)
                    ]),
                child: Center(
                    child: Text(
                  "Ok",
                  style: TextStyle(fontWeight: FontWeight.bold),
                )),
              ),
            ),
            InkWell(
              onTap: cancellOntap,
              child: Container(
                height: HeightX * 0.05,
                width: WidthY * 0.2,
                decoration: BoxDecoration(
                    color: AppColor.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          color: AppColor.black54,
                          offset: Offset(2, 2),
                          blurRadius: 2,
                          spreadRadius: 2)
                    ]),
                child: Center(
                    child: Text(
                  "Cancell",
                  style: TextStyle(fontWeight: FontWeight.bold),
                )),
              ),
            )
          ],
        )
      ],
    );
  }
}
