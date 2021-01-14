import 'package:alpha_schedule/models/user.dart';

abstract class UserServive {
  Future<List<User>> getUser();
  Future<User> createUser();
  Future<User> updateUser();
}
