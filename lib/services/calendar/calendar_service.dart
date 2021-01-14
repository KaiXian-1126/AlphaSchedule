import 'package:alpha_schedule/models/Calendar.dart';
import 'package:alpha_schedule/models/Event.dart';

abstract class CalendarService {
  Future<List<Calendar>> getCalendarList();
  Future<Calendar> getCalendar();
  Future<Calendar> updateCalendar();
  Future deleteCalendar();
  Future<List<Event>> getEventList();
  Future<Event> getEvent();
  Future<Event> addEvent();
  Future<Event> updateEvent();
  Future deleteEvent();
}
