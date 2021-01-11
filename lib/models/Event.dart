import 'package:flutter/material.dart';

class Event {
  String eventName;
  DateTime calendar;
  TimeOfDay startTime, endTime;
  String description;
  Event({this.eventName});
}
