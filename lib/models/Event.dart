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
}
