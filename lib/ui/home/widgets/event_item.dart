import 'package:evently_app/providers/theme_provider.dart';
import 'package:evently_app/ui/utils/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../main.dart';

class EventItem extends StatelessWidget {
  const EventItem({super.key});

  @override
  Widget build(BuildContext context) {
    var width = context.width;
    var height = context.height;
    var themeProvider = Provider.of<ThemeProvider>(context);
    return Container(
      height: height*0.20,
      padding: EdgeInsets.symmetric(
        horizontal: width*0.02,
            vertical: height*0.01
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadiusGeometry.circular(16),
        border: Border.all(
          color: Theme.of(context).dividerColor,
          width: 2
        ),
        image: DecorationImage(

        fit: BoxFit.fill,
         image: AssetImage(

           themeProvider.isDark ? AppAssets.firstHomeImageDark : AppAssets.firstHomeImageLight

        )),
      ),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

      Container(
        padding: EdgeInsets.symmetric(
          horizontal: width*0.02,
        ),
      decoration: BoxDecoration(
      borderRadius: BorderRadiusGeometry.circular(8),
      border: Border.all(
          color: Theme.of(context).dividerColor,
          width: 2
      ),
    ),
      
      child: Text('17 Jan' ,

      style: Theme.of(context).textTheme.bodyMedium,
      ),
      ),

          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadiusGeometry.circular(8),
              border: Border.all(
                  color: Theme.of(context).dividerColor,
                  width: 2
              ),
            ),

            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text('This is a Birthday Party' ,

                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),

                IconButton(onPressed: (){

                  //todo: add favourite

                }, icon:
                Icon(Icons.favorite_border_outlined ,  color: Theme.of(context).cardColor,)
                ),
                
              ],
            ),
          ),
        ],
      ),

    );
  }
}
