import 'package:alpha_schedule/models/Calendar.dart';
import 'package:alpha_schedule/models/Event.dart';
import 'package:alpha_schedule/services/event/event_service.dart';
import 'package:alpha_schedule/services/rest_service.dart';
import 'package:alpha_schedule/app/dependencies.dart' as di;

class EventServiceRest implements EventService {
  RestService rest = di.dependency();

  Future<List<Event>> getEventList(
      {Calendar c, DateTime date, DateTime currentTime}) async {
    //Get the event information in json form
    final result = await rest.get("/event/getList/${c.calendarId}");
    //Get the event information and push to list
    List<Event> list = (result as List).map((e) => Event.fromJson(e)).toList();

    List<Event> eventList = [];
    if (date == null) {
      for (int i = 0; i < result.length; i++) {
        if (list[i].calendar.year.toString() == currentTime.year.toString() &&
            list[i].calendar.month.toString() == currentTime.month.toString() &&
            list[i].calendar.day.toString() == currentTime.day.toString()) {
          eventList.add(list[i]);
        }
      }
    } else if (list == null) {
      return eventList;
    } else {
      for (int i = 0; i < eventList.length; i++) {
        if (list[i].calendar.year.toString() == date.year.toString() &&
            list[i].calendar.month.toString() == date.month.toString() &&
            list[i].calendar.day.toString() == date.day.toString()) {
          eventList.add(eventList[i]);
        }
      }
    }
    //Return the event list
    return eventList;
  }

  Future<Event> getEvent({int id}) async {
    final json = await rest.get("/event/get/$id");
    return Event.fromJson(json);
  }

  Future<Event> updateEvent({int id, Event event}) async {
    final json = await rest.patch("/event/update/$id", data: event);
    return Event.fromJson(json);
  }

  Future<Event> createEvent({Calendar c, Event event}) async {
    final json = await rest.post("event/create/${c.calendarId}", data: event);
    return Event.fromJson(json);
  }

  Future deleteEvent({int id}) async {
    await rest.delete("event/delete/$id");
  }
}
