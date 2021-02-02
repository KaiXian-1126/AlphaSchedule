import 'package:alpha_schedule/app/dependencies.dart' as di;
import 'package:alpha_schedule/models/Calendar.dart';
import 'package:alpha_schedule/models/User.dart';
import 'package:alpha_schedule/services/calendar/calendar_service.dart';
import 'package:alpha_schedule/services/rest_service.dart';

class CalendarServiceRest implements CalendarService {
  RestService rest = di.dependency();
  Future<Calendar> createCalendar({String id, Calendar data}) async {
    final result = await rest.post("calendar/$id", data: data.toJson());
    return Calendar.fromJson(result);
  }

  Future<List<Calendar>> getCalendarList({User user}) async {
    final result = await rest.get("/calendar/getCalendarList/${user.userId}");
    return (result as List).map((e) => Calendar.fromJson(e)).toList();
  }

  Future<List<Calendar>> getCollaboratorCalendarList({User user}) async {
    final result =
        await rest.get("/calendar/getCollaboratorCalendarList/${user.userId}");
    return (result as List).map((e) => Calendar.fromJson(e)).toList();
  }

  Future deleteCalendar({Calendar c}) async {
    final result = await rest.delete("/calendar/${c.calendarId}");
    return Calendar.fromJson(result);
  }

  Future<Calendar> getCalendar({String cid}) async {
    final result = await rest.get("/calendar/$cid");
    return Calendar.fromJson(result);
  }

  Future<Calendar> updateCalendar() {}
}
