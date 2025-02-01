import 'package:flutter/material.dart';

class TaskViewViewModel with ChangeNotifier{
int? _selectedIndex;
int? get selectedIndex => _selectedIndex;

set radioSelectedIndex(int index){
  _selectedIndex=index;
  notifyListeners();
}

}