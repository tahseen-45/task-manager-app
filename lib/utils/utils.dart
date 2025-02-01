import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:internship_task/res/colors.dart';

// Class for managing Utils
class Utils {
  static focusChanger(
      FocusNode currentFocus, FocusNode nextFocus, BuildContext context) {
    // Unfocus the focus from current text form field
    currentFocus.unfocus();
    // Transfer the focus to next text form field
    FocusScope.of(context).requestFocus(nextFocus);
  }
  // Function for Flutter toast that accepts message as String
  static flutterToast(String message) {
    Fluttertoast.showToast(msg: message, toastLength: Toast.LENGTH_LONG);
  }
  // Function for flushBar
  static flushBar(String message, BuildContext context) {
    showFlushbar(
        context: context,
        flushbar: Flushbar(
          message: message,
          duration: Duration(seconds: 8),
          borderRadius: BorderRadius.circular(15),
          backgroundColor: AppColor.blue,
          maxWidth: MediaQuery.of(context).size.width * 0.7,
        )..show(context));
  }
  // Function for snackBar
  static snackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }
  // Function to check where the user is connected to mobile data or wifi
  Future<bool> checkInternet(BuildContext context) async {
    var connectionResult = await Connectivity().checkConnectivity();
    if (!connectionResult.contains(ConnectivityResult.mobile) &&
        !connectionResult.contains(ConnectivityResult.wifi)) {
      flushBar("Your phone is not connected to Mobile data or Wifi", context);
      return false;
    } else {
      return true;
    }
  }
}
