import 'package:evently_app/l10n/app_localizations.dart';
import 'package:evently_app/ui/utils/screen_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../providers/language_provider.dart';

class LanguageBottomSheet extends StatefulWidget {
  const LanguageBottomSheet({super.key});

  @override
  State<LanguageBottomSheet> createState() => _LanguageBottomSheetState();
}

class _LanguageBottomSheetState extends State<LanguageBottomSheet> {
  @override
  Widget build(BuildContext context) {
    var width = context.width;
    var height = context.height;
    var languageProvider = Provider.of<LanguageProvider>(context);
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: width*0.04,
        vertical: height*0.02
      ),
      child: Column(
        spacing: 16,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: (){
              //todo : change language to En
              languageProvider.changeLanguage('en');
            },
            child: languageProvider.appLanguage == 'en' ?
            getSelectedLanguageWidget(language: AppLocalizations.of(context)!.english):
            getUnSelectedLanguageWidget(language: AppLocalizations.of(context)!.english),
          ),
      InkWell(
        onTap: (){
          //todo : change language to Ar
          languageProvider.changeLanguage('ar');
        },
        child: languageProvider.appLanguage == 'ar'?
        getSelectedLanguageWidget(language: AppLocalizations.of(context)!.arabic):
        getUnSelectedLanguageWidget(language: AppLocalizations.of(context)!.arabic),
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
