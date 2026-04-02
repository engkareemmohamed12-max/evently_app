import 'package:evently_app/l10n/app_localizations.dart';
import 'package:evently_app/main.dart';
import 'package:evently_app/providers/language_provider.dart';
import 'package:evently_app/providers/theme_provider.dart';
import 'package:evently_app/ui/home/widgets/event_item.dart';
import 'package:evently_app/ui/home/widgets/tab_widget.dart';
import 'package:evently_app/ui/utils/app_color.dart';
import 'package:evently_app/ui/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeTabTab extends StatefulWidget {
   HomeTabTab({super.key});

  @override
  State<HomeTabTab> createState() => _HomeTabTabState();
}

class _HomeTabTabState extends State<HomeTabTab> {
   int selectedIndex = 0 ;

  @override
  Widget build(BuildContext context) {
    var width = context.width;
    var height = context.height;
    var themeProvider = Provider.of<ThemeProvider>(context);
    var languageProvider = Provider.of<LanguageProvider>(context);

    List<String> eventNamesList = [
      AppLocalizations.of(context)!.all,
      AppLocalizations.of(context)!.sport,
      AppLocalizations.of(context)!.birthday,
      AppLocalizations.of(context)!.meeting,
      AppLocalizations.of(context)!.book_club,
      AppLocalizations.of(context)!.exhibition

    ];
    return SafeArea(
      child: Padding(
        padding: EdgeInsetsGeometry.symmetric(
          horizontal: width*0.04,
          vertical: height*0.04
        ),
        child: DefaultTabController(
            length: eventNamesList.length,
            child: Column(
              spacing: height*0.02,

              children: [

                Row(
                  spacing: width*0.02,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(AppLocalizations.of(context)!.welcome_back ,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        Text('Route Academy' ,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ],
                    ),
                    Spacer(),
                    Icon(themeProvider.isDark?
                    Icons.dark_mode_outlined :
                    Icons.light_mode_outlined,
                      color: Theme.of(context).cardColor ,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadiusGeometry.circular(8),
                          color: Theme.of(context).cardColor
                      ),
                      padding: EdgeInsetsGeometry.symmetric(
                          vertical: height*0.01,
                          horizontal: width*0.02
                      ),
                      child: Text(languageProvider.appLanguage.toUpperCase() ,
                        style: AppStyle.semi14WhiteColor,
                      ),
                    ),
                  ],
                ),

                TabBar(
                  dividerColor: AppColors.transparentColor,
                  isScrollable: true,
                  indicatorColor: AppColors.transparentColor,
                  labelPadding: EdgeInsets.symmetric(
                    horizontal: width*0.02
                  ),

                  onTap: (index){

                    selectedIndex = index;
                    setState(() {

                    });
                  },

                  tabAlignment: TabAlignment.start,
                  tabs: eventNamesList.map((eventName) {

                    IconData icon;

                    if (eventName == AppLocalizations.of(context)!.all) {
                      icon = Icons.grid_view;
                    } else if (eventName == AppLocalizations.of(context)!.sport) {
                      icon = Icons.sports_soccer;
                    } else if (eventName == AppLocalizations.of(context)!.birthday) {
                      icon = Icons.cake;
                    } else if (eventName == AppLocalizations.of(context)!.meeting) {
                      icon = Icons.meeting_room;
                    } else if (eventName == AppLocalizations.of(context)!.book_club) {
                      icon = Icons.menu_book;
                    } else {
                      icon = Icons.image;
                    }

                    return TabItemWidget(
                      selectedColor: Theme.of(context).cardColor,
                      unSelectedColor: AppColors.transparentColor,
                      selectedBorderColor: AppColors.transparentColor,
                      unSelectedBorderColor: Theme.of(context).dividerColor,
                      isSelected: selectedIndex == eventNamesList.indexOf(eventName),
                      eventName: eventName,
                      icon: icon,
                      selectedTextStyle: AppStyle.medium16White,
                      unSelectedTextStyle: Theme.of(context).textTheme.headlineMedium,
                      selectedIcon: AppColors.whiteColor,
                      unSelectedIcon: Theme.of(context).cardColor,
                    );
                  }).toList(),
                ),

                Expanded(child: ListView.separated(
                    itemBuilder: (context, index) {
                      return EventItem();
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(height: height*0.02,);
                    },
                    itemCount: 20
                )),

              ],
            ),
        ),
      ),
    );


  }
}
