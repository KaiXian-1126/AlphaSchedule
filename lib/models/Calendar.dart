import 'package:alpha_schedule/models/Event.dart';
import 'package:alpha_schedule/models/User.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Calendar {
  int calendarId;
  String calendarName;
  String description;
  Color color;
  List<Event> eventList;
  User owner;
  List<User> members;
  String accessibility;
  Calendar({
    this.calendarId,
    this.calendarName,
    this.description,
    this.color,
    this.eventList,
    this.owner,
    this.members,
    this.accessibility = "View Only",
  });
  Calendar.fromJson(Map<String, dynamic> json)
      : this(
            calendarId: json['id'],
            calendarName: json['calendarName'],
            description: json['description'],
            color: json['color'] == "Light Blue"
                ? Colors.blue[50]
                : Colors.green[50],
            eventList: json['eventList'],
            owner: json['owner'],
            members: json['members'],
            accessibility: json['accessibility']);
}
