import 'package:alpha_schedule/models/Event.dart';
import 'package:flutter/cupertino.dart';

class Calendar {
  String calendarName;
  String description;
  Color color;
  List<Event> eventList;
  Calendar({this.calendarName, this.description, this.color});
}
