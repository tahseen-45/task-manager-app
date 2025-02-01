import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:internship_task/data/models/user_profile_data_model.dart';
import 'package:internship_task/data/network/network_data_services.dart';
import 'package:internship_task/res/colors.dart';
import 'package:internship_task/res/components/overlay.dart';
import 'package:internship_task/utils/image_utils.dart';
import 'package:internship_task/utils/utils.dart';
import 'package:overlay_kit/overlay_kit.dart';
import 'package:provider/provider.dart';

class ProfileRepository {
  NetworkDataServices networkDataServices = NetworkDataServices();
  // returns user profile data model
  Future<UserProfileDataModel> getUserProfileData(String userId) async {
    try {
      Map<String, dynamic> userProfileInfo =
          await networkDataServices.getCollectionDocFields("users", userId);
      return UserProfileDataModel.fromData(userProfileInfo);
    } on SocketException {
      throw SocketException("No Internet");
    }
  }

  // Validates the user input on user updates profile info
  Future<void> editInputFormValidation(
      String? userId,
      String name,
      String mobileNo,
      String about,
      String address,
      BuildContext context) async {
    if (name.isEmpty) {
      Utils.flushBar("Please enter name", context);
    } else if (mobileNo.isEmpty) {
      Utils.flushBar("Please Enter Mobile No", context);
    } else if (mobileNo.length < 11) {
      Utils.flushBar(
          "Mobile No should not be less then 11 characters", context);
    } else {
      await editProfileInfo(userId, name, mobileNo, about, address, context);
    }
  }
  // function to update profile information
  Future<void> editProfileInfo(String? userId, String name, String mobileNo,
      String about, String address, BuildContext context) async {
    try {
      final HeightX = MediaQuery.of(context).size.height;
      final WidthY = MediaQuery.of(context).size.width;
      final imageUtils = Provider.of<ImageUtils>(context, listen: false);
      // starts Overlay on update in progress to give amazing user experience
      OverlayLoadingProgress.start(
        barrierDismissible: false,
        barrierColor: AppColor.black.withOpacity(0.5),
        widget: CustomOverlay(
          containerText: "Updating please wait...",
          containerHeight: HeightX * 0.07,
          containerWidth: WidthY * 0.75,
          // checks if user selects image on edit the profile info then update
          // that user image
          filePath: imageUtils.image != null ? imageUtils.image : null,
        ),
      );
      // checks if user selects new profile image the execute upload image function
      if (imageUtils.image != null) {
        String? imageUrl = await imageUtils.uploadImage();
        await FirebaseFirestore.instance
            .collection("users")
            .doc(userId)
            .update({"imageUrl": imageUrl});
      }
      await FirebaseFirestore.instance.collection("users").doc(userId).update({
        "name": name,
        "mobile": mobileNo,
        "address": address,
        "about": about
      });
      OverlayLoadingProgress.stop();
      Utils.snackBar(context, "Your Profile has been updated successfully");
    } catch (e) {
      OverlayLoadingProgress.stop();
      Utils.snackBar(context, e.toString());
    }
  }
}
