import 'package:evently_app/ui/utils/app_color.dart';
import 'package:evently_app/ui/utils/app_styles.dart';
import 'package:flutter/material.dart';

class AppTheme {

  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.bgColorLight,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.whiteColor,
      selectedItemColor: AppColors.mainColorlight,
      unselectedItemColor: AppColors.lightGreyColor
    ),
      floatingActionButtonTheme: (FloatingActionButtonThemeData(

        backgroundColor: AppColors.mainColorlight,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(50)
        )

      )),
      appBarTheme: AppBarThemeData(
        backgroundColor: AppColors.transparentColor,
        centerTitle: true,

      ),

      cardColor: AppColors.mainColorlight,
      dividerColor: AppColors.strokeWhiteColor,
    textTheme: TextTheme(
      headlineLarge: AppStyle.semi20black,
      bodyLarge: AppStyle.regular14WhiteDarkColor,
      bodyMedium: AppStyle.semi16MainLight,
        bodySmall: AppStyle.medium14Dark,
        headlineMedium: AppStyle.medium16Black,
        headlineSmall: AppStyle.semi24White,
        labelMedium: AppStyle.medium16MainLightColor,
        labelSmall: AppStyle.medium18MainLightColor,
        labelLarge: AppStyle.semi14MainLightColor,
      titleMedium: AppStyle.regular14GreyColor,
      titleLarge: AppStyle.medium20BlackColor,
        titleSmall: AppStyle.medium18Dark,

    )

  );

  static final ThemeData darkTheme = ThemeData(

      scaffoldBackgroundColor: AppColors.bgColorDark ,

      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: AppColors.bgColorDark,
          selectedItemColor: AppColors.mainColordark,
          unselectedItemColor: AppColors.lightGreyColor
      ),
      floatingActionButtonTheme: (FloatingActionButtonThemeData(

          backgroundColor: AppColors.mainColordark,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.circular(50) )

      )),
      appBarTheme: AppBarThemeData(
          backgroundColor: AppColors.transparentColor,
          centerTitle: true
      ),
      cardColor: AppColors.mainColordark,
      dividerColor: AppColors.mainColordark,

      textTheme: TextTheme(
          headlineLarge: AppStyle.semi20white,
          bodyLarge: AppStyle.regular14GreyColor,
          bodyMedium: AppStyle.semi16MainDak,
          bodySmall: AppStyle.medium14White,
          headlineMedium: AppStyle.medium16White,
        headlineSmall: AppStyle.semi24Black,
        labelMedium: AppStyle.medium16MainDarkColor,
        labelSmall: AppStyle.medium18MainDarkColor,
        labelLarge: AppStyle.semi14MainDarkColor,
        titleMedium: AppStyle.regular14WhiteDarkColor,
          titleLarge: AppStyle.medium20WhiteDarkColor,
          titleSmall: AppStyle.medium18White,





      )


  );
}