import 'package:evently_app/providers/event_list_provider.dart';
import 'package:evently_app/providers/theme_provider.dart';
import 'package:evently_app/ui/utils/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../main.dart';
import '../../../model/event.dart';

class EventItem extends StatelessWidget {
  final Event event ;
  const EventItem({super.key , required this.event});

  @override
  Widget build(BuildContext context) {
    var width = context.width;
    var height = context.height;
    var themeProvider = Provider.of<ThemeProvider>(context);
    var eventListProvider = Provider.of<EventListProvider>(context);
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

           event.eventImage

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

      child: Text( DateFormat('d MMM').format(event.eventDate) ,


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
                  child: Text(event.title ,

                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),

                IconButton(onPressed: (){

                  //todo: add favourite
                  eventListProvider.updateIsFavorite(event);

                }, icon:
                Icon(

                  event.isFavorite?
                      Icons.favorite
                      :
                  Icons.favorite_border_outlined ,  color: Theme.of(context).cardColor,)
                ),
                
              ],
            ),
          ),
        ],
      ),

    );
  }
}
