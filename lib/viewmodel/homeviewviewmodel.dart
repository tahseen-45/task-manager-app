import 'dart:io';
import 'package:flutter/material.dart';
import 'package:internship_task/data/models/user_profile_data_model.dart';
import 'package:internship_task/repository/home_repository.dart';
import 'package:internship_task/repository/profile_repository.dart';
import 'package:intl/intl.dart';
class HomeViewViewModel with ChangeNotifier{


  UserProfileDataModel? _userProfileDataModel;
  UserProfileDataModel? get userProfileDataModel =>_userProfileDataModel;
  HomeRepository homeRepository=HomeRepository();
  bool _isLoading=true;
  bool get isLoading => _isLoading;
  int? _selectedIndex;
  int? get selectedIndex=>_selectedIndex;
  String? _currentDate;
  String? get currentDate => _currentDate;
  bool _everyDaySw=false;
  bool get everyDaySw => _everyDaySw;
  bool _todaySw=false;
  bool get toDaySw => _todaySw;
  double _taskPriority=0;
  double get taskPriority => _taskPriority;

  // Setter for everyDay type task
  set everyDaySwStatus(bool statusEveryDay){
    _everyDaySw=statusEveryDay;
    notifyListeners();
  }
  // Setter for today type task
  set toDaySwStatus(bool statusToDay){
    _todaySw=statusToDay;
    notifyListeners();
  }
  // Setter for priority level
  set taskPriorityLevel(double taskPri){
    _taskPriority=taskPri;
    notifyListeners();
  }

  ProfileRepository profileRepository=ProfileRepository();
  set loadingState(bool loadingStatus){
    _isLoading=loadingStatus;
    notifyListeners();
  }
  // Function to get current date
  void getCurrentDate(){
    DateFormat dateFormat=DateFormat("MMMM dd, yyyy");
    _currentDate=dateFormat.format(DateTime.now());
  }

  Future<void> getUserProfilefromModel(String userId)async{
    try{
      _userProfileDataModel=await profileRepository.getUserProfileData(userId);
      notifyListeners();

    }on SocketException{
      throw SocketException("No Internet");
    }

  }
  void onTapListen(int selectedIndex){
    _selectedIndex=selectedIndex;
    notifyListeners();
 }

}