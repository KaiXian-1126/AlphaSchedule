import 'package:alpha_schedule/models/Event.dart';
import 'package:flutter/cupertino.dart';

class Calendar {
  int calendarId;
  String calendarName;
  String description;
  Color color;
  List<Event> eventList;
  Calendar(
      {this.calendarId,
      this.calendarName,
      this.description,
      this.color,
      this.eventList});
}
