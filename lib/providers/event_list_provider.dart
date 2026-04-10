import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently_app/ui/utils/app_color.dart';
import 'package:evently_app/ui/utils/toast_utils.dart';
import 'package:flutter/material.dart';

import '../firebase_utils.dart';
import '../l10n/app_localizations.dart';
import '../model/event.dart';

class EventListProvider extends ChangeNotifier {

  // todo : data
  List<Event> eventList = [];
  int selectedIndex = 0 ;
  List<String> eventNamesList = [];
  List<Event> filterList = [];
  List<Event> favoriteList = [];


  void getEventsNameList(BuildContext context){

     eventNamesList = [

      AppLocalizations.of(context)!.all,
      AppLocalizations.of(context)!.sport,
      AppLocalizations.of(context)!.birthday,
      AppLocalizations.of(context)!.meeting,
      AppLocalizations.of(context)!.book_club,
      AppLocalizations.of(context)!.exhibition

    ];

  }





  void getAllEventsFromFireStore() async {
    QuerySnapshot<Event> querySnapshot =
    await FirebaseUtils.getEventCollection().get();

    eventList = querySnapshot.docs.map((doc) {
      Event event = doc.data();
      event.id = doc.id;
      return event;
    }).toList();

    filterList = List.from(eventList);

    filterList.sort((a, b) => a.eventDate.compareTo(b.eventDate));

    notifyListeners();
  }



  void getFilterEventsFromFireStore() async{

     // todo : get all event
     var querySnapshot = await FirebaseUtils.getEventCollection().orderBy
       ('event_time')
         .where('event_name' , isEqualTo: eventNamesList[selectedIndex]).
    get();

     filterList = querySnapshot.docs.map((doc) {
       Event event = doc.data();
       event.id = doc.id;
       return event;
     }).toList();

     // todo : sorting => datetime

     filterList.sort((event1, event2) {

       return event1.eventDate.compareTo(event2.eventDate);

     },);

     notifyListeners();

  }


  void changeSelectedIndex(int newSelectedIndex) {
    selectedIndex = newSelectedIndex;

    if (selectedIndex == 0) {
      filterList = List.from(eventList);
      filterList.sort((a, b) => a.eventDate.compareTo(b.eventDate));
      notifyListeners();
    } else {
      getFilterEventsFromFireStore();
    }
  }

  void updateIsFavorite(Event event){


     FirebaseUtils.getEventCollection().doc(event.id).
    update({'is_favorite': !event.isFavorite}).timeout(Duration(milliseconds: 500) , onTimeout: (){
      ToastUtils.toastMessage(
          message: ' Favorite Event Update',
          backgroundColor: Colors.green,
          textColor: AppColors.whiteColor);
      selectedIndex == 0 ? getAllEventsFromFireStore() : getFilterEventsFromFireStore(); getAllFavoriteEvents();
     });

     notifyListeners();

  }

  void getAllFavoriteEvents() async{

     var querySnapShot = await FirebaseUtils.getEventCollection().orderBy('event_date').where('is_favorite' ,isEqualTo: true).get();

     favoriteList = querySnapShot.docs.map((doc) {
       Event event = doc.data();
       event.id = doc.id;
       return event;
     }).toList();
     notifyListeners();

  }


  void updateEvent(Event event){
    FirebaseUtils.getEventCollection().doc(event.id).update(event.toFireStore()).timeout(Duration(milliseconds: 500));


    selectedIndex == 0 ? getAllEventsFromFireStore() : getFilterEventsFromFireStore();
    getAllFavoriteEvents();

    notifyListeners();

    ToastUtils.toastMessage(
      message: 'Event updated successfully',
      backgroundColor: Colors.green,
      textColor: AppColors.whiteColor,
    );

  }

  Future<void> deleteEvent(Event event) async {
    try {
      ToastUtils.toastMessage(
          message: 'Event delete',
          backgroundColor: Colors.green,
          textColor: AppColors.whiteColor);


      eventList.removeWhere((e) => e.id == event.id);
      filterList.removeWhere((e) => e.id == event.id);
      favoriteList.removeWhere((e) => e.id == event.id);

      notifyListeners();

      await FirebaseUtils.getEventCollection()
          .doc(event.id)
          .delete();

      print("DELETE DONE");

    } catch (e) {
      print("DELETE ERROR: $e");
    }


  }
}