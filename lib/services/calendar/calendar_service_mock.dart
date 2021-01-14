import 'package:alpha_schedule/models/Calendar.dart';
import 'package:alpha_schedule/models/Event.dart';

class CalendarServiceMock {
  Future<List<Calendar>> getCalendarList() {
    return null;
  }

  Future<Calendar> getCalendar() {
    return null;
  }

  Future<Calendar> updateCalendar() {
    return null;
  }

  Future deleteCalendar() {
    return null;
  }

  List<Event> getEventList(Calendar c) {
    return c.eventList;
  }

  Event getEvent(Calendar c, int index) {
    return c.eventList[index];
  }

  String getEventName(Calendar c, int index) {
    return c.eventList[index].eventName;
  }

  Future<Event> addEvent() {
    return null;
  }

  Future<Event> updateEvent() {
    return null;
  }

  Future deleteEvent() {
    return null;
  }
}
