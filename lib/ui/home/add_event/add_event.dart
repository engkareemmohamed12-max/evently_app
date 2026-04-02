import 'package:evently_app/l10n/app_localizations.dart';
import 'package:evently_app/providers/theme_provider.dart';
import 'package:evently_app/ui/home/widgets/tab_widget.dart';
import 'package:evently_app/ui/utils/app_assets.dart';
import 'package:evently_app/ui/utils/app_color.dart';
import 'package:evently_app/ui/utils/app_styles.dart';
import 'package:evently_app/ui/widget/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../main.dart';
import '../../utils/app_route.dart';

class AddEvent extends StatefulWidget {
   AddEvent({super.key});

  @override
  State<AddEvent> createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  List<String> eventImagesLightList = [

    AppAssets.sportImageLight,
    AppAssets.firstHomeImageLight,
    AppAssets.meetingImageLight,
    AppAssets.bookImageLight,
    AppAssets.exhibitionImageLight,
  ];

  List<String> eventImagesDarkList = [

    AppAssets.sportImageDark,
    AppAssets.firstHomeImageDark,
    AppAssets.meetingImageDark,
    AppAssets.bookImageDark,
    AppAssets.exhibitionImageDark,
  ];

  List<String> eventNamesList = [];



  int selectedIndex = 0 ;

  @override
  Widget build(BuildContext context) {

     eventNamesList = [
      AppLocalizations.of(context)!.sport,
      AppLocalizations.of(context)!.birthday,
      AppLocalizations.of(context)!.meeting,
      AppLocalizations.of(context)!.book_club,
      AppLocalizations.of(context)!.exhibition

    ];

    var width = context.width;
    var height = context.height;
    var themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(

      appBar: AppBar(
        toolbarHeight: height*0.10,
        leading: Container(
          margin: EdgeInsets.symmetric(
            horizontal: width*0.01,
            vertical: height*0.02
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadiusGeometry.circular(8),
            border: Border.all(
              color: Theme.of(context).dividerColor,
              width: 2
            ),
          ),
          child: IconButton(onPressed: (){

            Navigator.pushReplacementNamed(context, AppRoute.homeRouteName);

          }, icon: Icon(Icons.arrow_back_ios_new_outlined ,
          color: themeProvider.isDark ? AppColors.whiteColor : AppColors.blackColor ,
          )
          ),
        ),

        title: Text(AppLocalizations.of(context)!.add_event , style: Theme.of(context).textTheme.titleSmall,),
      ),

      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width*0.04,
          vertical: height*0.01,
          
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: height*0.02,
            children: [
              SizedBox(
                width: double.infinity,
                height: height * 0.25,
                child: Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadiusGeometry.circular(24),
                    border: Border.all(
                      color: Theme.of(context).dividerColor
                    ),
                  ),
          
                  child: Image.asset(
                    themeProvider.isDark ? eventImagesDarkList[selectedIndex] : eventImagesLightList[selectedIndex],
                    fit: BoxFit.cover,
                  ),
          
                ),
          
          
          
              ),
          
              SizedBox(
                height: height * 0.05,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: eventNamesList.length,
                  separatorBuilder: (_, __) => SizedBox(width: 12),
                  itemBuilder: (context, index) {
                    bool isSelected = index == selectedIndex;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: isSelected
                              ? Theme.of(context).primaryColor
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: isSelected
                                ? Theme.of(context).primaryColor
                                : Theme.of(context).dividerColor,
                          ),
                        ),
                        child: Text(
                          eventNamesList[index],
                          textAlign: TextAlign.center,
                          style: isSelected
                              ? AppStyle.medium16White
                              : Theme.of(context).textTheme.headlineMedium,
                        ),
                      ),
                    );
                  },
                ),
              ),
          
              Text(AppLocalizations.of(context)!.title ,
          
              style: Theme.of(context).textTheme.headlineMedium,
              ),
          
              CustomTextField(
          
                hintText: AppLocalizations.of(context)!.event_title,
                hintStyle: Theme.of(context).textTheme.bodyLarge,
              ),
          
          
              Text(AppLocalizations.of(context)!.title ,
          
                style: Theme.of(context).textTheme.headlineMedium,
              ),
          
              CustomTextField(
          
                hintText: AppLocalizations.of(context)!.event_description,
                hintStyle: Theme.of(context).textTheme.bodyLarge,
                maxLines: 5,
              ),
          
            ],
          ),
        ),
      ),


    );
  }
}
