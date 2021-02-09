import 'package:alpha_schedule/models/Calendar.dart';
import 'package:alpha_schedule/models/User.dart';

abstract class CalendarService {
  Future<Calendar> createCalendar({String id, Calendar data});
  Future<List<Calendar>> getCalendarList({User user});
  Future<List<Calendar>> getCollaboratorCalendarList({User user});
  Future<Calendar> getCalendar({String cid});
  Future<List<User>> getCalendarMembers({Calendar c});
  Future<Calendar> updateCalendar(
      {String id, String name, String description, String color});
  Future deleteCalendar({Calendar c});
  Future<Calendar> updateAccessibility({Calendar c, String accessibility});
  Future<Calendar> addCalendarCollaborator({Calendar calendar, User member});
  Future<Calendar> deleteCalendarCollaborator({Calendar calendar, User member});
}
