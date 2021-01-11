import 'package:alpha_schedule/models/user.dart';
import 'package:flutter/material.dart';
import 'Calendar.dart';
import 'Event.dart';
import 'calener_task.dart';

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
