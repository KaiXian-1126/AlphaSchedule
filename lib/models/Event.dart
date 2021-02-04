import 'package:flutter/material.dart';

class Event {
  String eventId;
  String eventName;
  String calendar;
  String startTime;
  String endTime;
  String description;
  Event(
      {this.eventId,
      this.eventName,
      this.calendar,
      this.startTime,
      this.endTime,
      this.description});
  //For front-end used
  String timeToStringConverter(TimeOfDay time) {
    String stringTime = time.toString();
    stringTime = stringTime.substring(10, 15);
    if (int.parse(stringTime.substring(0, 2)) >= 12)
      stringTime = "$stringTime PM";
    else
      stringTime = "$stringTime AM";
    return stringTime;
  }

  Event.copy(Event from)
      : this(
          eventId: from.eventId,
          eventName: from.eventName,
          calendar: from.calendar,
          startTime: from.startTime,
          endTime: from.endTime,
          description: from.description,
        );
  //How to store the data time and calendar
  Event.fromJson(Map<String, dynamic> json)
      : this(
            eventId: json['id'],
            eventName: json['eventName'],
            calendar: json['calendar'],
            startTime: json['startTime'],
            endTime: json['endTime'],
            description: json['description']);
  Map<String, dynamic> toJson() => {
        "id": eventId,
        "eventName": eventName,
        "calendar": calendar,
        "startTime": startTime,
        "endTime": endTime,
        "description": description
      };
}
