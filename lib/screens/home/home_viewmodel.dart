import 'package:alpha_schedule/models/Calendar.dart';
import 'package:alpha_schedule/models/Event.dart';
import 'package:alpha_schedule/screens/viewmodel.dart';
import 'package:alpha_schedule/services/calendar/calendar_service.dart';
import 'package:alpha_schedule/services/event/event_service.dart';
import '../../app/dependencies.dart';
import '../../models/User.dart';

class HomeViewmodel extends Viewmodel {
  User user;
  Calendar currentCalendar;
  int currentCalendarIndex = 0;
  List<Calendar> ownCalendars = [],
      collaboratorCalendars = [],
      allCalendars = [];
  List<Event> dayEvents = [], allEvents = [];
  CalendarService get calendarService => dependency();
  EventService get eventService => dependency();
  bool onViewOnlyMode = false;
  DateTime selectedDate;
  void getCalendarList() async {
    turnBusy();
    ownCalendars = await calendarService.getCalendarList(user: user);
    currentCalendar = ownCalendars[currentCalendarIndex];

    collaboratorCalendars =
        await calendarService.getCollaboratorCalendarList(user: user);

    ownCalendars.forEach((e) => allCalendars.add(e));
    collaboratorCalendars.forEach((e) => allCalendars.add(e));
    dayEvents = await eventService.getEventList(
        c: currentCalendar, date: DateTime.now(), currentTime: DateTime.now());
    allEvents = await eventService.getEventList(c: currentCalendar);

    turnIdle();
  }

  void getCollaboratorCalendarList() async {
    collaboratorCalendars =
        await calendarService.getCollaboratorCalendarList(user: user);
  }

  void getDayEventList(DateTime selectedDay) async {
    selectedDate = selectedDay;
    dayEvents = await eventService.getEventList(
        c: currentCalendar, date: selectedDay, currentTime: selectedDay);
    notifyListeners();
  }

  void deleteCalendar(int index) async {
    await calendarService.deleteCalendar(c: allCalendars[index]);
    ownCalendars.removeAt(index);
    allCalendars.removeAt(index);
    currentCalendarIndex = 0;
    currentCalendar = allCalendars[currentCalendarIndex];
    notifyListeners();
  }

  void deleteEvent(int index) async {
    await eventService.deleteEvent(id: dayEvents[index - 1].eventId);
    for (int i = 0; i < allEvents.length; i++) {
      if (allEvents[i].eventId == dayEvents[index - 1].eventId) {
        allEvents.removeAt(i);
        break;
      }
    }
    dayEvents.removeAt(index - 1);
    notifyListeners();
  }

  void printAllCalendar() {
    ownCalendars.forEach((e) => print(e.calendarName));
    print("---");
    collaboratorCalendars.forEach((e) => print(e.calendarName));
    print("all---");
    allCalendars.forEach((e) => print(e.calendarName));
  }

  void removeCollaborateCalendar(Calendar calendar, int index) async {
    await calendarService.removeSelfCollaboration(
        calendar: calendar, user: user);
    allCalendars.removeAt(ownCalendars.length + index);
    collaboratorCalendars.removeAt(index);
    notifyListeners();
  }

  Future<void> setCurrentCalendar({Calendar calendar, int index}) async {
    currentCalendar = calendar;
    dayEvents = await eventService.getEventList(
        c: currentCalendar, date: selectedDate, currentTime: selectedDate);
    if (index > ownCalendars.length - 1) {
      if (calendar.accessibility == "View Only") {
        onViewOnlyMode = true;
      } else {
        onViewOnlyMode = false;
      }
    } else {
      onViewOnlyMode = false;
    }
    notifyListeners();
  }

  get rebuild => notifyListeners();
}
