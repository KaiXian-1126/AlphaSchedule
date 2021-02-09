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
    final result = await rest.get("calendar/getCalendarList/${user.userId}");
    return (result as List).map((e) => Calendar.fromJson(e)).toList();
  }

  Future<List<Calendar>> getCollaboratorCalendarList({User user}) async {
    final result =
        await rest.get("calendar/getCollaboratorCalendarList/${user.userId}");
    return (result as List).map((e) => Calendar.fromJson(e)).toList();
  }

  Future deleteCalendar({Calendar c}) async {
    await rest.delete("calendar/${c.calendarId}");
  }

  Future<Calendar> getCalendar({String cid}) async {
    final result = await rest.get("calendar/$cid");
    return Calendar.fromJson(result);
  }

  Future<List<User>> getCalendarMembers({Calendar c}) async {
    final result =
        await rest.get("calendar/getCalendarMembers/${c.calendarId}");
    return (result as List).map((e) => User.fromJson(e)).toList();
  }

  Future<Calendar> updateCalendar(
      {String id, String name, String description, String color}) async {
    final result = await rest.patch("calendar/update/$id", data: {
      'calendarName': name,
      'color': color,
      'description': description
    });
    return Calendar.fromJson(result);
  }

  Future<Calendar> updateAccessibility(
      {Calendar c, String accessibility}) async {
    final result = await rest.patch("calendar/update/${c.calendarId}",
        data: {"accessibility": accessibility});
    return Calendar.fromJson(result);
  }

  Future<Calendar> addCalendarCollaborator(
      {Calendar calendar, User member}) async {
    final result = await rest.patch(
        "calendar/add/${calendar.calendarId}/${member.userId}",
        data: {});
    return Calendar.fromJson(result);
  }

  //Update by remove the id
  Future<Calendar> deleteCalendarCollaborator(
      {Calendar calendar, User member}) async {
    final result = await rest.patch(
        "calendar/delete/${calendar.calendarId}/${member.userId}",
        data: {});
    return Calendar.fromJson(result);
  }

  //Remove self from collaboration
  Future<Calendar> removeSelfCollaboration(
      {Calendar calendar, User user}) async {
    //Calendar id and user id is required
    final result = await rest.patch("calendar/removeSelfCollaboration",
        data: {"calendarId": calendar.calendarId, "userId": user.userId});
    return Calendar.fromJson(result);
  }
}
