import 'package:alpha_schedule/models/Calendar.dart';
import 'package:alpha_schedule/models/Event.dart';
import 'package:alpha_schedule/services/event/event_service.dart';
import 'package:alpha_schedule/services/rest_service.dart';
import 'package:alpha_schedule/app/dependencies.dart' as di;

class EventServiceRest implements EventService {
  RestService rest = di.dependency();
  Future<List<Calendar>> getEventList({Calendar c}) async {
    final result = await rest.get("/calendar/getList/${c.calendarId}");
    return (result as List).map((e) => Event.fromJson(e)).toList();
  }
}
