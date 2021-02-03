import 'package:alpha_schedule/models/Calendar.dart';
import 'package:alpha_schedule/models/User.dart';

abstract class CalendarService {
  Future<Calendar> createCalendar({String id, Calendar data});
  Future<List<Calendar>> getCalendarList({User user});
  Future<List<Calendar>> getCollaboratorCalendarList({User user});
  Future<Calendar> getCalendar({String cid});
  Future<Calendar> updateCalendar();
  Future deleteCalendar();
}
