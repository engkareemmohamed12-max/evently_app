import 'package:evently_app/l10n/app_localizations.dart';
import 'package:evently_app/model/event.dart';
import 'package:evently_app/providers/event_list_provider.dart';
import 'package:evently_app/providers/theme_provider.dart';
import 'package:evently_app/ui/home/tabs/events_details/edit_event.dart';
import 'package:evently_app/ui/utils/app_color.dart';
import 'package:evently_app/ui/utils/app_route.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EventDetails extends StatelessWidget {
  final Event event;

  const EventDetails({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    var themeProvider = Provider.of<ThemeProvider>(context);
    var eventListProvider = Provider.of<EventListProvider>(context);

    Event updatedEvent = eventListProvider.eventList.firstWhere(
          (e) => e.id == event.id,
      orElse: () => event,
    );

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: height * 0.10,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_new_outlined,
            color: themeProvider.isDark
                ? AppColors.whiteColor
                : AppColors.blackColor,
          ),
        ),
        title: Text(
          AppLocalizations.of(context)!.event_details,
          style: Theme.of(context).textTheme.titleSmall,
        ),
        actions: [
          IconButton(
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditEvent(event: updatedEvent),
                ),
              );
            },
            icon: Icon(Icons.edit_outlined,
                color: Theme.of(context).cardColor),
          ),
          IconButton(
            onPressed: () {
              eventListProvider.deleteEvent(event);
              Navigator.pushNamed(context, AppRoute.homeRouteName);
            },
            icon: Icon(Icons.delete_outline,
                color: Theme.of(context).cardColor),
          ),
        ],
      ),

      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: width * 0.04, vertical: height * 0.01),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                width: double.infinity,
                height: height * 0.25,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: Image.asset(updatedEvent.eventImage,
                      fit: BoxFit.cover),
                ),
              ),

              SizedBox(height: height * 0.02),

              Text(
                updatedEvent.title,
                style: Theme.of(context).textTheme.headlineMedium,
              ),

              SizedBox(height: height * 0.04),

              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Theme.of(context)
                          .cardColor
                          .withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      Icons.calendar_month,
                      color: Theme.of(context).cardColor,
                    ),
                  ),

                  SizedBox(width: width * 0.04),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        DateFormat('MMM d, yyyy')
                            .format(updatedEvent.eventDate),
                        style:
                        Theme.of(context).textTheme.headlineMedium,
                      ),
                      SizedBox(height: 4),
                      Text(
                        updatedEvent.eventTime,
                        style:
                        Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                ],
              ),

              SizedBox(height: height * 0.04),

              Text(
                updatedEvent.description,
                style: Theme.of(context).textTheme.bodyLarge,
                maxLines: 4,
              ),
            ],
          ),
        ),
      ),
    );
  }
}