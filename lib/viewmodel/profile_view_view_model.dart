import 'package:flutter/material.dart';
import 'package:internship_task/repository/profile_repository.dart';
import 'package:internship_task/utils/utils.dart';
import 'package:overlay_kit/overlay_kit.dart';

class ProfileViewViewModel with ChangeNotifier {
  ProfileRepository profileRepository = ProfileRepository();
  Future<void> editProfileInfo(String? userId, String name, String mobileNo,
      String about, String address, BuildContext context) async {
    try {
      await profileRepository.editInputFormValidation(
          userId, name, mobileNo, about, address, context);
    } catch (e) {
      OverlayLoadingProgress.stop();
      Utils.snackBar(context, e.toString());
    }
  }
}
