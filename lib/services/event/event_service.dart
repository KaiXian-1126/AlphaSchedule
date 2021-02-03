import 'package:alpha_schedule/models/Calendar.dart';
import 'package:alpha_schedule/models/Event.dart';

abstract class EventService {
  Future<List<Event>> getEventList({Calendar c});
}
