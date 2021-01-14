import 'package:alpha_schedule/models/user.dart';
import 'package:flutter/material.dart';
import 'Calendar.dart';
import 'Event.dart';
import 'calener_task.dart';

User mockData = User(
    userId: 1,
    name: 'shinwei',
    email: 'shinwei@gmail.com',
    password: '1234567',
    phone: '0123456789',
    gender: 'Male',
    calendarList: calendar);

List<Calendar> calendar = [
  Calendar(
    calendarId: 1,
    calendarName: "Calendar 1",
    description: "This is Calendar 1",
    color: Colors.blue,
    eventList: event,
  ),
  Calendar(
    calendarId: 2,
    calendarName: "Calendar 2",
    description: "This is Calendar 2",
    color: Colors.blue,
    eventList: event,
  ),
  Calendar(
    calendarId: 3,
    calendarName: "Calendar 3",
    description: "This is Calendar 3",
    color: Colors.blue,
    eventList: event,
  ),
  Calendar(
    calendarId: 4,
    calendarName: "Calendar 4",
    description: "This is Calendar 4",
    color: Colors.blue,
    eventList: event,
  )
];
List<Event> event = [
  Event(
      eventId: 1,
      eventName: "Event1",
      calendar: DateTime(2021),
      startTime: TimeOfDay(hour: 9, minute: 36),
      endTime: TimeOfDay(hour: 16, minute: 44),
      description: "This is a description"),
  Event(
      eventId: 2,
      eventName: "Event2",
      calendar: DateTime(2021),
      startTime: TimeOfDay(hour: 9, minute: 36),
      endTime: TimeOfDay(hour: 16, minute: 44),
      description: "This is a description"),
  Event(
      eventId: 3,
      eventName: "Event3",
      calendar: DateTime(2021),
      startTime: TimeOfDay(hour: 9, minute: 36),
      endTime: TimeOfDay(hour: 16, minute: 44),
      description: "This is a description"),
  Event(
      eventId: 4,
      eventName: "Event4",
      calendar: DateTime(2021),
      startTime: TimeOfDay(hour: 9, minute: 36),
      endTime: TimeOfDay(hour: 16, minute: 44),
      description: "This is a description"),
  Event(
      eventId: 5,
      eventName: "Event5",
      calendar: DateTime(2021),
      startTime: TimeOfDay(hour: 9, minute: 36),
      endTime: TimeOfDay(hour: 16, minute: 44),
      description: "This is a description"),
];
List<Task> mycalender = [
  Task(
      title: 'MAP Presentation',
      description: 'Discuss for teammate',
      startTime: '11.00 AM',
      endTime: '12.00 PM',
      date: '29/12/2012',
      day: 'Tuesday'),
  Task(
      title: 'Project discussion 2',
      description: 'Prepare Project Proposal',
      startTime: '14.00 PM',
      endTime: '16.00 PM',
      date: '25/12/2012',
      day: 'Friday'),
  Task(
      title: 'Project discussion 1',
      description: 'Meet with friend',
      startTime: '08.00 AM',
      endTime: '09.00 AM',
      date: '25/12/2012',
      day: 'Friday'),
  Task(
      title: 'AD Meeting',
      description: 'Meet with friend',
      startTime: '12.00 PM',
      endTime: '4.00 PM',
      date: '31/12/2012',
      day: 'Friday'),
  Task(
      title: 'AD Meeting',
      description: 'Meet with friend',
      startTime: '12.00 PM',
      endTime: '4.00 PM',
      date: '29/12/2012',
      day: 'Friday'),
];
