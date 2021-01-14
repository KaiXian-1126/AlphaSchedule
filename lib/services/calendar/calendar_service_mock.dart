import 'package:alpha_schedule/models/Calendar.dart';
import 'package:alpha_schedule/models/Event.dart';
import 'calendar_service.dart';

class CalendarServiceMock implements CalendarService {
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

  Future<List<Event>> getEventList() {
    return null;
  }

  Future<Event> getEvent() {
    return null;
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
