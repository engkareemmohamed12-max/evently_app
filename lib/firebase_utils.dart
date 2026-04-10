import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently_app/model/event.dart';

class FirebaseUtils {

  static CollectionReference<Event> getEventCollection(){
    return FirebaseFirestore.instance.collection(Event.collectionName).
    withConverter<Event>(
      fromFirestore: (snapshot, options) =>
          Event.fromFireStore(snapshot.data()!)
      ,
      toFirestore: (event, options) => event.toFireStore(),
    );

  }


  static Future<void> addEventToFireStore(Event event){

    var collectionRef = getEventCollection(); // todo : collection

    var docRef = collectionRef.doc(); // todo : document

    event.id = docRef.id ; // todo : auto id
    return docRef.set(event);



}

}