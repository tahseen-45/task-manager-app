import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:internship_task/repository/auth_repository.dart';
import 'package:internship_task/res/colors.dart';
import 'package:internship_task/res/components/button.dart';
import 'package:internship_task/res/components/textform_field.dart';
import 'package:internship_task/utils/image_utils.dart';
import 'package:internship_task/utils/routes/routes_name.dart';
import 'package:internship_task/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  // Defining TextEditing Controllers
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController mobileNoController = TextEditingController();
  FocusNode firstNode = FocusNode();
  FocusNode secondNode = FocusNode();
  FocusNode thirdNode = FocusNode();
  FocusNode fourthNode = FocusNode();
  Utils checkConnection = Utils();
  AuthRepository authRepository = AuthRepository();

  @override
  Widget build(BuildContext context) {
    final HeightX = MediaQuery.of(context).size.height;
    final WidthY = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.skyLightBlue,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Consumer<ImageUtils>(
                builder: (context, vm, child) {
                  return Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Padding(
                          padding: EdgeInsets.all(20),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(180),
                            // Checks whether image is not null then show the image
                            // which user selected other wise show avatar image
                            child: vm.image != null
                                ? Image.file(
                                    vm.image!,
                                    height: HeightX * 0.27,
                                    width: WidthY * 0.54,
                                    fit: BoxFit.cover,
                                  )
                                : Image.asset("assets/images/avatar image.jpg",
                                    fit: BoxFit.cover, height: HeightX * 0.27),
                          )),
                      Positioned(
                        child: CircleAvatar(
                          child: InkWell(
                              onTap: () {
                                vm.pickImage();
                              },
                              child: Icon(Icons.edit)),
                          radius: HeightX * 0.03,
                        ),
                        left: WidthY * 0.51,
                        top: HeightX * 0.2,
                      )
                    ],
                  );
                },
              ),
              Shimmer.fromColors(
                  baseColor: AppColor.black,
                  highlightColor: AppColor.offWhite,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Text(
                      "Create new user account",
                      style:
                          TextStyle(fontSize: 29, fontWeight: FontWeight.bold),
                    ),
                  )),
              InputTextfield(
                borderColor: AppColor.black,
                hintText: "Name",
                label: "Name",
                editController: nameController,
                fieldFontSize: 17,
                currentFocus: firstNode,
                nextFocus: secondNode,
              ),
              InputTextfield(
                borderColor: AppColor.black,
                hintText: "Email",
                editController: emailController,
                label: "Email",
                currentFocus: secondNode,
                nextFocus: thirdNode,
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  controller: passwordController,
                  focusNode: thirdNode,
                  onFieldSubmitted: (value) {
                    Utils.focusChanger(thirdNode, fourthNode, context);
                  },
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
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide:
                              BorderSide(color: AppColor.black, width: 1))),
                ),
              ),
              InputTextfield(
                borderColor: AppColor.black,
                hintText: "Mobile No",
                editController: mobileNoController,
                label: "Mobile No",
                currentFocus: fourthNode,
                nextFocus: fourthNode,
              ),
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: Button(
                  buttonText: "Sign Up",
                  buttonColor: AppColor.mediumBlue,
                  buttonHeight: HeightX * 0.1,
                  buttonWidth: WidthY * 0.95,
                  buttonTextColor: AppColor.white,
                  buttonOntap: () {
                    checkConnection.checkInternet(context).then(
                      (value) async {
                        if (value) {
                          authRepository.signUpFormValidation(
                              nameController.text,
                              emailController.text,
                              passwordController.text,
                              mobileNoController.text,
                              context,
                              "Registering your Account");
                        }
                      },
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                  children: [
                    Text(
                      "Already have an Account?",
                      style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                          color: AppColor.black),
                    ),
                    InkWell(
                        onTap: () {
                          Navigator.pushReplacementNamed(
                              context, RoutesName.login);
                        },
                        child: Text(
                          " Login",
                          style: TextStyle(
                              fontSize: 21,
                              fontWeight: FontWeight.bold,
                              color: AppColor.blue),
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
