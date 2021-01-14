import 'package:alpha_schedule/models/Calendar.dart';

class User {
  int userId;
  String name;
  String email;
  String password;
  String phone;
  String gender;
  List<Calendar> calendarList;
  User(
      {this.userId,
      this.name,
      this.email,
      this.password,
      this.phone,
      this.gender,
      this.calendarList});
  User.clone(User from)
      : this(
            userId: from.userId,
            name: from.name,
            email: from.email,
            password: from.password,
            phone: from.phone,
            gender: from.gender,
            calendarList: from.calendarList);
}
