import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:internship_task/res/colors.dart';
import 'package:internship_task/utils/image_utils.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

// Custom Overlay widget with many options
class CustomOverlay extends StatelessWidget {
  double? containerHeight;
  double? containerWidth;
  String containerText;
  File? filePath;
  CustomOverlay(
      {super.key,
      this.containerHeight,
      this.containerWidth,
      required this.containerText,
      this.filePath});

  @override
  Widget build(BuildContext context) {
    // using MediaQuery to manage responsiveness
    final HeightX = MediaQuery.of(context).size.height;
    final WidthY = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(color: AppColor.black38),
        // Column widget for place the widgets in horizontal
        child: Column(
          children: [
            SizedBox(height: HeightX * 0.265),
            filePath != null
                ? Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.topCenter,
                    children: [
                      ClipOval(
                        child: Image.file(
                          filePath!,
                          height: HeightX * 0.21,
                          width: WidthY * 0.44,
                          fit: BoxFit.cover,
                        ),
                      ),
                      // Consumer used to only rebuild the required parts using
                      // provider state management, only the code inside Consumer
                      // will be rebuild on value changes to manage the state
                      Consumer<ImageUtils>(
                        builder: (context, vm, child) {
                          // used PercentIndicator to show the upload status of image
                          return CircularPercentIndicator(
                            radius: HeightX * 0.11,
                            lineWidth: 10,
                            animation: true,
                            progressColor: AppColor.blue,
                            backgroundColor: AppColor.orrange,
                            circularStrokeCap: CircularStrokeCap.round,
                            percent: vm.uploadProgress,
                            center: Container(
                                padding: EdgeInsets.all(13),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColor.white,
                                    boxShadow: [
                                      BoxShadow(
                                          color: AppColor.black38,
                                          offset: Offset(2, 2),
                                          blurRadius: 2,
                                          spreadRadius: 2)
                                    ]),
                                child: Text(
                                  "${(vm.uploadProgress * 100).toStringAsFixed(1)}%",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: AppColor.black),
                                )),
                          );
                        },
                      )
                    ],
                  )
                : Container(),
            SizedBox(
              height: HeightX * 0.11,
            ),
            Container(
              height: containerHeight,
              width: containerWidth,
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.only(left: 15, right: 15),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: AppColor.black),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SpinKitFadingCircle(
                    color: AppColor.blue,
                    size: 29,
                  ),
                  Text(
                    containerText,
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: AppColor.white),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
