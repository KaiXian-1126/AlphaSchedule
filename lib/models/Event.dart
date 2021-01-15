import 'package:flutter/material.dart';

class Event {
  int eventId;
  String eventName;
  DateTime calendar;
  TimeOfDay startTime, endTime;
  String description;
  Event(
      {this.eventId,
      this.eventName,
      this.calendar,
      this.startTime,
      this.endTime,
      this.description});
  String timeToStringConverter(TimeOfDay time) {
    String stringTime = time.toString();
    stringTime = stringTime.substring(10, 15);
    if (int.parse(stringTime.substring(0, 2)) >= 12)
      stringTime = "$stringTime PM";
    else
      stringTime = "$stringTime AM";
    print(stringTime);
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
}
