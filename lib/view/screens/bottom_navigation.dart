import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:internship_task/res/colors.dart';
import 'package:internship_task/viewmodel/bottom_nav_view_model.dart';
import 'package:provider/provider.dart';

// Manages Bottom navigation
class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  List<Widget> iconList = [];
  @override
  Widget build(BuildContext context) {
    final bottomNavViewModel =
        Provider.of<BottomNavViewModel>(context, listen: false);
    // Setting canPop to false so the user cannot use his/her phone physical
    // back button
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: Consumer<BottomNavViewModel>(
          builder: (context, vm, child) {
            return vm.screenList[vm.currentIndex];
          },
        ),
        bottomNavigationBar: CurvedNavigationBar(
          items: bottomNavViewModel.iconList,
          color: AppColor.mediumBlue.withOpacity(0.8),
          backgroundColor: Colors.transparent,
          height: MediaQuery.of(context).size.height * 0.07,
          buttonBackgroundColor: AppColor.blue,
          onTap: (value) {
            bottomNavViewModel.changeCurrentIndex(value);
          },
        ),
        extendBody: true,
      ),
    );
  }
}
