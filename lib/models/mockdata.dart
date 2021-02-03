import 'package:alpha_schedule/models/user_mock.dart';
import 'package:flutter/material.dart';
import 'Calendar.dart';
import 'Event.dart';

User mockData = User(
    userId: 1,
    name: 'shinwei',
    email: 'shinwei@gmail.com',
    password: '1234567',
    phone: '0123456789',
    gender: 'Male',
    calendarList: calendar);
List<User> mockUsers = [
  User(
      userId: 1,
      name: 'sw',
      email: 'shinwei@gmail.com',
      password: '1234',
      phone: '0123456789',
      gender: 'Male',
      calendarList: calendar),
  User(
      userId: 2,
      name: 'kaixian',
      email: 'kaixian@gmail.com',
      password: '1234',
      phone: '0123456789',
      gender: 'Male',
      calendarList: calendar),
  User(
      userId: 3,
      name: 'Ali',
      email: 'ali@gmail.com',
      password: '1234',
      phone: '0123456789',
      gender: 'Male',
      calendarList: calendar),
  User(
      userId: 4,
      name: 'ahmad',
      email: 'ahmad@gmail.com',
      password: '1234',
      phone: '0123456789',
      gender: 'Male',
      calendarList: calendar)
];
List<Calendar> calendar = [
  Calendar(
      calendarId: "1",
      calendarName: "Calendar 1",
      description: "This is Calendar 1",
      color: Colors.blue[50],
      eventList: eventList1,
      accessibility: "View Only",
      membersId: calendarMembers),
  Calendar(
      calendarId: "2",
      calendarName: "Calendar 2",
      description: "This is Calendar 2",
      color: Colors.blue[50],
      eventList: eventList2,
      accessibility: "Editable",
      membersId: calendarMembers),
  Calendar(
      calendarId: "3",
      calendarName: "Calendar 3",
      description: "This is Calendar 3",
      color: Colors.blue[50],
      eventList: eventList3,
      accessibility: "Editable",
      membersId: calendarMembers),
  Calendar(
      calendarId: "4",
      calendarName: "Calendar 4",
      description: "This is Calendar 4",
      color: Colors.blue[50],
      eventList: [
        Event(
            eventId: "1",
            eventName: "Event1",
            calendar: DateTime(2021, 1, 11),
            startTime: TimeOfDay(hour: 9, minute: 36),
            endTime: TimeOfDay(hour: 16, minute: 44),
            description: "This is a description")
      ],
      accessibility: "View Only",
      membersId: calendarMembers)
];
List<Event> eventList1 = [
  Event(
      eventId: "1",
      eventName: "Event1",
      calendar: DateTime(2021, 1, 11),
      startTime: TimeOfDay(hour: 9, minute: 36),
      endTime: TimeOfDay(hour: 16, minute: 44),
      description: "This is a description"),
  Event(
      eventId: "2",
      eventName: "Event2",
      calendar: DateTime(2021, 1, 11),
      startTime: TimeOfDay(hour: 9, minute: 36),
      endTime: TimeOfDay(hour: 16, minute: 44),
      description: "This is a description"),
  Event(
      eventId: "3",
      eventName: "Event3",
      calendar: DateTime(2021, 1, 12),
      startTime: TimeOfDay(hour: 9, minute: 36),
      endTime: TimeOfDay(hour: 16, minute: 44),
      description: "This is a description"),
  Event(
      eventId: "4",
      eventName: "Event4",
      calendar: DateTime(2021, 1, 12),
      startTime: TimeOfDay(hour: 9, minute: 36),
      endTime: TimeOfDay(hour: 16, minute: 44),
      description: "This is a description"),
  Event(
      eventId: "5",
      eventName: "Event5",
      calendar: DateTime(2021, 1, 30),
      startTime: TimeOfDay(hour: 9, minute: 36),
      endTime: TimeOfDay(hour: 16, minute: 44),
      description: "This is a description"),
  Event(
      eventId: "6",
      eventName: "Event6",
      calendar: DateTime(2021, 1, 16),
      startTime: TimeOfDay(hour: 8, minute: 20),
      endTime: TimeOfDay(hour: 9, minute: 30),
      description: "This is a description"),
  Event(
      eventId: "7",
      eventName: "Event7",
      calendar: DateTime(2021, 1, 30),
      startTime: TimeOfDay(hour: 7, minute: 00),
      endTime: TimeOfDay(hour: 12, minute: 44),
      description: "This is a description"),
];
List<Event> eventList2 = [
  Event(
      eventId: "6",
      eventName: "Event6",
      calendar: DateTime(2021, 1, 11),
      startTime: TimeOfDay(hour: 9, minute: 36),
      endTime: TimeOfDay(hour: 16, minute: 44),
      description: "This is a description"),
  Event(
      eventId: "7",
      eventName: "Event7",
      calendar: DateTime(2021, 1, 11),
      startTime: TimeOfDay(hour: 9, minute: 36),
      endTime: TimeOfDay(hour: 16, minute: 44),
      description: "This is a description"),
  Event(
      eventId: "8",
      eventName: "Event8",
      calendar: DateTime(2021, 1, 12),
      startTime: TimeOfDay(hour: 9, minute: 36),
      endTime: TimeOfDay(hour: 16, minute: 44),
      description: "This is a description"),
];
List<Event> eventList3 = [
  Event(
      eventId: "9",
      eventName: "Event9",
      calendar: DateTime(2021, 1, 11),
      startTime: TimeOfDay(hour: 9, minute: 36),
      endTime: TimeOfDay(hour: 16, minute: 44),
      description: "This is a description"),
  Event(
      eventId: "10",
      eventName: "Event10",
      calendar: DateTime(2021, 1, 11),
      startTime: TimeOfDay(hour: 9, minute: 36),
      endTime: TimeOfDay(hour: 16, minute: 44),
      description: "This is a description"),
];
List<User> calendarMembers = [
  User(
      name: "Tan Zhi Quan",
      email: "tanzhiquan@gmail.com",
      gender: "Male",
      password: "123",
      phone: "0123456789",
      userId: 10),
  User(
      name: "Tok Kai Xian",
      email: "tokkaixian@gmail.com",
      gender: "Male",
      password: "123",
      phone: "0123456789",
      userId: 11),
  User(
      name: "Tan Wei Kok",
      email: "tanweikok@gmail.com",
      gender: "Male",
      password: "123",
      phone: "0123456789",
      userId: 12),
];
