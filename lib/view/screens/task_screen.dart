import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:internship_task/repository/home_repository.dart';
import 'package:internship_task/res/colors.dart';
import 'package:internship_task/res/components/button.dart';
import 'package:internship_task/res/components/textform_field.dart';
import 'package:internship_task/viewmodel/task_view_view_model.dart';
import 'package:provider/provider.dart';

class TaskScreenEveryDay extends StatefulWidget {
  const TaskScreenEveryDay({super.key});

  @override
  State<TaskScreenEveryDay> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreenEveryDay> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  FocusNode firstNode = FocusNode();
  FocusNode secondNode = FocusNode();
  HomeRepository homeRepository = HomeRepository();
  User? userInfo = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    final HeightX = MediaQuery.of(context).size.height;
    final WidthY = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColor.skyLightBlue,
      body: Container(
        padding: EdgeInsets.all(25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: HeightX * 0.05, bottom: 10),
              child: Text(
                "Everyday",
                style: TextStyle(
                    fontSize: 27,
                    fontWeight: FontWeight.bold,
                    color: AppColor.mediumBlue),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Text(
                "Tasks",
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
              ),
            ),
            StreamBuilder<QuerySnapshot?>(
              stream: homeRepository.getTaskData(
                  userInfo!.uid, "everyDay", "Pending"),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }
                if (snapshot.hasError) {
                  return Text("Error");
                } else {
                  print(snapshot.data!.docs.length);
                  return Expanded(
                    flex: 1,
                    child: ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 5),
                          child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: AppColor.offWhite),
                              child: Consumer<TaskViewViewModel>(
                                builder: (context, vm, child) {
                                  // Using Row instead of ListTile for more control
                                  return Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Radio(
                                        value: index,
                                        groupValue: vm.selectedIndex,
                                        onChanged: (value) {
                                          vm.radioSelectedIndex = value!;
                                        },
                                      ),
                                      Container(
                                        width: WidthY * 0.53,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(snapshot.data!.docs[index]
                                                ["title"]),
                                            Text(snapshot.data!.docs[index]
                                                ["desc"]),
                                          ],
                                        ),
                                      ),
                                      vm.selectedIndex == index
                                          ? Row(children: [
                                                Container(padding: EdgeInsets.all(5),
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5), color:
                                                            AppColor.orrange),
                                                    child: InkWell(
                                                        onTap: () {
                                                          homeRepository.deleteDoc(
                                                                  snapshot.data!.docs[index].id);
                                                        },
                                                        child: Icon(CupertinoIcons.delete,
                                                          color: AppColor.white,
                                                        ))),
                                                Container(padding: EdgeInsets.all(5),
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(5),
                                                        color: AppColor.mediumBlue),
                                                    child: InkWell(
                                                        onTap: () {
                                                          homeRepository.updateTaskStatus(
                                                                  snapshot.data!.docs[index].id);
                                                        },
                                                        child: Icon(Icons.check,
                                                          color: AppColor.white,
                                                        ))),
                                              ],
                                            )
                                          : Row(
                                              children: [
                                                Container(
                                                  height: 20,
                                                  width: 20,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: snapshot.data!.docs[index]
                                                                ["taskPriority"] == 1
                                                        ? AppColor.darkGreen
                                                        : snapshot.data!.docs[index]["taskPriority"] == 2
                                                            ? AppColor.yellow
                                                            : snapshot.data!.docs[index]
                                                                        ["taskPriority"] == 3
                                                                ? AppColor.red
                                                                : AppColor.black,
                                                  ),
                                                ),
                                                Container(
                                                    child: PopupMenuButton(
                                                  icon: Icon(Icons.more_vert),
                                                  onSelected: (value) {
                                                    if (value == "edit") {
                                                      titleController.text =
                                                          snapshot.data!.docs[index]["title"];
                                                      descController.text = snapshot.data!.docs[index]["desc"];
                                                      showModalBottomSheet(
                                                        isScrollControlled: true,
                                                        context: context,
                                                        builder: (context) {
                                                          return Container(
                                                            height: HeightX * 0.6,
                                                            width: WidthY * 1,
                                                            padding: EdgeInsets.all(20),
                                                            child: Column(
                                                              children: [
                                                                InputTextfield(
                                                                  borderColor: AppColor.black,
                                                                  editController: titleController,
                                                                  hintText: "Title",
                                                                  label: "Title",
                                                                  currentFocus: firstNode,
                                                                  nextFocus: secondNode,
                                                                  customPrefixIcon: Icon(Icons.task),
                                                                ),
                                                                InputTextfield(
                                                                  borderColor: AppColor.black,
                                                                  editController: descController,
                                                                  hintText: "Title",
                                                                  label: "Title",
                                                                  currentFocus: secondNode,
                                                                  nextFocus: secondNode,
                                                                  customPrefixIcon:
                                                                      Icon(Icons.description),
                                                                ),
                                                                Button(
                                                                  buttonHeight: HeightX * 0.07,
                                                                  buttonWidth: WidthY * 0.85,
                                                                  buttonText: "Update",
                                                                  buttonColor: AppColor.mediumBlue,
                                                                  buttonTextColor: AppColor.white,
                                                                  buttonOntap: () {
                                                                    homeRepository.updateTitleDesc(snapshot
                                                                            .data!.docs[index].id,
                                                                        titleController.text,
                                                                        descController.text);
                                                                  },
                                                                )
                                                              ],
                                                            ),
                                                          );
                                                        },
                                                      );
                                                    }
                                                  },
                                                  itemBuilder: (context) {
                                                    return [
                                                      PopupMenuItem<String>(
                                                          value: "edit",
                                                          child: Text("edit"))
                                                    ];
                                                  },
                                                )),
                                              ],
                                            ),
                                    ],
                                  );
                                },
                              )),
                        );
                      },
                    ),
                  );
                }
              },
            ),
            Text(
              "Completed",
              style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
            ),
            StreamBuilder<QuerySnapshot?>(
              stream: homeRepository.getTaskData(
                  userInfo!.uid, "everyDay", "Completed"),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }
                if (snapshot.hasError) {
                  return Text("Error");
                } else {
                  print(snapshot.data!.docs.length);
                  return Expanded(
                    flex: 1,
                    child: ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 5),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: AppColor.offWhite),
                            child: ListTile(
                                contentPadding: EdgeInsets.only(right: 7),
                                leading: Radio(
                                  value: 1,
                                  groupValue: 1,
                                  onChanged: (value) {},
                                ),
                                title: Text(
                                  snapshot.data!.docs[index]["title"],
                                  style: TextStyle(
                                      decoration: TextDecoration.lineThrough,
                                      decorationThickness: 3),
                                ),
                                subtitle: Text(
                                  snapshot.data!.docs[index]["desc"],
                                  style: TextStyle(
                                      decoration: TextDecoration.lineThrough,
                                      decorationThickness: 3),
                                ),
                                trailing: PopupMenuButton(
                                  icon: Icon(Icons.more_vert),
                                  onSelected: (value) {
                                    if (value == "delete") {
                                      homeRepository.deleteDoc(
                                          snapshot.data!.docs[index].id);
                                    }
                                  },
                                  itemBuilder: (context) {
                                    return [
                                      PopupMenuItem(
                                          value: "delete",
                                          child: Text("delete"))
                                    ];
                                  },
                                )),
                          ),
                        );
                      },
                    ),
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
