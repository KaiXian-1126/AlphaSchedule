import 'package:alpha_schedule/models/Calendar.dart';
import 'package:alpha_schedule/models/Event.dart';
import 'package:flutter/material.dart';

abstract class EventService {
  Future<List<Event>> getEventList(
      {Calendar c, DateTime date, DateTime currentTime});
  Future<Event> getEvent({String id});
  Future<Event> updateEvent(
      {String id, String name, String startTime, String endTime, String desc});
  Future<Event> createEvent({String id, Event event});
  Future deleteEvent({String id});
}
