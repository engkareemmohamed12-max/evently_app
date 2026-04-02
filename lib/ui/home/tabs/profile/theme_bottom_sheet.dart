import 'package:evently_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../providers/language_provider.dart';
import '../../../../providers/theme_provider.dart';

class ThemeBottomSheet extends StatefulWidget {
  const ThemeBottomSheet({super.key});

  @override
  State<ThemeBottomSheet> createState() => _ThemeBottomSheetState();
}

class _ThemeBottomSheetState extends State<ThemeBottomSheet> {
  @override
  Widget build(BuildContext context) {
    var  themeProvider = Provider.of<ThemeProvider>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8
      ),
      child: Column(
        spacing: 16,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        //mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: (){
              //todo : change theme to dark
              themeProvider.changeTheme(ThemeMode.dark);
            },
            child: themeProvider.isDark?
            getSelectedLanguageWidget(language: AppLocalizations.of(context)!.dark):
            getUnSelectedLanguageWidget(language: AppLocalizations.of(context)!.dark),
          ),
      InkWell(
        onTap: (){
          //todo : change theme to light
          themeProvider.changeTheme(ThemeMode.light);
        },
        child: !(themeProvider.isDark)?
        getSelectedLanguageWidget(language: AppLocalizations.of(context)!.light):
        getUnSelectedLanguageWidget(language: AppLocalizations.of(context)!.light),
      )
        ],
      ),
    );
  }

  Widget getSelectedLanguageWidget({required String language}){

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(language,
          style: TextStyle(color: Colors.blue , fontSize: 16),
        ),
        Icon(Icons.check , size: 35, color: Colors.black,)
      ],
    );
  }

  Widget getUnSelectedLanguageWidget({required String language}){

    return Text(language,
      style: TextStyle(color: Colors.black , fontSize: 16),);
  }
}
