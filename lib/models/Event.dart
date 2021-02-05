import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Event {
  String eventId;
  String eventName;
  DateTime calendar;
  TimeOfDay startTime, endTime;
  String description;
  String calendarId;
  Event(
      {this.eventId,
      this.eventName,
      this.calendar,
      this.startTime,
      this.endTime,
      this.description,
      this.calendarId});
  //For front-end used
  String timeToStringConverter(TimeOfDay time) {
    String stringTime = time.toString();
    stringTime = stringTime.substring(10, 15);
    if (int.parse(stringTime.substring(0, 2)) > 12) {
      int hour = int.parse(stringTime.substring(0, 2)) - 12;
      String stringHour = "$hour";
      if (hour < 10) {
        stringHour = "0$hour";
      }
      stringTime = "$stringHour${stringTime.substring(2)}";
      stringTime = "$stringTime PM";
    } else if (int.parse(stringTime.substring(0, 2)) == 12) {
      stringTime = "$stringTime PM";
    } else if (int.parse(stringTime.substring(0, 2)) == 0) {
      stringTime = "12${stringTime.substring(2)} AM";
    } else {
      stringTime = "$stringTime AM";
    }
    return stringTime;
  }

  String dateToStringConverter(DateTime date) {
    String stringDate = DateFormat('yyyy-MM-dd').format(date);
    return stringDate;
  }

  DateTime stringDateToDateConverter(String stringDate) {
    String stringYear = stringDate.split("-")[0];
    String stringMonth = stringDate.split("-")[1];
    String stringDay = stringDate.split("-")[2];
    int year = int.parse(stringYear),
        month = int.parse(stringMonth),
        day = int.parse(stringDay);
    return DateTime(year, month, day);
  }

  TimeOfDay stringTimeToTimeConverter(String stringTime) {
    String stringHour = stringTime.split(":")[0];
    String stringMinute = stringTime.split(":")[1].split(" ")[0];
    String session = stringTime.split(":")[1].split(" ")[1];
    int hour = 0, minute = int.parse(stringMinute);
    if (session == "PM") {
      hour = int.parse(stringHour) + 12;
    } else if (stringHour != "00") {
      hour = int.parse(stringHour);
    }

    return TimeOfDay(hour: hour, minute: minute);
  }

  Event.copy(Event from)
      : this(
            eventId: from.eventId,
            eventName: from.eventName,
            calendar: from.calendar,
            startTime: from.startTime,
            endTime: from.endTime,
            description: from.description,
            calendarId: from.calendarId);
  //How to store the data time and calendar
  Event.fromJson(Map<String, dynamic> json) {
    calendar = stringDateToDateConverter(json['calendar']);
    startTime = stringTimeToTimeConverter(json['startTime']);
    endTime = stringTimeToTimeConverter(json['endTime']);
    eventId = json['id'];
    eventName = json['eventName'];
    description = json['description'];
    calendarId = json['calendarId'];
  }

  Map<String, dynamic> toJson() => {
        "id": eventId,
        "eventName": eventName,
        "calendar": "${dateToStringConverter(calendar)}",
        "startTime": '${timeToStringConverter(startTime)}',
        "endTime": "${timeToStringConverter(endTime)}",
        "description": description,
        "calendarId": calendarId
      };
}
