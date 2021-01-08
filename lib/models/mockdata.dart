import 'package:alpha_schedule/models/user.dart';
import 'package:flutter/material.dart';
import 'Calendar.dart';
import 'Event.dart';

User mockData = User(
    name: 'shinwei',
    email: 'shinwei@gmail.com',
    password: '1234567',
    phone: '0123456789',
    gender: 'Male');

List<Calendar> calendar = [
  Calendar(
    calendarName: "Calendar 1",
    description: "This is Calendar 1",
    color: Colors.blue,
  ),
  Calendar(
    calendarName: "Calendar 2",
    description: "This is Calendar 2",
    color: Colors.blue,
  ),
  Calendar(
    calendarName: "Calendar 3",
    description: "This is Calendar 3",
    color: Colors.blue,
  ),
  Calendar(
    calendarName: "Calendar 4",
    description: "This is Calendar 4",
    color: Colors.blue,
  )
];
List<Event> event = [
  Event(eventName: "Event1"),
  Event(eventName: "Event2"),
  Event(eventName: "Event3"),
  Event(eventName: "Event4"),
  Event(eventName: "Event5"),
  Event(eventName: "Event6")
];
