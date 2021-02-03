import 'package:alpha_schedule/models/Calendar.dart';
import 'package:alpha_schedule/models/Event.dart';

abstract class EventService {
  Future<List<Event>> getEventList(
      {Calendar c, DateTime date, DateTime currentTime});
  Future<Event> getEvent({int id});
  Future<Event> updateEvent({int id, Event event});
  Future<Event> createEvent({Calendar c, Event event});
  Future deleteEvent({int id});
}
