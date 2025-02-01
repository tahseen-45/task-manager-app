import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:internship_task/res/colors.dart';

// Custom Loading Dialog for show Dialog
class LoadingDialog extends StatelessWidget {
  String message;
  LoadingDialog({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final Height = MediaQuery.of(context).size.height;
    final Width = MediaQuery.of(context).size.width;
    return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        backgroundColor: AppColor.black38,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                height: Height * 0.055,
                width: Width * 0.92,
                padding: EdgeInsets.only(left: 13, right: 13),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: AppColor.black),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SpinKitFadingCircle(
                      color: AppColor.blue,
                      size: 29,
                    ),
                    Text(
                      message,
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: AppColor.white),
                    )
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
