import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently_app/firebase_utils.dart';
import 'package:evently_app/l10n/app_localizations.dart';
import 'package:evently_app/model/event.dart';
import 'package:evently_app/providers/event_list_provider.dart';
import 'package:evently_app/providers/theme_provider.dart';
import 'package:evently_app/ui/home/add_event/date_or_time_widget.dart';
import 'package:evently_app/ui/utils/app_assets.dart';
import 'package:evently_app/ui/utils/app_color.dart';
import 'package:evently_app/ui/utils/app_styles.dart';
import 'package:evently_app/ui/utils/toast_utils.dart';
import 'package:evently_app/ui/widget/custom_elevated_button.dart';
import 'package:evently_app/ui/widget/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EditEvent extends StatefulWidget {
  final Event event;

  const EditEvent({super.key, required this.event});

  @override
  State<EditEvent> createState() => _EditEventState();
}

class _EditEventState extends State<EditEvent> {

  late TextEditingController titleController;
  late TextEditingController descriptionController;

  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  String formatDate = '';
  String formatTime = '';

  String? dateError;
  String? timeError;

  int selectedIndex = 0;

  late EventListProvider eventListProvider;

  List<String> eventNamesList = [];
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

  @override
  void initState() {
    super.initState();

    titleController = TextEditingController(text: widget.event.title);
    descriptionController = TextEditingController(text: widget.event.description);

    selectedDate = widget.event.eventDate;
    formatDate = DateFormat('MMM d, yyyy').format(selectedDate!);

    formatTime = widget.event.eventTime;
  }

  @override
  Widget build(BuildContext context) {

    var themeProvider = Provider.of<ThemeProvider>(context);
    eventListProvider = Provider.of<EventListProvider>(context);

    eventNamesList = [
      AppLocalizations.of(context)!.sport,
      AppLocalizations.of(context)!.birthday,
      AppLocalizations.of(context)!.meeting,
      AppLocalizations.of(context)!.book_club,
      AppLocalizations.of(context)!.exhibition
    ];

    selectedIndex = eventNamesList.indexOf(widget.event.eventName);
    if (selectedIndex == -1) selectedIndex = 0;

    String selectedImage = themeProvider.isDark
        ? eventImagesDarkList[selectedIndex]
        : eventImagesLightList[selectedIndex];

    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.edit_event),
      ),

      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.04,
          vertical: height * 0.02,
        ),

        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [


              Container(
                height: height * 0.25,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                clipBehavior: Clip.antiAlias,
                child: Image.asset(selectedImage, fit: BoxFit.cover),
              ),

              SizedBox(height: height * 0.02),

              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  labelText: "Title",
                ),
              ),

              SizedBox(height: height * 0.02),

              TextField(
                controller: descriptionController,
                maxLines: 4,
                decoration: InputDecoration(
                  labelText: "Description",
                ),
              ),

              SizedBox(height: height * 0.02),

              ListTile(
                title: Text(formatDate.isEmpty ? "Choose Date" : formatDate),
                trailing: Icon(Icons.date_range),
                onTap: chooseDate,
              ),

              if (dateError != null)
                Text(dateError!, style: TextStyle(color: Colors.red)),

              ListTile(
                title: Text(formatTime.isEmpty ? "Choose Time" : formatTime),
                trailing: Icon(Icons.access_time),
                onTap: chooseTime,
              ),

              if (timeError != null)
                Text(timeError!, style: TextStyle(color: Colors.red)),

              SizedBox(height: height * 0.03),

              CustomElevatedButton(
                onPressed: updateEvent,
                verticalPadding: height*0.01,
                backgroundColor: Theme.of(context).primaryColor,
                child: Text(AppLocalizations.of(context)!.update_event , style: AppStyle.medium20White,),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void chooseDate() async {
    var picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;
        formatDate = DateFormat('MMM d, yyyy').format(picked);
        dateError = null;
      });
    }
  }

  void chooseTime() async {
    var picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (picked != null) {
      setState(() {
        selectedTime = picked;
        formatTime = picked.format(context);
        timeError = null;
      });
    }
  }

  void updateEvent() {

    bool valid = true;

    if (selectedDate == null) {
      dateError = "Choose date";
      valid = false;
    }

    if (formatTime.isEmpty) {
      timeError = "Choose time";
      valid = false;
    }

    setState(() {});

    if (!valid) return;

    Event updatedEvent = Event(
      id: widget.event.id,
      title: titleController.text,
      description: descriptionController.text,
      eventImage: widget.event.eventImage,
      eventName: widget.event.eventName,
      eventDate: selectedDate!,
      eventTime: formatTime,
    );


    eventListProvider.updateEvent(updatedEvent);
     eventListProvider.getAllEventsFromFireStore();
    Navigator.pop(context);

  }
}