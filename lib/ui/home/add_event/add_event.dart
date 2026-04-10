import 'package:evently_app/firebase_utils.dart';
import 'package:evently_app/l10n/app_localizations.dart';
import 'package:evently_app/model/event.dart';
import 'package:evently_app/providers/event_list_provider.dart';
import 'package:evently_app/providers/theme_provider.dart';
import 'package:evently_app/ui/home/add_event/date_or_time_widget.dart';
import 'package:evently_app/ui/home/widgets/tab_widget.dart';
import 'package:evently_app/ui/utils/app_assets.dart';
import 'package:evently_app/ui/utils/app_color.dart';
import 'package:evently_app/ui/utils/app_styles.dart';
import 'package:evently_app/ui/utils/toast_utils.dart';
import 'package:evently_app/ui/widget/custom_elevated_button.dart';
import 'package:evently_app/ui/widget/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../main.dart';
import '../../utils/app_route.dart';

class AddEvent extends StatefulWidget {
   AddEvent({super.key});

  @override
  State<AddEvent> createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
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

  List<String> eventNamesList = [];

  String? dateError;
  String? timeError;


  int selectedIndex = 0 ;
  var selectedEventImages = '' ; // todo : image
  var selectedEventName = '' ; // todo : name
  var title = ''; // todo : title
  var description = ''; // todo : description
  DateTime? selectedDate ; // todo : Date
  String formatDate = '' ;
  TimeOfDay? selectedTime ; // todo : time
  String formatTime = '' ;
  var formKey = GlobalKey<FormState>();
  late EventListProvider eventListProvider ;

  @override
  Widget build(BuildContext context) {

     eventNamesList = [
      AppLocalizations.of(context)!.sport,
      AppLocalizations.of(context)!.birthday,
      AppLocalizations.of(context)!.meeting,
      AppLocalizations.of(context)!.book_club,
      AppLocalizations.of(context)!.exhibition

    ];

    var width = context.width;
    var height = context.height;
    var themeProvider = Provider.of<ThemeProvider>(context);
    eventListProvider = Provider.of<EventListProvider>(context);

    selectedEventName = eventNamesList[selectedIndex];
    selectedEventImages = themeProvider.isDark ? eventImagesDarkList[selectedIndex] : eventImagesLightList[selectedIndex];

    return Scaffold(

      appBar: AppBar(
        toolbarHeight: height*0.10,
        leading: Container(
          margin: EdgeInsets.symmetric(
            horizontal: width*0.01,
            vertical: height*0.02
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadiusGeometry.circular(8),
            border: Border.all(
              color: Theme.of(context).dividerColor,
              width: 2
            ),
          ),
          child: IconButton(onPressed: (){

            Navigator.pushReplacementNamed(context, AppRoute.homeRouteName);

          }, icon: Icon(Icons.arrow_back_ios_new_outlined ,
          color: themeProvider.isDark ? AppColors.whiteColor : AppColors.blackColor ,
          )
          ),
        ),

        title: Text(AppLocalizations.of(context)!.add_event , style: Theme.of(context).textTheme.titleSmall,),
      ),

      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width*0.04,
          vertical: height*0.01,
          
        ),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: height*0.02,
              children: [
                SizedBox(
                  width: double.infinity,
                  height: height * 0.25,
                  child: Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadiusGeometry.circular(24),
                      border: Border.all(
                        color: Theme.of(context).dividerColor
                      ),
                    ),
            
                    child: Image.asset(
                      selectedEventImages
                    ),
            
                  ),
            
            
            
                ),
            
                SizedBox(
                  height: height * 0.05,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: eventNamesList.length,
                    separatorBuilder: (_, __) => SizedBox(width: 12),
                    itemBuilder: (context, index) {
                      bool isSelected = index == selectedIndex;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedIndex = index;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: isSelected
                                ? Theme.of(context).primaryColor
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: isSelected
                                  ? Theme.of(context).primaryColor
                                  : Theme.of(context).dividerColor,
                            ),
                          ),
                          child: Text(
                            eventNamesList[index],
                            textAlign: TextAlign.center,
                            style: isSelected
                                ? AppStyle.medium16White
                                : Theme.of(context).textTheme.headlineMedium,
                          ),
                        ),
                      );
                    },
                  ),
                ),
            
                Text(AppLocalizations.of(context)!.title ,
            
                style: Theme.of(context).textTheme.headlineMedium,
                ),
            
                CustomTextField(
            
                  hintText: AppLocalizations.of(context)!.event_title,
                  hintStyle: Theme.of(context).textTheme.bodyLarge,
                  onChanged: (text) {
                    title = text ;
                  },
                  validator: (text) {
                    if(text == null || text.trim().isEmpty){
                      return 'Please enter event title';
                    }
                    return null ;
                  },
                ),
            
            
                Text(AppLocalizations.of(context)!.title ,
            
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
            
                CustomTextField(
            
                  hintText: AppLocalizations.of(context)!.event_description,
                  hintStyle: Theme.of(context).textTheme.bodyLarge,
                  maxLines: 4,
                  onChanged: (text) {
                    description = text ;
                  },

                  validator: (text) {
                    if(text == null || text.trim().isEmpty){
                      return 'Please enter event description';
                    }
                    return null ;
                  },
                ),
            
                DateOrTimeItemWidget(
                    dateOrTimeIcon: Icon(Icons.date_range_outlined ,
                      color: Theme.of(context).cardColor,
                    ),
                    eventDateOrTime: AppLocalizations.of(context)!.event_date,
                    onChooseDateorTime: onChooseDate,
                    chooseDateOrTime: selectedDate == null ?
                    AppLocalizations.of(context)!.choose_date :
                        formatDate ,
                ),

                if(dateError != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 4, left: 8),
                    child: Text(
                      dateError!,
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 12,
                      ),
                    ),
                  ),

            
            
                DateOrTimeItemWidget(
                    dateOrTimeIcon: Icon(Icons.timer_outlined ,
                    color: Theme.of(context).cardColor,
                    ),
                    eventDateOrTime: AppLocalizations.of(context)!.event_time,
                    onChooseDateorTime: onChooseTime,
                    chooseDateOrTime: selectedTime == null ?
                    AppLocalizations.of(context)!.choose_time :
                formatTime
                ),

                if(timeError != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 4, left: 8),
                    child: Text(
                      timeError!,
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 12,
                      ),
                    ),
                  ),




            
                CustomElevatedButton(onPressed: addEvent,
                    backgroundColor: Theme.of(context).cardColor,
                    verticalPadding: height*0.02,
                    child: Text(AppLocalizations.of(context)!.add_event ,
                    style: AppStyle.medium20White,
                    )
                ),
            
                SizedBox(height: height*0.02,)
            
              ],
            ),
          ),
        ),
      ),


    );

  }
  void onChooseDate() async{
    
    var chooseDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365))
    );

    if(chooseDate != null){
      setState(() {
        selectedDate = chooseDate;
        dateError = null;
      });
    }

    if(selectedDate != null ){

      formatDate = DateFormat('MMM d,yyyy').format(selectedDate!);

    }
    setState(() {

    });
    
  }




  void onChooseTime() async{

    var chooseTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now()
    );

    if(chooseTime != null){
      setState(() {
        selectedTime = chooseTime;
        formatTime = selectedTime!.format(context);
        timeError = null;
      });
    }
  }




  void addEvent() {

    bool isValid = formKey.currentState?.validate() ?? false;

    if(selectedDate == null){
      setState(() {
        dateError = 'Please choose event date';
      });
      isValid = false;
    }




    if(selectedTime == null){
      setState(() {
        timeError = 'Please choose event time';
      });
      isValid = false;
    }

    if(!isValid) return;

    // todo: add event

    if(formKey.currentState?.validate() == true){

      // todo : add event to firebase

      Event event = Event(
          title: title,
          description: description,
          eventImage: selectedEventImages,
          eventName: selectedEventName,
          eventDate: selectedDate!,
          eventTime: formatTime);

      FirebaseUtils.addEventToFireStore(event).timeout(Duration(milliseconds: 500) ,
      onTimeout: () {

        // todo : toast

        ToastUtils.toastMessage(
            message: "event add successfully",
            backgroundColor: Colors.green,
            textColor: AppColors.whiteColor);


        // todo : get all event
        eventListProvider.getAllEventsFromFireStore();
        Navigator.pop(context);
      },
      );

    }


  }

}
