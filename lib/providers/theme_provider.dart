import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {

  //todo: data
  ThemeMode appTheme = ThemeMode.light ;

  void changeTheme(ThemeMode newTheme){

    if(appTheme == newTheme){

      return ;
    }

    appTheme = newTheme;
    notifyListeners();

  }



  bool get isDark => appTheme == ThemeMode.dark;


}