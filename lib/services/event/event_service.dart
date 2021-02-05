import 'package:alpha_schedule/models/Calendar.dart';
import 'package:alpha_schedule/models/Event.dart';

abstract class EventService {
  Future<List<Event>> getEventList(
      {Calendar c, DateTime date, DateTime currentTime});
  Future<Event> getEvent({String id});
  Future<Event> updateEvent({String id, Event event});
  Future<Event> createEvent({String calendarId, Event event});
  Future deleteEvent({String id});
}
