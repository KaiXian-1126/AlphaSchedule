import 'package:alpha_schedule/models/Calendar.dart';
import 'package:alpha_schedule/models/Event.dart';
import '../../models/user.dart';

class CalendarServiceMock {
  List<Calendar> getCalendarList(User u) {
    return u.calendarList;
  }

  Calendar getCalendar(int index, User u) {
    return u.calendarList[index];
  }

  List<Event> getEventList(Calendar c, DateTime date, DateTime currentTime) {
    List<Event> event = [];
    if (date == null) {
      for (int i = 0; i < c.eventList.length; i++) {
        if (c.eventList[i].calendar.year.toString() ==
                currentTime.year.toString() &&
            c.eventList[i].calendar.month.toString() ==
                currentTime.month.toString() &&
            c.eventList[i].calendar.day.toString() ==
                currentTime.day.toString()) {
          event.add(c.eventList[i]);
        }
      }
    } else if (c.eventList == null) {
      return event;
    } else {
      for (int i = 0; i < c.eventList.length; i++) {
        if (c.eventList[i].calendar.year.toString() == date.year.toString() &&
            c.eventList[i].calendar.month.toString() == date.month.toString() &&
            c.eventList[i].calendar.day.toString() == date.day.toString()) {
          event.add(c.eventList[i]);
        }
      }
    }
    return event;
  }

  Event getEvent(Event c) {
    return c;
  }

  String getEventName(Event c) {
    return c.eventName;
  }
}
