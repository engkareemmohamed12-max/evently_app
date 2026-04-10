class Event {

  /// collectionName

  static const String collectionName = 'Events';

  /// attribute

  String id ;
  String title ;
  String description  ;
  String eventImage ;
  String eventName ;
  DateTime eventDate ;
  String eventTime ;
  bool isFavorite ;

  // Constructor

  Event({

    this.id = '',
    required this.title ,
    required this.description ,
    required this.eventImage ,
    required this.eventName ,
    required this.eventDate,
    required this.eventTime ,
     this.isFavorite = false
});


  // json => object

  Event.fromFireStore(Map<String , dynamic> data):this(

    id: data['id'],
    title: data['title'],
    description: data['description'],
    eventImage: data['event_image'],
    eventName: data['event_name'],
    eventDate: DateTime.fromMillisecondsSinceEpoch(data['event_date']),
    eventTime: data['event_time'],
    isFavorite: data['is_favorite'],
  );

  // object => json

  Map<String , dynamic> toFireStore(){

    return {

      'id' : id ,
      'title' : title ,
      'description' : description ,
      'event_image' : eventImage ,
      'event_name' : eventName,
      'event_date' : eventDate.millisecondsSinceEpoch ,
      'event_time' : eventTime ,
      'is_favorite' : isFavorite

  };
  }

}