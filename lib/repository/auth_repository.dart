import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:internship_task/globalvar/global_var.dart';
import 'package:internship_task/res/colors.dart';
import 'package:internship_task/res/components/dialog.dart';
import 'package:internship_task/res/components/overlay.dart';
import 'package:internship_task/utils/image_utils.dart';
import 'package:internship_task/utils/routes/routes_name.dart';
import 'package:internship_task/utils/utils.dart';
import 'package:overlay_kit/overlay_kit.dart';
import 'package:provider/provider.dart';

class AuthRepository {
  // function to perform sign up operations
  Future<void> SignUp(String name, String emailUser, String passwordUser,
      String mobileNo, BuildContext context, String message) async {

    // object to use members of Provider class Image Utils
    final imageUtils = Provider.of<ImageUtils>(context, listen: false);

    // using MediaQuery to maintain responsiveness of the screen on devices
    final HeightX = MediaQuery.of(context).size.height;
    final WidthY = MediaQuery.of(context).size.width;
    if (imageFile == null) {
      Utils.flushBar("Please select profile image", context);
      return;
    }
    try {
      OverlayLoadingProgress.start(
        barrierDismissible: false,
        barrierColor: AppColor.black.withOpacity(0.5),
        widget: CustomOverlay(
          containerText: "Registering your account...",
          containerHeight: HeightX * 0.05,
          containerWidth: WidthY * 0.7,
          filePath: imageUtils.image,
        ),
      );

      // to create new user account in Firebase Authentication
      User? refUser = (await FirebaseAuth.instance
              .createUserWithEmailAndPassword(
                  email: emailUser, password: passwordUser))
          .user;
      String? imageUrl = await imageUtils.uploadImage();
      if (imageUrl != null && imageUrl != "") {
        Map<String, dynamic> dataMap = {
          "id": refUser!.uid,
          "name": name,
          "email": emailUser,
          "mobile": mobileNo,
          "imageUrl": imageUrl,
        };

        // add user profile information in firebase firestore
        await FirebaseFirestore.instance
            .collection("users")
            .doc(refUser.uid)
            .set(dataMap)
            .then(
          (value) {
            OverlayLoadingProgress.stop();
            Utils.flushBar("Your account has been created", context);
            Future.delayed(
              Duration(seconds: 2),
              () {
                imageUtils.setImage = null;
                Navigator.pushReplacementNamed(context, RoutesName.login);
              },
            );
          },
        );
      }
    } catch (e) {
      OverlayLoadingProgress.stop();
      Utils.flushBar(e.toString(), context);
    }
  }

  // function that takes parameters and perform user registration form validation

  void signUpFormValidation(String name, String emailUser, String passwordUser,
      String mobileNo, BuildContext context, String message) {
    if (name.isEmpty) {
      Utils.flushBar("Please enter your name", context);
    } else if (name.length > 18) {
      Utils.flushBar("Name should be less then 19 characters", context);
    } else if (emailUser.isEmpty) {
      Utils.flushBar("Please enter your email address", context);
    } else if (!emailUser.contains("@")) {
      Utils.flushBar("Please enter valid email address", context);
    } else if (passwordUser.isEmpty) {
      Utils.flushBar("Please enter password", context);
    } else if (passwordUser.length < 7) {
      Utils.flushBar("Password should not be less then 7 charactors", context);
    } else if (mobileNo.isEmpty) {
      Utils.flushBar("Please enter your mobile no", context);
    } else if (mobileNo.length < 11) {
      Utils.flushBar("Mobile no should not be less then 11", context);
    } else {
      SignUp(name, emailUser, passwordUser, mobileNo, context, message);
    }
  }

  Future<void> login(
      String emailUser, String passwordUser, BuildContext context) async {
    try {
      showDialog(
        context: context,
        builder: (context) =>
            LoadingDialog(message: "Authenticating please wait..."),
        barrierDismissible: false,
      );
      User? userdata = (await FirebaseAuth.instance.signInWithEmailAndPassword(
              email: emailUser, password: passwordUser))
          .user;
      await getUserProfileInfo(userdata, context).then(
        (value) {
          if (value) {
            Utils.flushBar("Logged in Successfully", context);
          }
        },
      );
    } catch (e) {
      Navigator.pop(context);
      Utils.flushBar(e.toString(), context);
    }
  }

  // function to manage login Validations
  void loginFormValidation(
      String emailUser, String passwordUser, BuildContext context) {
    if (emailUser.isEmpty) {
      Utils.flushBar("Please enter your email address", context);
    } else if (!emailUser.contains("@")) {
      Utils.flushBar("Please enter valid email address", context);
    } else if (passwordUser.isEmpty) {
      Utils.flushBar("Please enter password", context);
    } else if (passwordUser.length < 7) {
      Utils.flushBar("Password should not be less then 7 charactors", context);
    } else {
      login(emailUser, passwordUser, context);
    }
  }

  // function to fetch profile info user
  Future<bool> getUserProfileInfo(User? userInfo, BuildContext context) async {
    try {
      QuerySnapshot userRef = await FirebaseFirestore.instance
          .collection("users")
          .where("id", isEqualTo: userInfo!.uid)
          .get();

      if (userRef.docs.first.exists) {
        // Navigates to the bottomNav route
        Navigator.pushNamedAndRemoveUntil(
          context,
          RoutesName.bottomNav,
          (route) => false,
        );
        return true;
      } else {
        Navigator.pop(context);
        FirebaseAuth.instance.signOut();
        Utils.flushBar("Your record does not exists", context);
        return false;
      }
    } catch (e) {
      Utils.flushBar(e.toString(), context);
      return false;
    }
  }
}
