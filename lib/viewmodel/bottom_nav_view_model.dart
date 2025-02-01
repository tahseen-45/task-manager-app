import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internship_task/res/colors.dart';
import 'package:internship_task/view/screens/dashboard_screen.dart';
import 'package:internship_task/view/screens/task_screen.dart';
import 'package:internship_task/view/screens/task_screen_today.dart';

class BottomNavViewModel with ChangeNotifier {
  // List of Screens
  List<Widget> _screensList = [
    DashboardScreen(),
    TaskScreenEveryDay(),
    TaskScreenToDay()
  ];
  // List of Icons
  List<Widget> iconList = [
    Icon(
      Icons.home_filled,
      color: AppColor.white,
    ),
    Icon(
      Icons.calendar_month_rounded,
      color: AppColor.white,
    ),
    Icon(
      CupertinoIcons.today,
      color: AppColor.white,
    ),
  ];
  int _currentIndex = 0;
  List<Widget> get screenList => _screensList;
  int get currentIndex => _currentIndex;

  void changeCurrentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }
}
