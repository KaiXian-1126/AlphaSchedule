import 'package:alpha_schedule/models/Event.dart';
import 'package:alpha_schedule/models/User.dart';
import 'package:flutter/cupertino.dart';

class Calendar {
  int calendarId;
  String calendarName;
  String description;
  Color color;
  List<Event> eventList;
  List<User> members;
  String accessibility;
  Calendar({
    this.calendarId,
    this.calendarName,
    this.description,
    this.color,
    this.eventList,
    this.members,
    this.accessibility = "View Only",
  });
}
