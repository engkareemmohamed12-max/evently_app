import 'package:evently_app/ui/utils/app_color.dart';
import 'package:flutter/material.dart';

import '../../../main.dart';

class TabItemWidget extends StatelessWidget {
  final Color selectedColor ;
  final Color unSelectedColor ;
  final Color selectedBorderColor ;
  final Color unSelectedBorderColor ;
  final bool isSelected;
  final String eventName;
  final TextStyle? selectedTextStyle;
  final TextStyle? unSelectedTextStyle;
  final IconData? icon;
  final Color? selectedIcon ;
  final Color? unSelectedIcon ;
  const TabItemWidget({super.key , required this.selectedColor , required this.unSelectedColor ,
  required this.selectedBorderColor , required this.unSelectedBorderColor , required this.isSelected , required this.eventName,
    required this.selectedTextStyle , required this.unSelectedTextStyle ,  this.icon ,  this.selectedIcon ,
     this.unSelectedIcon
  });

  @override
  Widget build(BuildContext context) {
    var width = context.width;
    var height = context.height;
    return Container(

      padding: EdgeInsets.symmetric(
        vertical: height*0.01,
        horizontal: width*0.04
      ),

      decoration: BoxDecoration(
        borderRadius: BorderRadiusGeometry.circular(16),
        color: isSelected ? selectedColor : unSelectedColor,
        border: Border.all(
          color: isSelected ? selectedBorderColor : unSelectedBorderColor,
          width: 2
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 18,
            color: isSelected
                ? selectedIcon : unSelectedIcon
          ),
          SizedBox(width: 6),
          Text(
            eventName,
            style: isSelected ? selectedTextStyle : unSelectedTextStyle,
          ),
        ],
      ),


      
    );
  }
}
