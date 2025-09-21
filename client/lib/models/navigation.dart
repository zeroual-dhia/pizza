import 'package:flutter/material.dart';

class NavigationProvider with ChangeNotifier {
  late int _selectedIndex;
  NavigationProvider() {
    _selectedIndex = 0;
  }

  int get selectedIndex => _selectedIndex;

  void changePage(index) {
    _selectedIndex = index;
    notifyListeners();
  }

  void reset() {
    _selectedIndex = 0;
  }
}
