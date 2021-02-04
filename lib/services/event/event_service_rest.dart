import 'package:alpha_schedule/models/Calendar.dart';
import 'package:alpha_schedule/models/Event.dart';
import 'package:alpha_schedule/services/event/event_service.dart';
import 'package:alpha_schedule/services/rest_service.dart';
import 'package:alpha_schedule/app/dependencies.dart' as di;

class EventServiceRest implements EventService {
  RestService rest = di.dependency();

  Future<List<Event>> getEventList(
      {Calendar c, DateTime date, DateTime currentTime}) async {
    final result = await rest.get("/calendar/getList/${c.calendarId}");
    return (result as List).map((e) => Event.fromJson(e)).toList();
    //   List<Event> list = (result as List).map((e) => Event.fromJson(e)).toList();
    //   List<Event> eventList = [];
    //   if (date == null) {
    //     for (int i = 0; i < list.length; i++) {
    //       if (list[i].calendar.year.toString() == currentTime.year.toString() &&
    //           list[i].calendar.month.toString() == currentTime.month.toString() &&
    //           list[i].calendar.day.toString() == currentTime.day.toString()) {
    //         eventList.add(list[i]);
    //       }
    //     }
    //   } else if (list == null) {
    //     return null;
    //   } else {
    //     for (int i = 0; i < eventList.length; i++) {
    //       if (list[i].calendar.year.toString() == date.year.toString() &&
    //           list[i].calendar.month.toString() == date.month.toString() &&
    //           list[i].calendar.day.toString() == date.day.toString()) {
    //         eventList.add(eventList[i]);
    //       }
    //     }
    //   }
    //   return eventList;
  }

  Future<Event> getEvent({String id}) async {
    final json = await rest.get("/event/get/$id");
    return Event.fromJson(json);
  }

  Future<Event> updateEvent({String id, Event event}) async {
    final json = await rest.patch("/event/update/$id", data: event);
    return Event.fromJson(json);
  }

  Future<Event> createEvent({String id, Event event}) async {
    final json = await rest.post("event/create/$id", data: event);
    return Event.fromJson(json);
  }

  Future deleteEvent({String id}) async {
    await rest.delete("event/delete/$id");
  }
}
