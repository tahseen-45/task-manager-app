import 'package:flutter/material.dart';
import 'package:internship_task/repository/auth_repository.dart';
import 'package:internship_task/res/colors.dart';
import 'package:internship_task/res/components/button.dart';
import 'package:internship_task/res/components/textform_field.dart';
import 'package:internship_task/utils/routes/routes_name.dart';
import 'package:internship_task/utils/utils.dart';
import 'package:shimmer/shimmer.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  FocusNode firstNode = FocusNode();
  FocusNode secondNode = FocusNode();
  Utils _checkConnection = Utils();
  AuthRepository _authRepository = AuthRepository();

  @override
  Widget build(BuildContext context) {
    final HeightX = MediaQuery.of(context).size.height;
    final WidthY = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColor.skyLightBlue,
      // SingleChildScrollView manages the scrolling so when the keyboard appears
      // it allow the user to scroll the screen
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 55),
              child: Container(
                // Define internal padding of Container
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: AppColor.white),
                child: Icon(
                  Icons.person,
                  size: HeightX * 0.3,
                  color: AppColor.mediumBlue,
                ),
              ),
            ),
            // Using Shimmer for amazing user experience
            Shimmer.fromColors(
              baseColor: AppColor.black,
              highlightColor: AppColor.lightBlue,
              child: const Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  "Login",
                  style: TextStyle(fontSize: 39, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            // Customer TextFormField widget
            InputTextfield(
              borderColor: AppColor.black,
              hintText: "Email",
              editController: emailController,
              label: "Email",
              currentFocus: firstNode,
              nextFocus: secondNode,
              customPrefixIcon: const Icon(Icons.email),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                    hintText: "Password",
                    hintStyle: TextStyle(
                        fontWeight: FontWeight.bold, color: AppColor.black),
                    label: Text(
                      "Password",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: AppColor.black),
                    ),
                    filled: true,
                    fillColor: AppColor.white,
                    prefixIcon: const Icon(Icons.lock),
                    alignLabelWithHint: true,
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide:
                            BorderSide(color: AppColor.black, width: 1))),
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(10),
                child: Button(
                  buttonText: "Login",
                  buttonColor: AppColor.mediumBlue,
                  buttonHeight: HeightX * 0.1,
                  buttonWidth: WidthY * 0.95,
                  buttonTextColor: AppColor.white,
                  buttonOntap: () {
                    _checkConnection.checkInternet(context).then(
                      (value) {
                        // Checks whether user is connected to mobile data then
                        // allow the function to execute
                        if (value) {
                          _authRepository.loginFormValidation(
                              emailController.text,
                              passwordController.text,
                              context);
                        }
                      },
                    );
                  },
                )),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  Text(
                    "Don't Have an Account?",
                    style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                        color: AppColor.black),
                  ),
                  InkWell(
                      onTap: () {
                        Navigator.pushReplacementNamed(
                            context, RoutesName.signUpScreen);
                      },
                      child: Text(
                        " Sign Up",
                        style: TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.bold,
                            color: AppColor.blue),
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
