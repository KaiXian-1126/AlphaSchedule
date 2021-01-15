import 'package:alpha_schedule/models/Calendar.dart';
import 'package:alpha_schedule/models/Event.dart';
import 'package:alpha_schedule/models/calener_task.dart';
import '../../models/mockdata.dart';
import '../../models/user.dart';

class CalendarServiceMock {
  List<Calendar> getCalendarList(User u) {
    return u.calendarList;
  }

  Calendar getCalendar(int index) {
    return calendar[index];
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

  List<Task> getTaskList() {
    return mycalender;
  }
}
