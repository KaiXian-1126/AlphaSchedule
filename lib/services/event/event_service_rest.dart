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
    final result = await rest.get("event/getList/${c.calendarId}");
    //Get the event information and push to list
    List<Event> list = (result as List).map((e) => Event.fromJson(e)).toList();
    if (date == null) date = DateTime.now();
    String strDate = Event().dateToStringConverter(date);
    date = Event().stringDateToDateConverter(strDate);
    List<Event> eventList = [];

    if (currentTime == null) return list;
    list.forEach((e) {
      if (e.calendar == date) eventList.add(e);
    });
    //Return the event list
    return eventList;
  }

  Future<Event> getEvent({String id}) async {
    final json = await rest.get("event/get/$id");
    return Event.fromJson(json);
  }

  Future<Event> updateEvent(
      {String id,
      String name,
      String startTime,
      String endTime,
      String desc}) async {
    final json = await rest.patch("event/update/$id", data: {
      'eventName': name,
      'startTime': startTime,
      'endTime': endTime,
      'description': desc
    });
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
