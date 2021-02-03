import 'package:alpha_schedule/app/dependencies.dart' as di;
import 'package:alpha_schedule/models/Calendar.dart';
import 'package:alpha_schedule/models/User.dart';
import 'package:alpha_schedule/services/calendar/calendar_service.dart';
import 'package:alpha_schedule/services/rest_service.dart';
import 'package:alpha_schedule/services/user/user_service.dart';
import 'package:flutter/material.dart';

class UserServiceRest implements UserService {
  RestService rest = di.dependency();
  CalendarService calendarService = di.dependency();
  Future<List<User>> getUserList() async {
    final result = await rest.get("user");
    return (result as List).map((e) => User.fromJson(e)).toList();
  }

  Future<User> getUser({String id}) async {
    final result = await rest.get('/user/$id');
    return User.fromJson(result);
  }

  Future<User> createUser({User user}) async {
    final userInfo = await rest.post("user/", data: user.toJson());
    final tempUser = User.fromJson(userInfo);
    // Create a new calendar for new user
    Calendar newCalendar = Calendar(
        calendarName: "Calendar 1",
        color: Colors.blue[50],
        description: "This is a calendar.",
        eventList: [],
        membersId: [],
        ownerId: "${tempUser.userId}",
        accessibility: "Editable");
    await calendarService.createCalendar(
        id: tempUser.userId.toString(), data: newCalendar);
    return User.fromJson(userInfo);
  }

  Future<User> updateUser({User user}) async {
    final userInfo = await rest.patch("user/${user.userId}");
    return User.fromJson(userInfo);
  }

  Future<User> updateUserProfile(
      {String id, String a, String b, int c, String d}) async {
    final result = await rest.patch('user/$id',
        data: {'name': a, 'email': b, 'phone': c, 'gender': d});
    return User.fromJson(result);
  }

  Future<User> updateUserPassword({String id, String a}) async {
    final result = await rest.patch('user/$id', data: {'password': a});
    return User.fromJson(result);
  }
}
