import 'package:alpha_schedule/app/dependencies.dart' as di;
import 'package:alpha_schedule/models/Calendar.dart';
import 'package:alpha_schedule/models/User.dart';
import 'package:alpha_schedule/services/calendar/calendar_service.dart';
import 'package:alpha_schedule/services/rest_service.dart';
import 'package:alpha_schedule/services/user/user_service.dart';

class UserServiceRest implements UserService {
  RestService rest = di.dependency();
  CalendarService calendarService = di.dependency();
  Future<List<User>> getUser() async {
    final result = await rest.get("user");
    return (result as List).map((e) => User.fromJson(e)).toList();
  }

  Future<User> createUser({User user}) async {
    final userInfo = await rest.post("user/create", data: user);
    final calendarInfo = await calendarService.createCalendar(id: userInfo.id);
    //Update user with created calendar
    //Need to do validation to ensure the email is unique.
    //return User.fromJson(result);
  }

  Future<User> updateUser() async {}
}
