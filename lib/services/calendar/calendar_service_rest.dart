import 'package:alpha_schedule/app/dependencies.dart' as di;
import 'package:alpha_schedule/models/Calendar.dart';
import 'package:alpha_schedule/services/calendar/calendar_service.dart';
import 'package:alpha_schedule/services/rest_service.dart';

class CalendarSerivceRest implements CalendarService {
  RestService rest = di.dependency();
  Future<Calendar> createCalendar({String id}) async {
    final result = await rest.post("calendar/create/$id");
    return Calendar.fromJson(result);
  }

  Future<List<Calendar>> getCalendarList() {}
  Future<Calendar> getCalendar() {}
  Future<Calendar> updateCalendar() {}
  Future deleteCalendar() {}
}
