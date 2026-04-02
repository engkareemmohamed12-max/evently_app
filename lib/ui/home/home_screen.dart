import 'package:evently_app/l10n/app_localizations.dart';
import 'package:evently_app/ui/home/tabs/favourite/favourite_tab.dart';
import 'package:evently_app/ui/home/tabs/home/home_tab.dart';
import 'package:evently_app/ui/home/tabs/profile/profile_tab.dart';
import 'package:evently_app/ui/utils/app_color.dart';
import 'package:flutter/material.dart';

import '../utils/app_route.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0 ;
  List<Widget> tabsList = [

    HomeTabTab() , FavouriteTab() , ProfileTab()

  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(




      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,

          onTap: (index){

          selectedIndex = index;
          setState(() {

          });

          },

          items: [

           _builtBottomNavBarItem(
               unSelectedIconName: Icon(Icons.home_outlined),
               selectedIconName: Icon(Icons.home),
               isSelected: selectedIndex == 0,
             label: AppLocalizations.of(context)!.home,
           ),

            _builtBottomNavBarItem(
                unSelectedIconName: Icon(Icons.favorite_border_outlined),
                selectedIconName: Icon(Icons.favorite),
                isSelected: selectedIndex == 1,
              label: AppLocalizations.of(context)!.fav,
            ),

            _builtBottomNavBarItem(
                unSelectedIconName: Icon(Icons.person_2_outlined),
               selectedIconName: Icon(Icons.person),
                isSelected: selectedIndex == 2,
              label: AppLocalizations.of(context)!.profile,
            ),
          ]
      ),

      body: tabsList[selectedIndex],

      floatingActionButton: FloatingActionButton(onPressed: (){

        //todo : navigate to add event screen
        Navigator.pushNamed(context, AppRoute.addEventRouteName);

      },

      child: Icon(Icons.add , size: 30, color: AppColors.whiteColor,),
      ),

    );
  }

  BottomNavigationBarItem _builtBottomNavBarItem({
    required Widget selectedIconName, required Widget unSelectedIconName, required bool isSelected , required String label

}){
    return BottomNavigationBarItem(icon:

        isSelected ? selectedIconName : unSelectedIconName ,
      label: label
    );
  }
}
