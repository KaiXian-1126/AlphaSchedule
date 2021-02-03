import 'package:alpha_schedule/models/Calendar.dart';

class User {
  int userId;
  String name;
  String email;
  String password;
  String phone;
  String gender;
  List calendarList;
  List collaboratorCalendarList;
  User(
      {this.userId,
      this.name,
      this.email,
      this.password,
      this.phone,
      this.gender,
      this.calendarList,
      this.collaboratorCalendarList});
  User.clone(User from)
      : this(
            userId: from.userId,
            name: from.name,
            email: from.email,
            password: from.password,
            phone: from.phone,
            gender: from.gender,
            calendarList: from.calendarList,
            collaboratorCalendarList: from.collaboratorCalendarList);
  User.fromJson(Map<String, dynamic> json)
      : this(
            userId: json['id'],
            name: json['name'],
            email: json['email'],
            phone: json['phone'],
            gender: json['gender'],
            password: json['password'],
            calendarList: json['calendarList'],
            collaboratorCalendarList: json['collaboratorCalendarList']);
  Map<String, dynamic> toJson() => {
        'id': userId,
        'name': name,
        'email': email,
        'gender': gender,
        'password': password,
        'calendarList': calendarList,
        'collaboratorCalendarList': collaboratorCalendarList
      };
}
