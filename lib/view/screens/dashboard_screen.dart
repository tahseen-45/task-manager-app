import 'package:extended_image/extended_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internship_task/data/models/user_profile_data_model.dart';
import 'package:internship_task/repository/home_repository.dart';
import 'package:internship_task/repository/profile_repository.dart';
import 'package:internship_task/res/colors.dart';
import 'package:internship_task/res/components/button.dart';
import 'package:internship_task/res/components/textform_field.dart';
import 'package:internship_task/utils/routes/routes_name.dart';
import 'package:internship_task/utils/utils.dart';
import 'package:internship_task/viewmodel/homeviewviewmodel.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  FocusNode firstNode = FocusNode();
  FocusNode secondNode = FocusNode();
  FocusNode thirdNode = FocusNode();
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  HomeRepository homeRepository = HomeRepository();
  User? userInfo = FirebaseAuth.instance.currentUser;
  ProfileRepository profileRepository = ProfileRepository();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final homeViewViewModel =
        Provider.of<HomeViewViewModel>(context, listen: false);
    // Gets current Date
    homeViewViewModel.getCurrentDate();
  }

  @override
  Widget build(BuildContext context) {
    final HeightX = MediaQuery.of(context).size.height;
    final WidthY = MediaQuery.of(context).size.width;
    final homeViewViewModel =
        Provider.of<HomeViewViewModel>(context, listen: false);
    return Stack(children: [
      Scaffold(
        backgroundColor: AppColor.skyLightBlue,
        body: Column(
          children: [
            Container(
                padding: EdgeInsets.all(15),
                height: HeightX * 0.187,
                width: WidthY * 1,
                color: AppColor.lightMedBlue,
                child: FutureBuilder<UserProfileDataModel>(
                  future: profileRepository
                      .getUserProfileData(userInfo!.uid)
                      .onError(
                    (error, stackTrace) {
                      return Utils.flushBar(error.toString(), context);
                    },
                  ),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      // If data is loading the Shimmer gradient will be shown
                      // to user for amazing user experience
                      return Shimmer.fromColors(
                        baseColor: AppColor.grey100,
                        highlightColor: AppColor.grey300,
                        child: Padding(
                          padding: EdgeInsets.only(top: HeightX * 0.07),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 10),
                                    child: Container(
                                      height: HeightX * 0.03,
                                      width: WidthY * 0.5,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          color: AppColor.white),
                                    ),
                                  ),
                                  Container(
                                    height: HeightX * 0.03,
                                    width: WidthY * 0.5,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: AppColor.white),
                                  ),
                                ],
                              ),
                              Container(
                                height: HeightX * 0.13,
                                width: WidthY * 0.20,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColor.white),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                    if (snapshot.hasError) {
                      return Text("Error");
                    } else {
                      return Padding(
                        padding: EdgeInsets.only(top: HeightX * 0.06),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Shows current date
                                Text(
                                  homeViewViewModel.currentDate.toString(),
                                  style: TextStyle(
                                      fontSize: 17, color: AppColor.white),
                                ),
                                Text(
                                  "Good Day, ${snapshot.data!.name}",
                                  style: TextStyle(
                                      fontSize: 26,
                                      fontWeight: FontWeight.bold,
                                      color: AppColor.white),
                                )
                              ],
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pushNamedAndRemoveUntil(context,
                                    RoutesName.profileScreen, (route) => false,
                                    arguments: {
                                      "imageUrl": snapshot.data!.imageUrl,
                                      "name": snapshot.data!.name,
                                      "mobileNo": snapshot.data!.mobileNo,
                                      "about": snapshot.data!.about,
                                      "address": snapshot.data!.address
                                    });
                              },
                              child: ClipOval(
                                child: ExtendedImage.network(
                                  snapshot.data!.imageUrl.toString(),
                                  height: HeightX * 0.14,
                                  width: WidthY * 0.19,
                                  fit: BoxFit.cover,
                                  loadStateChanged: (state) {
                                    // Checking image loading state
                                    if (state.extendedImageLoadState ==
                                        LoadState.loading) {
                                      return Shimmer.fromColors(
                                          baseColor: AppColor.grey100,
                                          highlightColor: AppColor.grey300,
                                          child: Container(
                                            height: HeightX * 0.14,
                                            width: WidthY * 0.19,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: AppColor.white),
                                          ));
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    }
                  },
                )),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Text(
                "Dashboard is under construction",
                style: TextStyle(fontSize: 29, fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
      // Using Positioned to control the position of floating action button
      Positioned(
        bottom: HeightX * 0.09,
        right: 15,
        child: FloatingActionButton(
          onPressed: () {
            // Shows Modal Bottom Sheet for task entry
            showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (context) {
                return Container(
                  padding: EdgeInsets.all(19),
                  height: HeightX * 0.85,
                  width: WidthY * 1,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 5, right: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColor.offWhite),
                                  child: Icon(
                                    Icons.close,
                                    size: 30,
                                  )),
                            ),
                            Text(
                              "Add Task",
                              style: TextStyle(
                                  fontSize: 21, fontWeight: FontWeight.bold),
                            ),
                            Container(
                              width: WidthY * 0.07,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Divider(
                          thickness: 1,
                        ),
                      ),
                      InputTextfield(
                        borderColor: AppColor.black,
                        editController: titleController,
                        hintText: "Task Title",
                        label: "Task Title",
                        currentFocus: firstNode,
                        nextFocus: secondNode,
                        customPrefixIcon: Icon(Icons.task),
                      ),
                      InputTextfield(
                        borderColor: AppColor.black,
                        editController: descController,
                        hintText: "Task Description",
                        label: "Task Description",
                        currentFocus: secondNode,
                        nextFocus: thirdNode,
                        customPrefixIcon: Icon(Icons.description),
                      ),
                      InputTextfield(
                        borderColor: AppColor.black,
                        editController: categoryController,
                        hintText: "Task Category",
                        label: "Task Category",
                        currentFocus: thirdNode,
                        nextFocus: thirdNode,
                        customPrefixIcon: Icon(Icons.category),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                        child: Divider(
                          thickness: 1,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Task priority",
                              style: TextStyle(fontSize: 19),
                            ),
                            Consumer<HomeViewViewModel>(
                              builder: (context, sl, child) {
                                // Using Slider for amazing task priority
                                // visualization
                                return Slider(
                                  value: sl.taskPriority,
                                  thumbColor: AppColor.mediumBlue,
                                  min: 0,
                                  max: 3,
                                  divisions: 3,
                                  onChanged: (value) {
                                    // Setting the current value of slider to task
                                    // priority
                                    sl.taskPriorityLevel = value;
                                  },
                                  // Managing the active Color of Slider on certain
                                  // criteria
                                  activeColor: sl.taskPriority == 1
                                      ? AppColor.darkGreen
                                      : sl.taskPriority == 2
                                          ? AppColor.yellow
                                          : sl.taskPriority == 3
                                              ? AppColor.red
                                              : AppColor.black,
                                  // Managing the text label of Slider on certain
                                  // criteria
                                  label: sl.taskPriority == 0
                                      ? "No priority"
                                      : sl.taskPriority == 1
                                          ? "Low"
                                          : sl.taskPriority == 2
                                              ? "Medium"
                                              : "High",
                                );
                              },
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: Divider(
                          thickness: 1,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "To every day",
                              style: TextStyle(
                                fontSize: 19,
                              ),
                            ),
                            Consumer<HomeViewViewModel>(
                              builder: (context, sw, child) {
                                return Switch(
                                  value: sw.everyDaySw,
                                  activeColor: AppColor.mediumBlue,
                                  inactiveThumbColor: AppColor.lightBlue,
                                  inactiveTrackColor: AppColor.white,
                                  onChanged: (value) {
                                    sw.everyDaySwStatus = value;
                                  },
                                );
                              },
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: Divider(
                          thickness: 1,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "To today's list only",
                              style: TextStyle(
                                fontSize: 19,
                              ),
                            ),
                            Consumer<HomeViewViewModel>(
                              builder: (context, swtd, child) {
                                return Switch(
                                  value: swtd.toDaySw,
                                  activeColor: AppColor.mediumBlue,
                                  inactiveThumbColor: AppColor.lightBlue,
                                  inactiveTrackColor: AppColor.white,
                                  onChanged: (value) {
                                    swtd.toDaySwStatus = value;
                                  },
                                );
                              },
                            )
                          ],
                        ),
                      ),
                      Spacer(),
                      Padding(
                        padding: EdgeInsets.only(right: 10),
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: Button(
                            buttonHeight: HeightX * 0.06,
                            buttonWidth: WidthY * 0.4,
                            buttonText: "Save Task",
                            buttonColor: AppColor.mediumBlue,
                            buttonTextColor: AppColor.white,
                            buttonOntap: () {
                              homeRepository.addTaskFormValidation(
                                  userInfo!.uid,
                                  titleController.text,
                                  descController.text,
                                  categoryController.text,
                                  homeViewViewModel.taskPriority,
                                  homeViewViewModel.everyDaySw,
                                  homeViewViewModel.toDaySw,
                                  context);
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                );
              },
            );
          },
          backgroundColor: AppColor.mediumBlue,
          shape: CircleBorder(),
          child: Icon(
            Icons.add,
            color: AppColor.white,
            size: 35,
          ),
        ),
      )
    ]);
  }
}
