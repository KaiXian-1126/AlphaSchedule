import 'package:alpha_schedule/models/mockdata.dart';
import 'package:alpha_schedule/models/user.dart';

class UserServiceMock {
  List<User> getUserList() {
    return mockUsers;
  }

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
