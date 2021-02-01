import 'package:alpha_schedule/models/Calendar.dart';

abstract class CalendarService {
  Future<Calendar> createCalendar({String id});
  Future<List<Calendar>> getCalendarList();
  Future<Calendar> getCalendar();
  Future<Calendar> updateCalendar();
  Future deleteCalendar();
}
