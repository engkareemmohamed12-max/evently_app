import 'package:evently_app/l10n/app_localizations.dart';
import 'package:evently_app/main.dart';
import 'package:evently_app/providers/theme_provider.dart';
import 'package:evently_app/ui/home/tabs/profile/language_bottom_sheet.dart';
import 'package:evently_app/ui/home/tabs/profile/theme_bottom_sheet.dart';
import 'package:evently_app/ui/utils/app_assets.dart';
import 'package:evently_app/ui/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    var width = context.width;
    var height = context.height;
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width*0.04,
          vertical: height*0.08,
        ),
        child: Column(
          spacing: height*0.02,
          children: [
            CircleAvatar(
              radius: 100,
              backgroundImage: AssetImage(AppAssets.profilelogo),
            ),
            Text('Route Academy' ,
            style: Theme.of(context).textTheme.headlineLarge,
            ),
            Text('routeAcademy@gmail.com' ,
            style: Theme.of(context).textTheme.bodyLarge,
            ),
            _builtProfileTabItem(
                isDark: themeProvider.isDark,
                title: AppLocalizations.of(context)!.dark_mode,
                child: Switch(
                  activeThumbColor: AppColors.whiteColor,
                    activeTrackColor: AppColors.mainColordark,
                    inactiveThumbColor: AppColors.whiteColor,
                    inactiveTrackColor: AppColors.lightGreyColor,
                    trackOutlineColor: WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
                      if (states.contains(WidgetState.selected)) {
                        return AppColors.transparentColor;
                      }
                      return AppColors.lightGreyColor;
                    }),
                    value: themeProvider.isDark,
                    onChanged: (value) {
                      themeProvider.changeTheme(value? ThemeMode.dark : ThemeMode.light);
                    },

                ),
            ),
        _builtProfileTabItem(
          isDark: themeProvider.isDark,
          title: AppLocalizations.of(context)!.language,
          child: IconButton(onPressed: (){
            showLanguageBottomSheet();
          },
              icon:
          Icon(Icons.arrow_forward_ios_outlined ,
            color: themeProvider.isDark ? AppColors.mainColordark : AppColors.mainColorlight,))

        ),

            _builtProfileTabItem(
              isDark: themeProvider.isDark,
              title: AppLocalizations.of(context)!.logout,
              child: IconButton(onPressed: (){
                //todo: logout
              },
                  icon: Icon(Icons.logout ,
                  size: 35, color: AppColors.redColor,
                  ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _builtProfileTabItem({
    required bool isDark,
    required String title,
    required Widget child

}){

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? AppColors.strokeDarkColor : AppColors.strokeWhiteColor,
          width: 2
        )
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(
          horizontal: context.width*0.02
        ),
        title: Text( title ,
        style: Theme.of(context).textTheme.headlineMedium,
        ),
        trailing: child,
      ),
    );

  }

  void showLanguageBottomSheet() {

    showModalBottomSheet(
        context: context,
        builder: (context) => LanguageBottomSheet(),
    );
  }

  void showThemeBottomSheet() {

    showModalBottomSheet(
      context: context,
      builder: (context) => ThemeBottomSheet(),
    );
  }


}

