import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:internship_task/data/network/network_data_services.dart';
import 'package:internship_task/res/colors.dart';
import 'package:internship_task/res/components/overlay.dart';
import 'package:internship_task/utils/utils.dart';
import 'package:overlay_kit/overlay_kit.dart';

class HomeRepository {
  NetworkDataServices networkDataServices = NetworkDataServices();
  // function to add User's Task data to firebase firestore
  Future<void> addTaskData(
      String userId,
      String title,
      String desc,
      String category,
      double taskPriority,
      bool everyDay,
      bool today,
      BuildContext context) async {
    final HeightX = MediaQuery.of(context).size.height;
    final WidthY = MediaQuery.of(context).size.width;
    OverlayLoadingProgress.start(
      barrierDismissible: false,
      barrierColor: AppColor.black.withOpacity(0.5),
      // Custom Overlay widget
      widget: CustomOverlay(
        containerText: "Adding your task...",
        containerHeight: HeightX * 0.05,
        containerWidth: WidthY * 0.7,
      ),
    );
    // using the service class function for adding user task data
    await networkDataServices.addCollectionDocFields("userstasks", {
      "userId": userId,
      "title": title,
      "desc": desc,
      "category": category,
      "taskPriority": taskPriority,
      "everyDay": everyDay,
      "today": today,
      "taskStatus": "Pending"
    }).catchError((error) {
      OverlayLoadingProgress.stop();
      Utils.flutterToast(error.toString());
    }).then(
      (value) {
        OverlayLoadingProgress.stop();
        Utils.flutterToast("Your task has been added successfully");
      },
    );
  }
  // this function checks all the validations regarding task entry it also
  // restrict the user to select both the task types(everyday and today)
  void addTaskFormValidation(
      String userId,
      String title,
      String desc,
      String category,
      double taskPriority,
      bool everyDay,
      bool today,
      BuildContext context) {
    if (title.isEmpty) {
      Utils.flutterToast("Please enter task title");
    } else if (desc.isEmpty) {
      Utils.flutterToast("Please enter task description");
    } else if (category.isEmpty) {
      Utils.flutterToast("Please enter task category");
    } else if (taskPriority == 0) {
      Utils.flutterToast("Please select task priority");
    } else if (everyDay == true && today == true) {
      Utils.flutterToast("Please select task either every day or today only");
    } else if (everyDay == false && today == false) {
      Utils.flutterToast("Please select task one task type");
    } else {
      addTaskData(userId, title, desc, category, taskPriority, everyDay, today,
          context);
    }
  }
  // function to fetch Task data based on certain criteria it takes key
  // and some values as parameters and return stream
  Stream<QuerySnapshot?> getTaskData(
      String userId, String taskType, String taskStatus) {
    try {
      Stream<QuerySnapshot> snapshot = FirebaseFirestore.instance
          .collection("userstasks")
          .where("userId", isEqualTo: userId)
          .where(taskType, isEqualTo: true)
          .where("taskStatus", isEqualTo: taskStatus)
          .snapshots();
      return snapshot;
    } catch (e) {
      Utils.flutterToast(e.toString());
      return Stream.empty();
    }
  }
  // deletes the task document base on documentId
  Future<void> deleteDoc(String docId) async {
    try {
      await FirebaseFirestore.instance
          .collection("userstasks")
          .doc(docId)
          .delete();
      Utils.flutterToast("Task has been deleted successfully");
    } catch (e) {
      Utils.flutterToast(e.toString());
    }
  }
  // mark the taskStatus field of a specific document as Completed
  Future<void> updateTaskStatus(String docId) async {
    try {
      await FirebaseFirestore.instance
          .collection("userstasks")
          .doc(docId)
          .update({"taskStatus": "Completed"});
    } catch (e) {
      Utils.flutterToast(e.toString());
    }
  }
  // updates the title and description of specific task
  Future<void> updateTitleDesc(String docId, String title, String desc) async {
    try {
      await FirebaseFirestore.instance
          .collection("userstasks")
          .doc(docId)
          .update({"title": title, "desc": desc});
      Utils.flutterToast("Updated Successfully");
    } catch (e) {
      Utils.flutterToast(e.toString());
    }
  }
}
