import 'package:alpha_schedule/models/Calendar.dart';
import 'package:alpha_schedule/models/Event.dart';
import 'package:alpha_schedule/services/event/event_service.dart';
import 'package:alpha_schedule/services/rest_service.dart';
import 'package:alpha_schedule/app/dependencies.dart' as di;
import 'package:intl/intl.dart';

class EventServiceRest implements EventService {
  RestService rest = di.dependency();

  /* Future<List<Event>> getEventList(
      {Calendar c, DateTime date, DateTime currentTime}) async {
    // convert dateTime to string
    String selectedDate = DateFormat('yyyy-MM-dd').format(date);
    //Get the event information in json form
    final result = await rest.get("/event/getList/${c.calendarId}");
    //Get the event information and push to list
    List<Event> list = (result as List).map((e) => Event.fromJson(e)).toList();
    print(list.length);

    List<Event> test = [];
    for (int i = 0; i < list.length; i++) {
      if (list[i].calendar.compareTo(selectedDate) == 0) {
        test.add(list[0]);
      }
    }
    print(test.length);
    List<Event> eventList = [];

    //Return the event list
    return test;
  }*/
  Future<List<Event>> getEventList(
      {Calendar c, String date, String currentTime}) async {
    //Get the event information in json form
    final result = await rest.get("/event/getList/${c.calendarId}");
    //Get the event information and push to list
    List<Event> list = (result as List).map((e) => Event.fromJson(e)).toList();
    print(list.length);
    List<Event> eventList = [];
    if (date != null) {
      for (int i = 0; i < list.length; i++) {
        if (list[i].calendar.compareTo(date) == 0) {
          eventList.add(list[0]);
        }
      }
    } else if (list == null) {
      return eventList;
    } else {}

    print(eventList.length);
    //Return the event list
    return eventList;
  }

  Future<Event> getEvent({String id}) async {
    final json = await rest.get("/event/get/$id");
    return Event.fromJson(json);
  }

  Future<Event> updateEvent({String id, Event event}) async {
    final json = await rest.patch("/event/update/$id", data: event);
    return Event.fromJson(json);
  }

  Future<Event> createEvent({String calendarId, Event event}) async {
    final json = await rest.post("event/create/$calendarId", data: event);
    return Event.fromJson(json);
  }

  Future deleteEvent({String id}) async {
    await rest.delete("event/delete/$id");
  }
}
