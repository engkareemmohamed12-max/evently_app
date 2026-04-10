import 'package:evently_app/l10n/app_localizations.dart';
import 'package:evently_app/providers/event_list_provider.dart';
import 'package:evently_app/ui/widget/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../main.dart';
import '../../widgets/event_item.dart';

class FavouriteTab extends StatefulWidget {
  const FavouriteTab({super.key});

  @override
  State<FavouriteTab> createState() => _FavouriteTabState();
}

class _FavouriteTabState extends State<FavouriteTab> {
  late EventListProvider eventListProvider ;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      eventListProvider.getAllFavoriteEvents();
    },);
  }

  @override
  Widget build(BuildContext context) {
    var width = context.width;
    var height = context.height;
    eventListProvider = Provider.of<EventListProvider>(context);
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width*0.04,
          vertical: height*0.02
        ),
        child: Column(
          spacing: height*0.04,
          children: [
            CustomTextField(
              hintStyle: Theme.of(context).textTheme.bodyLarge,
              hintText: AppLocalizations.of(context)!.search_event,
              suffixIcons: Icon(Icons.search_outlined , size: 35 , color: Theme.of(context).cardColor,),
            ),

            Expanded(child:

                eventListProvider.favoriteList.isEmpty ?
                    Center(child: Text(AppLocalizations.of(context)!.no_favorite_events_found ,
                    style: Theme.of(context).textTheme.headlineLarge,
                    ),)

                :
            ListView.separated(
                itemBuilder: (context, index) {
                  return EventItem(event: eventListProvider.favoriteList[index]);
                },
                separatorBuilder: (context, index) {
                  return SizedBox(height: height*0.02,);
                },
                itemCount: eventListProvider.favoriteList.length
            )),
          ],
        ),
      ),
    );
  }
}
