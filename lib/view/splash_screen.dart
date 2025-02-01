import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:internship_task/repository/auth_repository.dart';
import 'package:internship_task/res/colors.dart';
import 'package:internship_task/utils/routes/routes_name.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  User? userInfo = FirebaseAuth.instance.currentUser;
  AuthRepository authRepository = AuthRepository();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(
      Duration(seconds: 4),
      () {
        // checks if userInfo is null the Navigate to login screen
        userInfo ?? Navigator.pushReplacementNamed(context, RoutesName.login);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final HeightX = MediaQuery.of(context).size.height;
    if (userInfo != null) {
      Future.delayed(
        Duration(seconds: 4),
        () {
          authRepository.getUserProfileInfo(userInfo, context);
        },
      );
    }
    return Scaffold(
      backgroundColor: AppColor.skyLightBlue,
      body: Column(
        children: [
          Padding(
              padding: EdgeInsets.only(top: HeightX * 0.04),
              child: Container(
                height: HeightX * 0.75,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/splash.jpg"),
                        fit: BoxFit.cover)),
              )),
          Padding(
            padding: EdgeInsets.only(top: HeightX * 0.05),
            child: SpinKitWave(
              size: 55,
              color: AppColor.blue,
            ),
          ),
        ],
      ),
    );
  }
}
