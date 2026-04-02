import 'package:evently_app/l10n/app_localizations.dart';
import 'package:evently_app/ui/widget/custom_text_field.dart';
import 'package:flutter/material.dart';

import '../../../../main.dart';
import '../../widgets/event_item.dart';

class FavouriteTab extends StatelessWidget {
  const FavouriteTab({super.key});

  @override
  Widget build(BuildContext context) {
    var width = context.width;
    var height = context.height;
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
    );
  }
}
