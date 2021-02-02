import 'package:alpha_schedule/app/dependencies.dart' as di;
import 'package:alpha_schedule/models/Calendar.dart';
import 'package:alpha_schedule/models/User.dart';
import 'package:alpha_schedule/services/calendar/calendar_service.dart';
import 'package:alpha_schedule/services/rest_service.dart';

class CalendarServiceRest implements CalendarService {
  RestService rest = di.dependency();
  Future<Calendar> createCalendar({String id, Calendar data}) async {
    //here forgot to pass the data to create the calendar
    final result = await rest.post("calendar/$id", data: data.toJson());
    return Calendar.fromJson(result);
  }

  Future<List<Calendar>> getCalendarList({User user}) async {
    final result = await rest.get("/calendar/getList/${user.userId}");
    return (result as List).map((e) => Calendar.fromJson(e)).toList();
  }

  Future<List<Calendar>> getCollaboratorCalendarList({User user}) async {
    final result =
        await rest.get("/calendar/getCollaboratorList/${user.userId}");
    return (result as List).map((e) => Calendar.fromJson(e)).toList();
  }

  Future<Calendar> getCalendar() {}
  Future<Calendar> updateCalendar() {}
  Future deleteCalendar() {}
}
