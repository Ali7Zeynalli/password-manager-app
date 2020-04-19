import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class General with ChangeNotifier {
  bool isDarkTheme = false;
  IconData _iconData;

  IconData get iconData => _iconData;

  set iconData(selectedIconData){
    this._iconData = selectedIconData;
    notifyListeners();
  }

  General() {
    loadDefaultTheme();
  }

  void loadDefaultTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isDarkTheme = prefs.getBool("is_dark_theme") ?? false;
    notifyListeners();
  }

  void reverseTheme() {
    isDarkTheme = !isDarkTheme;
    notifyListeners();
    saveThemePreference(isDarkTheme);
  }

  void saveThemePreference(bool isDarkTheme) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("is_dark_theme", isDarkTheme);
  }
}
