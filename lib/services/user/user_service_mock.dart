import 'package:alpha_schedule/app/dependencies.dart';
import 'package:alpha_schedule/models/user.dart';
import 'package:alpha_schedule/services/user/user_service.dart';

class UserServiceMock implements UserServive {
  final mock = dependency<UserServiceMock>();
  Future<List<User>> getUser() {
    return null;
  }

  Future<User> createUser() {
    return null;
  }

  Future<User> updateUser() {
    return null;
  }
}
