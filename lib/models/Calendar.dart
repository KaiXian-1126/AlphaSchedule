import 'package:alpha_schedule/models/Event.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Calendar {
  String calendarId;
  String calendarName;
  String description;
  Color color;
  List eventList;
  String ownerId;
  List membersId;
  String accessibility;
  Calendar({
    this.calendarId,
    this.calendarName,
    this.description,
    this.color,
    this.eventList,
    this.ownerId,
    this.membersId,
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
            ownerId: json['ownerId'],
            membersId: json['membersId'],
            accessibility: json['accessibility']);
  Map<String, dynamic> toJson() => {
        "id": calendarId,
        "calendarName": calendarName,
        "description": description,
        "color": color == Colors.blue[50] ? "Light Blue" : "Light Green",
        "eventList": eventList,
        "ownerId": ownerId,
        "membersId": membersId,
        "accessibility": accessibility
      };
}
