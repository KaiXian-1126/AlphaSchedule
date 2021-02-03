import 'package:alpha_schedule/models/User.dart';

abstract class UserServive {
  Future<List<User>> getUser();
  Future<User> createUser();
  Future<User> updateUserProfile();
  Future<User> updateUserPassword();
}
